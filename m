Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269212AbRHLOIh>; Sun, 12 Aug 2001 10:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269236AbRHLOIR>; Sun, 12 Aug 2001 10:08:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34573 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269222AbRHLOIL>; Sun, 12 Aug 2001 10:08:11 -0400
Subject: Re: Reg:flow of system call in linux
To: sathish.j@tatainfotech.com (SATHISH.J)
Date: Sun, 12 Aug 2001 15:10:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10108121903130.26368-100000@blrmail> from "SATHISH.J" at Aug 12, 2001 07:05:35 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Vvwt-0005m5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can someone tell me about the flow of system call for eg. from open
> wrapper routine to sys_open() function or atleast please suggest me a
> book/website
> where I can get this info.

Userspace open() calls into glibc code
glibc does architecture dependant magic to make a syscall
The kernel syscall code does architecture dependant magic 
The kernel calls sys_open


In the x86 case the magic is basically

Load arguments into the right registers
int 0x80

then the kernel code in arch/i386/kernel/entry.S

