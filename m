Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWHKTKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWHKTKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWHKTKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:10:22 -0400
Received: from rtr.ca ([64.26.128.89]:50106 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932090AbWHKTKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:10:22 -0400
Message-ID: <44DCD618.2040700@rtr.ca>
Date: Fri, 11 Aug 2006 15:10:16 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, cpufreq@www.linux.org.uk
Subject: Re: cpufreq stops working after a while
References: <44DCCB96.5080801@rtr.ca> <20060811114631.4a699667.akpm@osdl.org>
In-Reply-To: <20060811114631.4a699667.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 11 Aug 2006 14:25:26 -0400
> Mark Lord <lkml@rtr.ca> wrote:
> 
>> One of my notebooks (Dell Latitude X1) has a 1.1GHz Pentium-M ULV processor.
>> This chip can change CPU speeds from 600 -> 800 -> 1100 Mhz.
>>
>> I use speedstep-centrino with it, and after boot all is usually okay.
>> But after a few hours of operation, it stops shifting to the highest frequency
>> even under continuous 100% load (or not).  Eventually it gets stuck at 600Mhz
>> and stays there until I reboot.
>>
>> Sometimes rebooting doesn't even restore it.
>>
>> /sys/devices/system/cpu/cpu0/cpufreq is all very normal looking,
>> showing the available frequencies and other info.  All of the attribs
>> there look fine, except for "scaling_max_freq", which is what seems
>> to gradually get set smaller.  For instance, right now it is set to 800000,
>> and it won't let me change it (echo 11000000 > scaling_max_freq has no effect.
>>
>> WHY?
> 
> cpufreq seems to have relatively frequent problems.
> 
>>  And how can I fix it?
> 
> You could start by telling us which kernel versions are affected ;)


Mmm.. since it appears to be related, kbuild dumps this out when building the kernel:

WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0xf29) and 'acpi_processor_cst_has_changed'

A possible source for the bug, or total red herring ?
