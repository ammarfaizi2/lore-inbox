Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVBTOlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVBTOlY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 09:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVBTOlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 09:41:24 -0500
Received: from jade.aracnet.com ([216.99.193.136]:59834 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261834AbVBTOlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 09:41:21 -0500
Date: Sun, 20 Feb 2005 06:41:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Joerg Sommrey <jo@sommrey.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Question on CONFIG_IRQBALANCE / 2.6.x
Message-ID: <318120000.1108910469@[10.10.2.4]>
In-Reply-To: <20050218225722.GA11292@sommrey.de>
References: <20050218213332.GA13485@sommrey.de> <4440000.1108766389@flay> <20050218225722.GA11292@sommrey.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > there's something I don't understand:  With IRQBALANCE *enabled* almost
>> > all interrupts are processed on CPU0.  This changed in an unexpected way
>> > after disabling IRQBALANCE: now all interrupts are distributed uniformly
>> > to both CPUs.  Maybe it's intentional, but it's not what I expect when a
>> > config option named IRQBALANCE is *disabled*.
>> > 
>> > Can anybody comment on this?
>> 
>> If you have a Pentium 3 based system, by default they'll round robin.
>> If you turn on IRQbalance, they won't move until the traffic gets high
>> enough load to matter. That's presumably what you're seeing.
> 
> It's an Athlon box that propably has the same behaviour.  Just another
> question on this topic:  with IRQBALANCE enabled, almost all interupts
> are routet to CPU0.  Lately irq 0 runs on CPU1 and never returns to CPU0
> - is there any obvious reason for that?

If it's not getting interrupts at 1010 per second or so, it won't rotate
them, on the grounds it's not worthwhile.

M.

