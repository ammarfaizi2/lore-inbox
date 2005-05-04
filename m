Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVEDTWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVEDTWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVEDTWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:22:42 -0400
Received: from web40904.mail.yahoo.com ([66.218.78.201]:63160 "HELO
	web40904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261407AbVEDTWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:22:25 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=oJ//OaCO5SAX6Su4KBvoM+0Ar8wL8mDCSb/u3rpvORnR5RMmbDS9sP8SL9pNEPx7RKohcKsVCLmLiJYEw7Tr/bXZIbqKgeeqgIUZSWEFkCCj10H21gNtDihG1Sf8IbX28QjhlzW7qLj47PkIVaTPd6oktgWdDWcFDsFa8szxWDY=  ;
Message-ID: <20050504192216.24722.qmail@web40904.mail.yahoo.com>
Date: Wed, 4 May 2005 12:22:16 -0700 (PDT)
From: jensen galan <jrgalan@yahoo.com>
Subject: Re: Implement new system call in 2.6 (now 2.4)
To: linux-kernel@vger.kernel.org
Cc: ks@cs.auc.dk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the thread below in the archive, and I am
having the same problem trying to implement a new
system call in a 2.4 kernel.  How did you end up
fixing this?

I am adding a simple call to time.c, and have also
followed the instructions at:

http://fossil.wpi.edu/docs/howto_add_systemcall.html 

I am getting the error:

/tmp/ccYYs1zB.o(.text+0x20): In function
`pedagogictime': 
: undefined reference to `errno' 
collect2: ld returned 1 exit status 

(Yes, this is the lab from the Nutt book ;>)

Thank you.

Jensen

> On Wed, 25 Feb 2004 11:07:41 +0100 (CET) Kristian
Sørensen wrote: 
> 
> | Hi all! 
> | 
> | How do I invoke a newly created system call in the
2.6.3 kernel from 
> | userspace? 
> | 
> | The call is added it arch/i386/kernel/entry.S and
include/asm/unistd.h 
> | and the call is implemented in a security module
called Umbrella(*). 
> | 
> | The kernel compiles and boots nicely. 
> | 
> | The main problem is now to compile a userspace
program that invokes this 
> | call. The guide for implementing the systemcall at

> |
http://fossil.wpi.edu/docs/howto_add_systemcall.html 
> | has been followed, which yields the following
userspace program: 
> | 
> | // test.h 
> | #include
"/home/snc/linux-2.6.3-umbrella/include/linux/unistd.h"

> | _syscall1(int, umbrella_scr, int, arg1); 
> | 
> | // test.c 
> | #include "test.h" 
> | main() { 
> | int test = umbrella_scr(1); 
> | printf ("%i\n", test); 
> | } 
> | 
> | When compiling: 
> | 
> | gcc -I/home/snc/linux-2.6.3/include test.c 
> | 
> | /tmp/ccYYs1zB.o(.text+0x20): In function
`umbrella_scr': 
> | : undefined reference to `errno' 
> | collect2: ld returned 1 exit status 
> | 
> | 
> | It seems like a little stupid error :-( Does some
of you have a solution? 
> | 
> Hm, it builds for me with no errors. 
> I'm using gcc version 3.2. Maybe it's a tools issue.

> 
> | 
> | (*) Umbrella is a security project for securing
handheld devices. Umbrella 
> | for implements a combination of process based
mandatory access control 
> | (MAC) and authentication of files. This is
implemented on top of the Linux 
> | Security Modules framework. The MAC scheme is
enforced by a set of 
> | restrictions for each process. 
> | More information on http://umbrella.sf.net 
> 
> 
> -- 
> ~Randy 


		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 
