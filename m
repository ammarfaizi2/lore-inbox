Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265481AbTL2Xxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265482AbTL2Xxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:53:41 -0500
Received: from smtp2.fre.skanova.net ([195.67.227.95]:44788 "EHLO
	smtp2.fre.skanova.net") by vger.kernel.org with ESMTP
	id S265481AbTL2Xxh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:53:37 -0500
From: Roger Larsson <roger.larsson@norran.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with SCHED_RR and kernel 2.4.18-4GB
Date: Tue, 30 Dec 2003 00:47:28 +0100
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312300047.28787.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm a newbie at Linux, but have been busy developing (with some other
> people) sort of a DVB zapper demo application/stack on top of Hauppauge HW
> and SUSE 8.0 kernel 2.4.18-4GB for the last 2 months.  
 
> As the stack wil eventually be ported to one (or more) dedicated HW
> platforms, we defined an OS independant API. Now, we want to be able to set
> priorities, and have sort of a realtime behaviour.  
 
> The problem is that if I implement this, and set scheduling to be SCHED_RR,
> or SCHED_FIFO, my linux machine hangs. With SCHED_OTHER, I don't have that
> (note that for testing I used to set all prios to minimum (=1)).  

The big difference is that if a tread running as SCHED_RR or SCHED_FIFO never 
sleeps normal treads (like X, sh, login, ...) will not be given ANY CPU time 
- computer will appear hanged.

[BTW you are not running the same code in both cases due to ifdefs...]

But it is possible to get out of this situation if you prepared for it 
before... Use a higher priority monitor to detect looping RT processes and 
reduce their priorities!

(I have code if you are interested, please CC me as I am not subscibed to 
linux-kernel)


/RogerL

 
-- 
Roger Larsson
Skellefteå
Sweden
