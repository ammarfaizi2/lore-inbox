Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbULCV7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbULCV7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 16:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbULCV7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 16:59:14 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:58578 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262385AbULCV7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 16:59:10 -0500
Message-ID: <41B0E18C.2060801@nortelnetworks.com>
Date: Fri, 03 Dec 2004 15:58:36 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: looking for help, attempting to debug high latency in 2.4 kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

I'm running 2.4.22 on ppc32.  Embedded system, just 74xx cpu, dual tulip network 
links and fiberchannel card.  Card has 1.5GB of memory, rootfs is tmpfs, system 
has some NFS mounts.

We're seeing userspace delayed for almost a second every so often.  No idea 
what's causing it.

We've got scheduler instrumentation showing a usespace task starting to run, 
then a bunch of tasks being put on the runqueue, and finally we wake up and 
start running normally again almost a full second later.  The timing is not 
exactly the same in each case, but it's usually close to a second of delay.

I'm looking for some tips on how to go about tracking this down.

Where are my delays likely to be coming from? Long-running code paths?  Long 
periods with interrupts off?  I dunno where to start.

Would porting lockmeter be a good idea?  Is there anyone who's already done this 
for ppc?

I appreciate any help.

Thanks,

Chris
