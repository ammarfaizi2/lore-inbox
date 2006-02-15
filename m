Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWBOGFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWBOGFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWBOGFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:05:54 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:59822 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751011AbWBOGFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:05:53 -0500
Message-ID: <43F2C44C.7080806@jp.fujitsu.com>
Date: Wed, 15 Feb 2006 15:03:56 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       greg@kroah.com
Subject: Re: [RFC][PATCH 1/4] PCI legacy I/O port free driver - Introduce
 pci_set_bar_mask*()
References: <43F172BA.1020405@jp.fujitsu.com>	<43F17379.8010900@jp.fujitsu.com> <20060214210744.3a7a756a.akpm@osdl.org>
In-Reply-To: <20060214210744.3a7a756a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
> 
>>This patch introduces a new interface pci_select_resource() for PCI
>> device drivers to tell kernel what resources they want to use.
> 
> 
> It'd be nice if we didn't need to introduce any new API functions for this.
> If we could just do:
> 
> struct pci_something pci_something_table[] = {
> 	...
> 	{
> 		...
> 		.dont_allocate_io_space = 1,
> 		...
> 	},
> 	...
> };
> 
> within each driver which wants it.
> 
> But I can't think of a suitable per-device-id structure with which we can
> do that :(
> 
> 

My another idea was to use pci quirks. In this approach, we don't
need to introduce any new API. But I gave up this idea because it
looked abuse of pci quirks.

Anyway, I try to think about new ideas we don't need to introduce
any new API.

Thanks,
Kenji Kaneshige
