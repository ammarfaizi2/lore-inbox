Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293423AbSCAR0b>; Fri, 1 Mar 2002 12:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293433AbSCAR0V>; Fri, 1 Mar 2002 12:26:21 -0500
Received: from ol1-24.217.42.23.charter-stl.com ([24.217.42.23]:22973 "EHLO
	thepeel.org") by vger.kernel.org with ESMTP id <S293423AbSCAR0I>;
	Fri, 1 Mar 2002 12:26:08 -0500
Date: Fri, 1 Mar 2002 11:26:02 -0600 (CST)
From: John Peel <jrp@thepeel.org>
To: <linux-kernel@vger.kernel.org>
Subject: make menuconfig fails
Message-ID: <Pine.LNX.4.33.0203011118460.3337-100000@thepeel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just setup a new box running RH7.2 and I am trying to compile kernel 
2.4.18. I did a minimal install on this box as it is only going to function as a router. When I 
initially did a 'make menuconfig' it gave me an error regarding ncurses 
being missing. I installed ncurses, ncurses4, and ncurses-devel. Now when 
I do a 'make menuconfig' I get the following output:

[root@localhost linux]# make menuconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts/lxdialog all
make[1]: Entering directory `/usr/src/linux/scripts/lxdialog'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE  
-I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o checklist.o 
checklist.c
checklist.c: In function `dialog_checklist':
checklist.c:154: `TRUE' undeclared (first use in this function)
checklist.c:154: (Each undeclared identifier is reported only once
checklist.c:154: for each function it appears in.)
checklist.c:241: `FALSE' undeclared (first use in this function)
make[1]: *** [checklist.o] Error 1
make[1]: Leaving directory `/usr/src/linux/scripts/lxdialog'
make: *** [menuconfig] Error 2
[root@localhost linux]#

Can anyone shed some light on what's going on. I could just use 'make 
config' but it's so time consuming and on most of my boxes I upgrade 
kernels quite often. Thanks in advance and i apologize if I'm looking in 
the wrong place for solutions. -peel

john peel
jrp@thepeel.org

