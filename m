Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293283AbSCRX16>; Mon, 18 Mar 2002 18:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293277AbSCRX1u>; Mon, 18 Mar 2002 18:27:50 -0500
Received: from web13305.mail.yahoo.com ([216.136.175.41]:24589 "HELO
	web13305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293283AbSCRX1l>; Mon, 18 Mar 2002 18:27:41 -0500
Message-ID: <20020318232740.39289.qmail@web13305.mail.yahoo.com>
Date: Mon, 18 Mar 2002 15:27:40 -0800 (PST)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: gcc inline asm - short question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  In studying the kernel I find many gcc inline 'asm' statements,
like so.
	
        asm ( assembler template
	    : output operands			 	(optional)
	    : input operands			 	(optional)
	    : list of clobbered registers 	  	(optional)
	    );	

  I have read all the docs and I still can't clearly understand when it 
is required to specify a clobberlist - a register or memory that will
be modified and must be preserved by gcc.

  In searching the kernel source there were very few clobbers given
and most of those were for memory.

  For example in arch/i386/lib/delay.c:

71         __asm__("mull %0"
72         :"=d" (xloops), "=&a" (d0)
73         :"1" (xloops),"" (current_cpu_data.loops_per_jiffy));
74         __delay(xloops * HZ);

  It's pretty obvious that eax gets clobbered, as I know clobber.  Why is
it not listed as such? Does the answer to this question apply in all cases? 
What about memory clobbers - how do they happen?


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
