Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUAaGEY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 01:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbUAaGEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 01:04:23 -0500
Received: from ozlabs.org ([203.10.76.45]:22680 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262598AbUAaGEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 01:04:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16408.59474.427408.682002@cargo.ozlabs.ibm.com>
Date: Thu, 29 Jan 2004 22:02:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: klibc list <klibc@zytor.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: long long on 32-bit machines
In-Reply-To: <4017F991.2090604@zytor.com>
References: <4017F991.2090604@zytor.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:

> Does anyone happen to know if there are *any* 32-bit architectures (on 
> which Linux runs) for which the ABI for a "long long" is different from 
> passing two "longs" in the appropriate order, i.e. (hi,lo) for bigendian 
> or (lo,hi) for littleendian?

Are you are talking about passing arguments to a function?  PPC32
passes long long arguments in two registers in the order you would
expect (hi, lo), BUT you have to use an odd/even register pair.  In
other words, if you have a function like this:

	int foo(int a, long long b)

then a will be passed in r3 and b will be passed in r5 and r6, and r4
will be unused.

Regards,
Paul.
