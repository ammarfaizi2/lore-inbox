Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVBRXLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVBRXLy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVBRXLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:11:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49047 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261549AbVBRXLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:11:52 -0500
Message-ID: <42167615.5080906@pobox.com>
Date: Fri, 18 Feb 2005 18:11:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Sommrey <jo@sommrey.de>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Question on CONFIG_IRQBALANCE / 2.6.x
References: <20050218213332.GA13485@sommrey.de> <4440000.1108766389@flay> <20050218225722.GA11292@sommrey.de>
In-Reply-To: <20050218225722.GA11292@sommrey.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Sommrey wrote:
> On Fri, Feb 18, 2005 at 02:39:49PM -0800, Martin J. Bligh wrote:
> 
>>>there's something I don't understand:  With IRQBALANCE *enabled* almost
>>>all interrupts are processed on CPU0.  This changed in an unexpected way
>>>after disabling IRQBALANCE: now all interrupts are distributed uniformly
>>>to both CPUs.  Maybe it's intentional, but it's not what I expect when a
>>>config option named IRQBALANCE is *disabled*.
>>>
>>>Can anybody comment on this?
>>
>>If you have a Pentium 3 based system, by default they'll round robin.
>>If you turn on IRQbalance, they won't move until the traffic gets high
>>enough load to matter. That's presumably what you're seeing.
> 
> 
> It's an Athlon box that propably has the same behaviour.  Just another
> question on this topic:  with IRQBALANCE enabled, almost all interupts
> are routet to CPU0.  Lately irq 0 runs on CPU1 and never returns to CPU0
> - is there any obvious reason for that?

Note that it is a popular recommendation to -disable- CONFIG_IRQBALANCE, 
and then run the userspace 'irqbalanced'.

	Jeff



