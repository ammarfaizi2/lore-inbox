Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135678AbRDSOUQ>; Thu, 19 Apr 2001 10:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135679AbRDSOUE>; Thu, 19 Apr 2001 10:20:04 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:9233 "HELO
	zmamail03.zma.compaq.com") by vger.kernel.org with SMTP
	id <S135678AbRDSOTx>; Thu, 19 Apr 2001 10:19:53 -0400
Message-ID: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CD9E@aeoexc1.aeo.cpqcorp.net>
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
To: linux-kernel@vger.kernel.org
Subject: OOM tries to kill a root process eating all the memory but does n
	ot make it.
Date: Thu, 19 Apr 2001 13:40:53 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a process  which eats all the memory available 
(buy making a loop of mallocs, writing and reading the 
malloc'd memory) called memoryEater (to torture test
the memory system before going to a production system)

My kernel is 2.4.2smp on a 4 way Alpha machine with 8 Go
of  RAM.

When the process is launched under a user ID everything
works the way it should, i.e. the malloc works fine until 
the process eats 7.8 Gbytes of RAM and then the process
stops on a segfault.

When the process is launched under the root ID, I see
the OOM in the /var/log/messages saying it wants to kill
this process (memoryEater) but it does not kill it.

Hitting Control+C, kill PID -9 does not work. Halting the machine 
is my only solution.

Any ideas ?


----------------------------------------------------------------------------
--
Sebastien CABANIOLS
COMPAQ France 
HPTC Engineer
CustomSystems & Solutions  Annecy  
High Performance Technical Computing 
Office No.  +33 (0)4 50 09 44 10
Fax No.  +33 (0)4 50 64 01 39 
Email.   sebastien.cabaniols@compaq.com 
----------------------------------------------------------------------------
--

  
