Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286714AbRLVODB>; Sat, 22 Dec 2001 09:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286781AbRLVOCw>; Sat, 22 Dec 2001 09:02:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15114 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286714AbRLVOCg>; Sat, 22 Dec 2001 09:02:36 -0500
Subject: Re: [patch] Assigning syscall numbers for testing
To: kaos@sgi.com (Keith Owens)
Date: Sat, 22 Dec 2001 14:12:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8727.1009020535@kao2.melbourne.sgi.com> from "Keith Owens" at Dec 22, 2001 10:28:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HmtJ-0004G7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> User space code should open /proc/dynamic_syscalls, read the lines
> looking for their syscall name, extract the number and call the glibc
> syscall() function using that number.  Do not use the _syscalln()
> functions, they require a constant syscall number at compile time.

Simple brutal and to the point. Also it means a dynamic library can 
switch to real syscalls and dynamic apps will migrate fine.

One request - can we specify a namespace of the form

['vendorid'].[call]

vendorid is the wrong phrase but "some sane way of knowing whose syscall
it is" - it would be bad for andrea-aio and ben-aio to use the same names..


Alan
