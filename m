Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUBYSRm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUBYSRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:17:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:23701 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261518AbUBYSOZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:14:25 -0500
Date: Wed, 25 Feb 2004 10:14:19 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kristian =?ISO-8859-1?Q?S=F8rensen?= <ks@cs.auc.dk>
Cc: linux-kernel@vger.kernel.org, umbrella@cs.auc.dk
Subject: Re: Implement new system call in 2.6
Message-Id: <20040225101419.5f058573.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.56.0402250933001.648@homer.cs.auc.dk>
References: <Pine.LNX.4.56.0402250933001.648@homer.cs.auc.dk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004 11:07:41 +0100 (CET) Kristian Sørensen wrote:

| Hi all!
| 
| How do I invoke a newly created system call in the 2.6.3 kernel from
| userspace?
| 
| The call is added it arch/i386/kernel/entry.S and include/asm/unistd.h
| and the call is implemented in a security module called Umbrella(*).
| 
| The kernel compiles and boots nicely.
| 
| The main problem is now to compile a userspace program that invokes this
| call. The guide for implementing the systemcall at
| http://fossil.wpi.edu/docs/howto_add_systemcall.html
| has been followed, which yields the following userspace program:
| 
| // test.h
| #include "/home/snc/linux-2.6.3-umbrella/include/linux/unistd.h"
| _syscall1(int, umbrella_scr, int, arg1);
| 
| // test.c
| #include "test.h"
| main() {
|   int test = umbrella_scr(1);
|   printf ("%i\n", test);
| }
| 
| When compiling:
| 
| gcc -I/home/snc/linux-2.6.3/include test.c
| 
| /tmp/ccYYs1zB.o(.text+0x20): In function `umbrella_scr':
| : undefined reference to `errno'
| collect2: ld returned 1 exit status
| 
| 
| It seems like a little stupid error :-( Does some of you have a solution?
| 
Hm, it builds for me with no errors.
I'm using gcc version 3.2.  Maybe it's a tools issue.

| 
| (*) Umbrella is a security project for securing handheld devices. Umbrella
| for implements a combination of process based mandatory access control
| (MAC) and authentication of files. This is implemented on top of the Linux
| Security Modules framework. The MAC scheme is enforced by a set of
| restrictions for each process.
| More information on http://umbrella.sf.net


--
~Randy
