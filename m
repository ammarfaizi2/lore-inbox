Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136050AbRDVMKN>; Sun, 22 Apr 2001 08:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136052AbRDVMJx>; Sun, 22 Apr 2001 08:09:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25615 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136050AbRDVMJq>; Sun, 22 Apr 2001 08:09:46 -0400
Subject: Re: Linux 2.4.3-ac12
To: manuel@mclure.org (Manuel McLure)
Date: Sun, 22 Apr 2001 13:11:31 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010421211722.C976@ulthar.internal.mclure.org> from "Manuel McLure" at Apr 21, 2001 09:17:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rIiE-0005h2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > o	Further semaphore fixes				(David
> Howells)
> 
> rwsem.o(.text+0x73): undefined reference to `__builtin_expect'
> /usr/src/linux-2.4.3-ac12/lib/lib.a(rwsem.o): In function
> `rwsem_down_write_failed':

This is from Linus tree. You currently need gcc 2.96 or higher to build
the 2.4.x kernel. 

> rwsem.o(.text+0x1d3): undefined reference to `__builtin_expect'
> /usr/src/linux-2.4.3-ac12/lib/lib.a(rwsem.o): In function
> `rwsem_up_read_wake':
> rwsem.o(.text+0x2ed): undefined reference to `__builtin_expect'
> /usr/src/linux-2.4.3-ac12/lib/lib.a(rwsem.o): In function
> `rwsem_up_write_wake':rwsem.o(.text+0x3c6): undefined reference to
> `__builtin_expect'

Add a 

#define __builtin_expect

at the top of the rwsem code that uses this and let me know if its happy then.
If so I'll figure out the write gcc version checks
