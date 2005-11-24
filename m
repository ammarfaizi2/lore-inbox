Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVKXSbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVKXSbR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 13:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbVKXSbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 13:31:17 -0500
Received: from mail.tmr.com ([64.65.253.246]:56710 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932407AbVKXSbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 13:31:16 -0500
Message-ID: <43860970.3090804@tmr.com>
Date: Thu, 24 Nov 2005 13:41:52 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Nilsson <daniel.n.nilsson@home.se>
CC: Markus.Lidel@shadowconnect.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Performance degradation when using partitions
References: <20051109182300.GA27452@oden.homeip.net> <43833DD9.2060108@tmr.com> <20051124140825.GA15298@oden.homeip.net>
In-Reply-To: <20051124140825.GA15298@oden.homeip.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Nilsson wrote:

>On Tue, Nov 22, 2005 at 10:48:41AM -0500, Bill Davidsen wrote:
>  
>
>>Daniel Nilsson wrote:
>>    
>>
>>>While setting up a software RAID-5 array I started looking into the
>>>performance aspect of using partioned drives versus the whole disks
>>>for a RAID-5 array. I have an Adaptec 2400a controller which through
>>>the I2O kernel driver gives me access to 4x 250GB disks (JBOD mode).
>>>      
>>>
>>Did you get an answer on this? And does it happen if you use the drives 
>>directly, /dev/hdN or /dev/sdN instead of using I2O? I didn't see an 
>>obvious speed penalty in raw access of drives vs. partitions, but I 
>>lacked the hardware to really match your setup, particularly the I2O use 
>>vs. direct access to /dev/sd[ef].
>>    
>>
>
>Bill,
>
>No, I didn't get an answer on this. I've done some more experiments
>with the drives, but since they are connected to an Adaptec 2400A RAID
>controller (in JBOD mode) I need to go through some I2O driver in or
>to see the drives at all. So I never have direct access to these
>drives as /dev/hdN or /dev/sdN. There are however two different
>drivers available for this RAID controller, one is the standard I2O
>driver and the other one is the Adaptec dpt_i2o driver.
>
>The results are the same though whether I use the Linux I2O driver or
>the Adaptec dpt_i2o, the software raid array is rebuilding at roughly
>half the speed when the drives are partioned. I don't know what other
>data to provide in ordet to get any further in the testing.
>  
>

Unfortunately, until someone else has the time and interest to make more 
tests I don't see a good next step. I might be able to at least do some 
better quantified tests later this weekend, but I have no I2O devices, 
so it isn't going to tell much.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

