Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946243AbWBDCJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946243AbWBDCJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 21:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946245AbWBDCJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 21:09:23 -0500
Received: from sccrmhc12.comcast.net ([204.127.200.82]:208 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1946243AbWBDCJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 21:09:23 -0500
Message-ID: <43E40D14.7070606@comcast.net>
Date: Fri, 03 Feb 2006 21:10:28 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: athlon 64 dual core tsc out of sync 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this has been gone over before, and I am aware of the possible 
fix being the use of the pmtmr.

My question is, if there is support builtin to the kernel for more than 
one timer, and we know that no timer but the pmtimer is reliable on a 
dual core system, why doesn't the startup of the kernel choose the 
pmtimer based on if it detects the system is a dual core proc with smp 
enabled?   And if the pmtimer doesn't fix this sync issue, is there a 
fix out there?   Currently with 2.6.16-rc1-mm5 the non-customized boot 
args to the kernel results in these messages.

Losing some ticks... checking if CPU frequency changed.
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip default_idle+0x2d/0x60


cpufreq is enabled of course.  
