Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSFRRT3>; Tue, 18 Jun 2002 13:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317518AbSFRRT1>; Tue, 18 Jun 2002 13:19:27 -0400
Received: from dsl092-042-129.lax1.dsl.speakeasy.net ([66.92.42.129]:37382
	"EHLO mgix.com") by vger.kernel.org with ESMTP id <S317508AbSFRRT0>;
	Tue, 18 Jun 2002 13:19:26 -0400
From: <mgix@mgix.com>
To: <root@chaos.analogic.com>, "Chris Friesen" <cfriesen@nortelnetworks.com>
Cc: "David Schwartz" <davids@webmaster.com>, <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Question about sched_yield()
Date: Tue, 18 Jun 2002 10:19:27 -0700
Message-ID: <AMEKICHCJFIFEDIBLGOBEEEHCBAA.mgix@mgix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.3.95.1020618130733.7442A-100000@chaos.analogic.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's all in the accounting. Use usleep(0) if you want it to "look good".


Two things:

	1. First, I think there's a misunderstanding on what my
         original issue was: I am not interested in any way by
         CPU cycle accounting, and wether the yielding loop should
         log any of it. All I want is: when I run a bunch of
         yielders and a actual working process, I want the
         working process to not be slown down (wall clock) in
         anyway. That's all. What top shows is of little interest
         (to me). What matters is how many real world seconds it takes
         for the actually working process to complete its task.
         And that should not be affected by the presence of running
         yielders. And, David, no one is arguing the fact that a yielder
         running all by itself should log 100% of the CPU.

	2. I have a question about usleep(0). You seem to make the point
         that usleep(0) is equivalent to sched_yield(). I can see how
         intuitively this should be the case, but I am not sure if it
         will always be true. It's certainly documented anywhere.


	- Mgix


