Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbUKJM6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUKJM6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 07:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbUKJM6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 07:58:32 -0500
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:29338 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261717AbUKJM6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 07:58:30 -0500
Date: Wed, 10 Nov 2004 13:58:29 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4 virtual terminal timing
Message-ID: <20041110125828.GB15767@zzz.i>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Tom Schouten <doelie@zzz.kotnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all,

kernel noob first post beware..
i am using a virtual terminal on i386 arch to do reaction time measurement
for a perception psychology vision/hearing experiment.

i am trying to find out if there is a direct path in 2.4.x from
keyboard interrupt, through console/tty stuff to process wakeup,
for a 2 thread process with one thread blocking on tty read, 
running SCHED_FIFO, or a single thread process with async IO.

i suspect there is no direct path to wakeup or SIGIO delivery,
so i walked the tty/console code for a day and i can't tell really. 
i got very confused. i'm not using 2.6 yet (other scheduling problems).

so, questions: 
- where exactly does wake-up after keyboard interrupt happen?
- if no direct path, how can i get reasonable timing from keyboard?
- anyone has keyboard driver code or incredibly dirty hack replacing tty code
  that can record time stamps for keys pressed/released?
- any pointers to documentation or other hints that could put me on the right track??

i'm a bit lost

cheers
tom
