Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbUCJVSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbUCJVR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:17:58 -0500
Received: from 69-90-55-107.fastdsl.ca ([69.90.55.107]:50365 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id S262699AbUCJVQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:16:07 -0500
Message-ID: <404F85A6.6070505@brad-x.com>
Date: Wed, 10 Mar 2004 16:16:22 -0500
From: Brad Laue <brad@brad-x.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040307
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ksoftirqd using mysteriously high amounts of CPU time
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, all

I'm running into an issue where ksoftirqd/0 consumes a considerably 
larger amount of CPU time  than it should, and begins to actively 
consume 99% CPU time during network operations.

I've done my best to diagnose this, but it has followed me from kernel 
2.4.20 to 2.6.3 and all versions in between, on three different server 
systems with distinct hardware configurations.

The latest system to be affected by this takes considerably longer to 
have trouble, but this is only due to its sheer muscle to begin with (2x 
MP 2800+), but does indeed appear. After 55 days of uptime:

5 root      34  19     0    0    0 S  0.0  0.0   0:21.40 ksoftirqd_CPU0
6 root      34  19     0    0    0 S  0.0  0.0   0:36.31 ksoftirqd_CPU1

Compare this to another machine which I don't run myself:

3 root      19  19     0    0    0 S  0.0  0.0   0:09.86 ksoftirqd_CPU0

There are peculiarities to my configuration which are shared on all the 
affected machines - the use of PPPoE to connect is one example. However 
on one of the affected systems a second network interface was subjected 
to heavy NFS traffic over simple ethernet and exhibited the same 
behavior. Another shared trait is a firewall ruleset I've written for 
the machines, which I can attach if someone would like to see them.

The three configurations include:

K6-2 500MHz
Ne2K, RealTek 8139

Duron 900MHz
SiS 900, RealTek 8139

2x Athlon MP 2800+
3com 3c905b 10/100+

The issue begins with ksoftirqd consuming more time than usual, and ends 
after four to twelve weeks depending on how powerful the machine, with 
the machine crippled and unable to sustain network traffic of any kind. 
Any assistance on where to look for solutions to this kind of problem 
would be GREATLY appreciated.

Thanks in advance!

Brad
