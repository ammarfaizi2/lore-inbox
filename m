Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268989AbUIHO36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268989AbUIHO36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268227AbUIHO3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:29:42 -0400
Received: from the-village.bc.nu ([81.2.110.252]:14760 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268989AbUIHO27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:28:59 -0400
Subject: Re: PROBLEM: x86 alignment check bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@codemonkey.org.uk, hpa@zytor.com, bgerst@didntduck.org,
       Riley@Williams.Name
In-Reply-To: <413E498D.4020807@vmware.com>
References: <413E498D.4020807@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094649979.11678.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 14:26:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-08 at 00:51, Zachary Amsden wrote:
> Exception reporting for alignment check violations on x86 is broken 
> (unfortunately, rather badly, and rather hard to fix).  Look at the trap 
> function which fills in the si_addr field during an unaligned memory 
> access, 2.6.8.1-mm4+, arch/i386/kernel/traps.c, Line 522:

So it fills in a value with random data that should be zero. Ok thats
hardly "badly". 

> Clearly, this is not correct.  Considering how difficult the fix is (the 
> kernel must disassemble the faulting instruction and use register 
> information to determine the faulting address)

It would be a nice extension although it would break other OS's if it
used %cr2 for this since they use it for thread id.


