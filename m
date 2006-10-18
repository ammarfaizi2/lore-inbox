Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWJRRMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWJRRMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWJRRMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:12:33 -0400
Received: from mta9.adelphia.net ([68.168.78.199]:58340 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S1751071AbWJRRMc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:12:32 -0400
Message-ID: <4536606F.80606@Adelphia.net>
Date: Wed, 18 Oct 2006 13:12:15 -0400
From: Dyson <Linux@Adelphia.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Still broken sata (VIA) on Asus A8V (kernel 2.6.14+) with irqbalance
References: <4534F41A.1030504@Adelphia.net> <200610181526.05336.sergio@sergiomb.no-ip.org>
In-Reply-To: <200610181526.05336.sergio@sergiomb.no-ip.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sergio Monteiro Basto wrote:
> On Tuesday 17 October 2006 16:17, Dyson wrote:
>   
>> I put in the patch mentioned below to get rid of the VIA IRQ fixup for a
>> VIA K8T800 SMP machine and the computer hasn't froze yet after 19 hours
>>     
>
> Ok many thanks for your positive report :) 
> Now the latest patch is http://lkml.org/lkml/diff/2006/9/7/235/1 from 
> http://lkml.org/lkml/2006/9/7/235
> which is in -mm kernels,
> and I also need the patch to have more stability , but don't resolve all 
> problems 
>
> best regards, 
>   

Yes, I spoke a little too soon.

I did more testing with a USB drive and it blew up after a few minutes. 
It was fine until I used USB.

I edited the original 2.6.16 quirks.c to not fixup the IDE bus and still
fixup the USB IRQs.

So far it's testing OK with dd copy loading to IDE, sata and USB 
simultaneously.

-

I will test the latest patch and give you results.

Thanks,

Dyson
