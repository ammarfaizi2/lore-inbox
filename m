Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbULGITl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbULGITl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 03:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbULGITl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 03:19:41 -0500
Received: from knserv.hostunreachable.de ([212.72.163.70]:63393 "EHLO
	mail.hostunreachable.de") by vger.kernel.org with ESMTP
	id S261556AbULGITk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 03:19:40 -0500
Message-ID: <41B56798.4070505@syncro-community.de>
Date: Tue, 07 Dec 2004 09:19:36 +0100
From: Hendrik Wiese <7.e.Q@syncro-community.de>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKLM <linux-kernel@vger.kernel.org>
Subject: wait_event_interruptible
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I created a kernel thread inside of my driver by calling the function 
kernel_thread with a function pointer. Now this thread calls daemonize 
and allow_signal and then it runs a forever loop until it is terminated 
by the kernel (unloading the driver etc). And because it is written in 
the documentation I put the thread asleep by calling 
wait_event_interruptible with a wait queue called "dpn_wq_run" inside 
the forever loop. Now is it right that a wake_up_interruptible in the 
ISR has to wake up the thread so it continues its work? If yes... why 
isn't that working for me? I called wait_event_interruptible with that 
dpn_wq_run inside the kernel thread and do a wake_up_interruptible 
inside the ISR with the same dpn_wq_run. But my kernel thread won't wake 
up. Is there anything else I have to do to the wait queue, but calling 
init_wait_queue on it?

Thanks a lot

Hendrik
