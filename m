Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262714AbRFCBSQ>; Sat, 2 Jun 2001 21:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbRFCBSG>; Sat, 2 Jun 2001 21:18:06 -0400
Received: from mnh-1-10.mv.com ([207.22.10.42]:12296 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262714AbRFCBRz>;
	Sat, 2 Jun 2001 21:17:55 -0400
Message-Id: <200106030231.VAA03708@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org
Subject: What is i386 thread.trapno?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 02 Jun 2001 21:31:42 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With a normal segfault, the handler gets a trapno == 14 in the sigcontext.  
With UML, I can make a process infinitely segfault with trapno == 1.  The page 
being accessed is correctly mapped in according to /proc/<pid>/maps, so the 
odd trapno is the only clue that I can see that something is different.

The i386 page fault handler sets trap_no to 14, so the fault isn't coming from 
there, but I can't see where a SIGSEGV is being delivered to a process with 
thread.trap_no == 1.

So:
	What do these trap numbers mean?
	Where can I read about them?
and
	Where's this segfault coming from?

				Jeff


