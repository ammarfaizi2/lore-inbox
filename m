Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268400AbUIBP0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268400AbUIBP0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 11:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268401AbUIBP0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 11:26:33 -0400
Received: from gwout.thalesgroup.com ([195.101.39.227]:39946 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S268400AbUIBP0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 11:26:30 -0400
Message-ID: <41373B9D.9040400@fr.thalesgroup.com>
Date: Thu, 02 Sep 2004 17:26:21 +0200
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q6 - network is no longer
 smooth
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040830192131.GA12249@elte.hu> <4135C12B.6050208@fr.thalesgroup.com> <20040901130518.GA10060@elte.hu> <413702EE.2000309@fr.thalesgroup.com> <20040902112856.GA5377@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:> * P.O. Gaillard <pierre-olivier.gaillard@fr.thalesgroup.com> 
wrote:
> 
> 
>>Hello,
>>
>>I just tried with Q6 and the network behaviour seems odd :
>> - my ssh connection freezes a bit,
>> - communication between the two PCs sharing the GigE connection is 
>> difficult to start :
> 
> 
> please try the -Q9 patch i just released, and if you still see any
> problems does the following:
> 
>     echo 300 > /proc/sys/net/core/netdev_backlog_granularity
> 
> help?
>
Q9 just crashed after showing the login prompt. It says there is a kernel bug in 
netdevice.h at line 874

The backtrace is :
finegrained_poll
net_rx_action
___do_soft_irq
_do_soft_irq
ksoftirqd
kthread
ksoftirqd
kthread
kernel_thread_helper

I have the following modules :
e1000
i2c_isa
i2c_sensor
w83627hf
asus_acpi



	P.O. Gaillard






