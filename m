Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUAXWDd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUAXWDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:03:32 -0500
Received: from ozlabs.org ([203.10.76.45]:51170 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261733AbUAXWDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:03:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16402.19894.686335.695215@cargo.ozlabs.ibm.com>
Date: Sat, 24 Jan 2004 21:49:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@trained-monkey.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] 2.6.1-mm5 compile do not use shared extable code for
 ia64
In-Reply-To: <16401.57298.175645.749468@napali.hpl.hp.com>
References: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
	<20040120090004.48995f2a.akpm@osdl.org>
	<16401.57298.175645.749468@napali.hpl.hp.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger writes:

> How about something along these lines?  If you want to standardize on
> a single instruction-address format, I'd strongly favor using the
> location-relative addresses used on Alpha and ia64 (it makes no sense
> to uses a full 64-bit address for those members).

Won't you have to change the offset when you move the entry, if the
value you store is relative to the address of the entry?  You could
get around that by storing the offset relative to the start of the
exception table, I guess.

Paul.
