Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbTAJMoJ>; Fri, 10 Jan 2003 07:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTAJMoJ>; Fri, 10 Jan 2003 07:44:09 -0500
Received: from f155.law7.hotmail.com ([216.33.237.155]:55314 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S264954AbTAJMnr>;
	Fri, 10 Jan 2003 07:43:47 -0500
X-Originating-IP: [216.251.50.73]
From: "sakib mondal" <sakib@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problem of undefined reference
Date: Fri, 10 Jan 2003 12:52:27 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1550VnkB4ltFlmmlQ00000384c@hotmail.com>
X-OriginalArrivalTime: 10 Jan 2003 12:52:27.0520 (UTC) FILETIME=[21295000:01C2B8A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Wish you all a happy new year.

I appologize in case you are getting multiple copies of this message.

I am facing the problem of "undefined reference" for my task of using 
extended functionality of linux kernel (2.4.18) as detailed below. I shall 
appreciate any suggestion to solve the problem.


I would like to incorporate new functions into linux kernel. Therefore I 
created a file f.c with function "void foo()". Source f.c uses header file 
f.h. The header file "f.h" has declaration "extern void foo(void);". I 
included f.o in the obj-y in the Makefile in the corresponding directory. I 
could build the new kernel without any error or warning.

Now, I intended to use the extended functionality of the kernel from my 
program. I wrote g.c which calls foo(); I have included header f.h in g.c. 
However when I build g, I get the error:

"g.o(.text+ox35): undefined reference to `foo`".

I am unable to understand why "foo" is not resolved as the resident kernel 
ius built with object f.o. To diagonose the problem further I did the 
follwing things which could neither solve my problem.

i) Used "EXPORT_SYMBOL(foo);" in f.c and had f.o included in export-objs in 
the Makefile.  ==> I still get the problem of undefined reference

ii) Defined library libf.a based on f.o and included the library for 
building g. ==> The kernel is agin built ok. I could see (using nm) that the 
symbol foo in defined with type T. However, when building g, I am getting 
lot of undefined references to kernel variables and routines that are used 
in foo.

I shall appreciate any suggestion or alternative for solving the problem.

TIA.

Sakib






_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE* 
http://join.msn.com/?page=features/virus

