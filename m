Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVIDKfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVIDKfO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 06:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVIDKfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 06:35:13 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:28676 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750731AbVIDKfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 06:35:12 -0400
Message-ID: <431ACDDE.9090002@superbug.demon.co.uk>
Date: Sun, 04 Sep 2005 11:35:10 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dragoran <dragoran@feuerpokemon.de>
CC: Niko Nitsche <fal16con@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: snd-emu10k1 broken in 2.6.13
References: <4IY3f-61u-13@gated-at.bofh.it> <431ABB63.5020608@gmx.de> <431AC5C6.7030103@feuerpokemon.de>
In-Reply-To: <431AC5C6.7030103@feuerpokemon.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dragoran wrote:
> Niko Nitsche wrote:
> 
>> dragoran wrote:
>>  
>>
>>> Hello.
>>> I am running FC4 and compiled a vanilla linux 2.6.13.
>>> After booting the kernel I see an error messages that says that it was
>>> unable to load snd-emu10k1 (see dmesg).
>>> In dmesg I got this:
>>> Sep  4 10:09:47 chello062178124144 kernel: snd_emu10k1: Unknown
>>> parameter `'
>>> Sep  4 10:09:47 chello062178124144 last message repeated 2 times
>>> the same modprobe.conf works in 2.6.12.
>>> I tryed to load it by hand (modprobe snd-emu10k1) => same result
>>> modprobe snd-emu10k1 index=0 => same result.
>>> I will attach my .config file
>>> (please CC me as I am not subscribed to the list)
>>
>>
>> Hi,
>>
>> I had the same problem with FC4/vanilla 2.6.13 and snd-intel8x0
>> and I had two lines in modprobe.conf like this:
>>
>> options snd-card-0 index=0
>> options snd-intel8x0 index=0
>>
>> I removed them and now everything works just fine. Accutally I had the
>> Unknown parameter `' messages before but the module loaded.
>>
>>
>>  
>>
> sorry but this isn't solution (it works thought) but this happens for 
> all modules that have a options line in /etc/modprobe.conf
> Is this a bug or has the syntax of modprobe.conf changed in 2.6.13?

Well, those options lines are just wrong so I am not at all surprised 
that it failed.

It should be:
options snd-card-0 snd-intel8x0
options snd-intel8x0 index=0

So, dragoran, what options lines do you have?

James
