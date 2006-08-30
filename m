Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWH3MDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWH3MDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWH3MDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:03:54 -0400
Received: from imladris.surriel.com ([66.92.77.98]:11431 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S1750866AbWH3MDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:03:54 -0400
Message-ID: <44F57EA8.4010905@surriel.com>
Date: Wed, 30 Aug 2006 08:03:52 -0400
From: Rik van Riel <riel@surriel.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Rajat Jain <rajat.noida.india@gmail.com>
CC: Rick Brown <rick.brown.3@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Spinlock query
References: <7783925d0608291912i3f04d460kc9edebf9d358dbc3@mail.gmail.com>	 <44F501B3.9070200@surriel.com> <b115cb5f0608292231r1a3c47c8r8980b32e838ff964@mail.gmail.com>
In-Reply-To: <b115cb5f0608292231r1a3c47c8r8980b32e838ff964@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajat Jain wrote:
> On 8/30/06, Rik van Riel <riel@surriel.com> wrote:
>> Rick Brown wrote:
>> > Hi,
>> >
>> > In my driver (Process context), I have written the following code:
>> >
>> > --------------------------------------------
>> > spin_lock(lock)
>> > ...
>> > //Critical section to manipulate driver data
>>
>> ... interrupt hits here
>>     interrupt handler tries to grab the spinlock, which is already taken
>>     *BOOM*
>>
>> > spin_u lock(lock)
>> > ---------------------------------------------
>> >
> 
> The interrupt handler TRIES to grab the spinlock, which is already
> taken. Why will it "BOOM"? Wouldn't the interrupt handler busy wait,
> waiting for the lock?
> 
> Am I missing something here?

Yes, it will busy wait.  Forever.


-- 
What is important?  What you want to be true, or what is true?
