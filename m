Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269120AbUIXUZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269120AbUIXUZk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269129AbUIXUZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:25:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3001 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269119AbUIXUZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:25:05 -0400
Message-ID: <4154828F.6090205@pobox.com>
Date: Fri, 24 Sep 2004 16:24:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@fsmlabs.com>
CC: Suresh Siddha <suresh.b.siddha@intel.com>, linux-kernel@vger.kernel.org,
       asit.k.mallick@intel.com
Subject: Re: [Patch 0/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525
References: <20040923233410.A19555@unix-os.sc.intel.com> <Pine.LNX.4.53.0409241805020.2791@musoma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0409241805020.2791@musoma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Thu, 23 Sep 2004, Suresh Siddha wrote:
> 
> 
>>As part of the workaround for the "Interrupt message re-ordering across
>>hub interface" errata (page #16 in
>>http://developer.intel.com/design/chipsets/specupdt/30288402.pdf),
>>BIOS may enable hardware IRQ balancing for Lindenhurst/Tumwater based chipset
>>platforms. Software based irq_balance/irq_affinity should be disabled if
>>hardware IRQ balancing is enabled.
> 
> 
> Can we avoid those tests? Like not starting the irq balancer code at all 
> with those chipsets?


That's my preference.

Or, compile with !CONFIG_KIRQD -- the recommended setting for modern 
distros, since irqbalanced(1) is shipped.

	Jeff


