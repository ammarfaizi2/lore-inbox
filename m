Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281158AbRKOXLL>; Thu, 15 Nov 2001 18:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281161AbRKOXLB>; Thu, 15 Nov 2001 18:11:01 -0500
Received: from sas.asc.hpc.mil ([129.48.244.126]:19947 "EHLO sas.asc.hpc.mil")
	by vger.kernel.org with ESMTP id <S281158AbRKOXKm>;
	Thu, 15 Nov 2001 18:10:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: ANTHONY DELSORBO <delsorbo@asc.hpc.mil>
Organization: CSC
To: linux-kernel@vger.kernel.org
Subject: unresolved symbol kiobuf_init for kernel 2.4.9-6
Date: Thu, 15 Nov 2001 18:10:40 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0111151810400C.01205@spt93>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

I'm attempting to load a module whose code has a call to kiobuf_init.  The 
function kiobuf_init is defined in fs/iobuf.c BUT not forward declared in 
include/linux/iobuf.h (as it was in 2.4.3-12).  But the kernel compiles 
anyway.  The module code compiles as well -- even if I do ignore the 
undefined symbol message at compile time.  However, when I try to insmod the 
module I get the dreaded message 

module.o: unresolved symbol kiobuf_init 

Now here's the funny thing:  

The /boot/System.map file lists it as

c014d410 t kiobuf_init

But there's nothing in the /proc/ksyms

I've stepped through the installation process of insmod and noted that there 
are 1474 symbols in ksyms and none of them is kiobuf_init.  So, obviously 
when it checks for unresolved symbols it doesn't find it.

I've recompiled the kernel, the module source and even forward declared the 
function, but nothing seems to work!

What could I be doing wrong????  I've been working this problem for several 
days now without success!

Thanks,

Tony.
