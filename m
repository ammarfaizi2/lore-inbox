Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269993AbRHJTuL>; Fri, 10 Aug 2001 15:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269996AbRHJTuC>; Fri, 10 Aug 2001 15:50:02 -0400
Received: from web20008.mail.yahoo.com ([216.136.225.71]:2831 "HELO
	web20008.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269993AbRHJTtx>; Fri, 10 Aug 2001 15:49:53 -0400
Message-ID: <20010810195004.18859.qmail@web20008.mail.yahoo.com>
Date: Fri, 10 Aug 2001 12:50:04 -0700 (PDT)
From: Raghava Raju <vraghava_raju@yahoo.com>
Subject: __asm__ usage ????
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hi

   I want some basic insights into assembly level code
emmbedded in C language. Following is the code of
PowerPc ambedded in C languagge:

unsigned long old,mask, *p;

	__asm__ __volatile__(SMP_WMB "\
1:	lwarx 	%0,0,%3
	andc  	%0,%0,%2
	stwcx 	%0,0,%3
	bne 	1b"
	SMP_MB
	: "=&r" (old), "=m" (*p)
	: "r" (mask), "r" (p), "m" (*p)
	: "cc");

	1) what does these things denote: __volatile__,
SMP_WMB, SMP_MB, "r","=&r","=m",
"cc" and 1: .
          
	2) Is it that %0,%2,%3 denote addresses of old,mask,p
respectively. 

        3) Say if it is PowerPc then how should I
access registers r1,r2 etc, i.e. what is the exact
syntax.

        4) I think in power PC we can't access
directly the contents of memory, but we should 
give addresses of memory in registers then use
registers in instructions to access memory. But in
above example he is using %3 in lwarx command
accessing that memory directly. Is my interpretation
of above instructions wrong.

        5) Some people use "memory" in place of "cc" ,
like I want to know what are these things.

        6) Finally I want to write a simple programme
to write the contents of a local variable "xyz" into
register r33, then store the contents of r33 into
local variable "abc". Kindly would u give me a sample
code of doing it.

Please reply to vraghava_raju@yahoo.com, since I am
not subscriber to list.

         Thanks in advance.
         Raghava.

__________________________________________________
Do You Yahoo!?
Send instant messages & get email alerts with Yahoo! Messenger.
http://im.yahoo.com/
