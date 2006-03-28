Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWC1RRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWC1RRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWC1RRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:17:53 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:61475 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751167AbWC1RRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:17:53 -0500
In-Reply-To: <20060328184305.6fe7f1b5@inspiron>
References: <20060318171946.821316000@towertech.it> <4487A3AA-AA9A-4B14-B8E1-7A63AEE711EC@kernel.crashing.org> <20060328184305.6fe7f1b5@inspiron>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <19E77D21-1080-48D4-A68C-923E0CD298B3@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 00/18] RTC subsystem
Date: Tue, 28 Mar 2006 11:17:51 -0600
To: Alessandro Zummo <alessandro.zummo@towertech.it>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 28, 2006, at 10:43 AM, Alessandro Zummo wrote:

> On Tue, 28 Mar 2006 10:25:59 -0600
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>
>> Alessandro, is there any mechanism to determine if an RTC is enabled
>> through /dev or sysfs?
>>
>> The DS1672 has an enable counting bit in its I2C register interface.
>> I can have a set time enable it if its not, however I'd like to
>> report to user space the fact that its not enabled.
>
>  No mechanism, an rtc is actually supposed to be running. You may want
>  to export a sysfs attribute from the ds1672 driver to inform
>  user space.

Any suggestions on what to call it?

>  I can't check it right now, but iirc I enable the ds1672 counting
>  bit in the driver init code.

Hmm, I didn't see that.  I was going to send a patch to have  
ds1672_set_mmss() always enable the counting bit.

- kumar

