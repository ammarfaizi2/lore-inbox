Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310233AbSCBBWD>; Fri, 1 Mar 2002 20:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310235AbSCBBVx>; Fri, 1 Mar 2002 20:21:53 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:1806 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S310233AbSCBBVi>;
	Fri, 1 Mar 2002 20:21:38 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: John Peel <jrp@thepeel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make menuconfig fails 
In-Reply-To: Your message of "Fri, 01 Mar 2002 11:26:02 MDT."
             <Pine.LNX.4.33.0203011118460.3337-100000@thepeel.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 02 Mar 2002 12:21:25 +1100
Message-ID: <2009.1015032085@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002 11:26:02 -0600 (CST), 
John Peel <jrp@thepeel.org> wrote:
>I just setup a new box running RH7.2 and I am trying to compile kernel 
>2.4.18. I did a minimal install on this box as it is only going to function as a router. When I 
>initially did a 'make menuconfig' it gave me an error regarding ncurses 
>being missing. I installed ncurses, ncurses4, and ncurses-devel. Now when 
>I do a 'make menuconfig' I get the following output:
>
>[root@localhost linux]# make menuconfig
>rm -f include/asm
>( cd include ; ln -sf asm-i386 asm)
>make -C scripts/lxdialog all
>make[1]: Entering directory `/usr/src/linux/scripts/lxdialog'
>gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE  
>-I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o checklist.o 
>checklist.c
>checklist.c: In function `dialog_checklist':
>checklist.c:154: `TRUE' undeclared (first use in this function)

TRUE should be defined in /usr/include/ncurses/ncurses.h, like this

/* XSI and SVr4 specify that curses implements 'bool'.  However, C++ may also
 * implement it.  If so, we must use the C++ compiler's type to avoid conflict
 * with other interfaces.
 */

#undef TRUE
#define TRUE    1

#undef FALSE
#define FALSE   0


