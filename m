Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275405AbTHJGCx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 02:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275471AbTHJGCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 02:02:53 -0400
Received: from pop.gmx.de ([213.165.64.20]:40102 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S275405AbTHJGCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 02:02:52 -0400
Message-Id: <5.2.1.1.2.20030810075319.019c7a90@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 10 Aug 2003 08:06:59 +0200
To: Daniel Phillips <phillips@arcor.de>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy 
  ...
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308100058.16261.phillips@arcor.de>
References: <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
 <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
 <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:58 AM 8/10/2003 +0100, Daniel Phillips wrote:
>On Saturday 09 August 2003 18:47, Mike Galbraith wrote:
> > 1.  SCHED_SOFTRR tasks can disturb (root) SCHED_RR/SCHED_FIFO tasks as is.
>
>What do you mean by "disturb"?

Preempt, and/or occupy cpu space which would otherwise be available for the 
root realtime task.  If a SCHED_SOFTRR task or tasks share the same queue 
with an SCHED_RR task, or occupy a higher queue, runtime of the 
SCHED_SOFTRR tasks[s] will have an effect on the root realtime task.  OTOH, 
if SCHED_SOFTRR queues were below the 'full potency' realtime queues, they 
would be able to neither preempt, not round-robin with the root authorized 
realtime task.

         -Mike 

