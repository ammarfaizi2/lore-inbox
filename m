Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbUBZP5C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbUBZP5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:57:02 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:19700 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S262548AbUBZP4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:56:54 -0500
Subject: Re: Implement new system call in 2.6
From: Kristian Soerensen <ks@cs.auc.dk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, umbrella@cs.auc.dk
In-Reply-To: <20040225101419.5f058573.rddunlap@osdl.org>
References: <Pine.LNX.4.56.0402250933001.648@homer.cs.auc.dk>
	 <20040225101419.5f058573.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1077811002.2787.2.camel@helene.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 16:56:42 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again!

Thanks for your rapid answers! We finally got it working now ;-)

Cheers, KS.

On Wed, 2004-02-25 at 19:14, Randy.Dunlap wrote:
> On Wed, 25 Feb 2004 11:07:41 +0100 (CET) Kristian Sørensen wrote:
> 
> | Hi all!
> | 
> | How do I invoke a newly created system call in the 2.6.3 kernel from
> | userspace?
> | 
> | The call is added it arch/i386/kernel/entry.S and include/asm/unistd.h
> | and the call is implemented in a security module called Umbrella(*).
> | 
> | The kernel compiles and boots nicely.
> | 
> | The main problem is now to compile a userspace program that invokes this
> | call. The guide for implementing the systemcall at
> | http://fossil.wpi.edu/docs/howto_add_systemcall.html
> | has been followed, which yields the following userspace program:
> | 
> | // test.h
> | #include "/home/snc/linux-2.6.3-umbrella/include/linux/unistd.h"
> | _syscall1(int, umbrella_scr, int, arg1);
> | 
> | // test.c
> | #include "test.h"
> | main() {
> |   int test = umbrella_scr(1);
> |   printf ("%i\n", test);
> | }
> | 
> | When compiling:
> | 
> | gcc -I/home/snc/linux-2.6.3/include test.c
> | 
> | /tmp/ccYYs1zB.o(.text+0x20): In function `umbrella_scr':
> | : undefined reference to `errno'
> | collect2: ld returned 1 exit status
> | 
> | 
> | It seems like a little stupid error :-( Does some of you have a solution?
> | 
> Hm, it builds for me with no errors.
> I'm using gcc version 3.2.  Maybe it's a tools issue.
> 
> | 
> | (*) Umbrella is a security project for securing handheld devices. Umbrella
> | for implements a combination of process based mandatory access control
> | (MAC) and authentication of files. This is implemented on top of the Linux
> | Security Modules framework. The MAC scheme is enforced by a set of
> | restrictions for each process.
> | More information on http://umbrella.sf.net
> 
> 
> --
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

