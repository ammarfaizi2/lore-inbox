Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271895AbRIEJ6c>; Wed, 5 Sep 2001 05:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271929AbRIEJ6W>; Wed, 5 Sep 2001 05:58:22 -0400
Received: from miranda.axis.se ([193.13.178.2]:47285 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S271895AbRIEJ6Q>;
	Wed, 5 Sep 2001 05:58:16 -0400
Message-ID: <3B95F745.A1476AFD@axis.com>
Date: Wed, 05 Sep 2001 11:58:29 +0200
From: Orjan Friberg <orjan.friberg@axis.com>
Organization: Axis Communications AB
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: orjan.friberg@axis.com
Subject: sa_sigaction signal handler: third parameter?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to make life easier for a user-defined SIGSEGV handler, the
sa_sigaction one with 3 parameters.  The second parameter, the siginfo_t
* one, is there.  Problem is, I would like to pass on additional
information to the signal handler, more specifically information about
whether there was a protection fault, read/write etc.  I've looked at
some of the other ports (I'm working on the CRIS port BTW), and for
example the i386 has fields in the task and sigcontext structs to keep
this sort of information.  

Question is how to pass this information on to the signal handler. 
Looking at the code, it seems the third parameter (void *) is being used
to send a ucontext_t * in (at least) the arm and mips cases.  I followed
a lot of threads in the archive, but couldn't find one that adressed
what this third parameter is actually meant to be used for.  Obviously,
sending a ucontext would solve my problem, since it contains the
sigcontext struct.  Is there a Right Way to do it?

(I'm not subscribed to the list, so please keep me on the CC list.)

-- 
Orjan Friberg              E-mail: orjan.friberg@axis.com
Axis Communications AB     Phone:  +46 46 272 17 68
