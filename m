Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264240AbRFMWSq>; Wed, 13 Jun 2001 18:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264256AbRFMWSg>; Wed, 13 Jun 2001 18:18:36 -0400
Received: from jalon.able.es ([212.97.163.2]:45458 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264240AbRFMWST>;
	Wed, 13 Jun 2001 18:18:19 -0400
Date: Thu, 14 Jun 2001 00:19:29 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: accounting for threads
Message-ID: <20010614001929.A1242@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

First, sorry if this is a glibc issue. Just chose to ask here first.

I want to know the CPU time used by a POSIX-threaded program. I have tried
to use getrusage() with RUSAGE_SELF and RUSAGE_CHILDREN. Problem:
main thread just do nothing, spawns children and waits. And I get always
0 ru_utime.

I guess it can be because of 2 things:

- RUSAGE_CHILDREN only works for fork()'ed children (although in linux threads
and processes are the same). Perhaps fork() sets some kind of flag in
clone() for accounting.

- AFAIK, linux puts an intermediate 'thread controller'. That controller
uses no CPU time, and RUSAGE_CHILDREN gets only the first children level.

Any suggestion to mesaure threads CPU time ? I can't manage only with
wall-time, because I'm not sure to have all the box just for me.
And I would like also to mesaure system time to evaluate contention.

TIA

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac13 #1 SMP Sun Jun 10 21:42:28 CEST 2001 i686
