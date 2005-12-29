Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVL2PwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVL2PwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 10:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVL2PwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 10:52:21 -0500
Received: from [202.67.154.148] ([202.67.154.148]:42678 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1750768AbVL2PwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 10:52:20 -0500
Message-ID: <43B40635.4030002@ns666.com>
Date: Thu, 29 Dec 2005 16:52:21 +0100
From: Trilight <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14.5 / swapping / killing random apps
References: <43B3DC7A.7010000@ns666.com> <9a8748490512290616y34cae1aav776035e8b650264@mail.gmail.com>
In-Reply-To: <9a8748490512290616y34cae1aav776035e8b650264@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 12/29/05, Trilight <trilight@ns666.com> wrote:
> 
>>Hiya all,
>>
>>I was wondering about the following;
>>
>>
>>kernel: 2.6.14.5 / vanilla
>>
>>If a system with say a swap of 2GB on a fast drive and like 260MB is
>>actively used for swapping, could it cause certain applications to crash
>>?
> 
> 
> It shouldn't.
> 
> 
> 
>>I noticed that the when swapping occurs, usualy above 200MB then
>>random apps start to crash. Sometimes gnome-terminal, gnome-panel,
>>xchat, metacity and so on. It happens a few times in usually 48 hours.
>>
>>The system has 512MB ram, ECC , checked and cleared. The system can be
>>booted with m$ xp or freebsd but crashes do not occur even under heavy
>>load. So that's why i'm thinking something is causing this behaviour in
>>linux. I also have to say that dmcrypt was used for the swap but that
>>caused the crashes to increase, so dmcrypt is not used anymore just a
>>normal swap and crashes decreased to "rare" within 24 hours.
>>
> 
> 
>>Or is it "normal" that the crash risk of running apps increases the more
>>swapping is done ?
>>
> 
> No.  Not unless you exhaust *all* you RAM+Swap - if the machine goes
> OOM then the OOM-Killer will kick in and kill one or more applications
> in order to keep the system alive, but from your description (only
> 260MB Swap used out of 2GB) that does not seem to be the case here.
> 
> 
> 
>>I plan to upgrade the memory to 1.5GB anyway, but this issue is kinda
>>bothering me.
>>
>>Thanks in advance for any input !
>>
> 
> 
> Only thing I can think of would be a corrupted swap
> partition/swap-file or bad blocks on the harddrive in the areas used
> to hold the swap. That could be one possible explanation and would
> also explain that other OS's on your box doesn't crash since they
> don't use the same parts of the disk for swap.
> 
> Maybe someone else has other possible explanations.
> 
> 
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


Thanks for your reply !

I just did bad block check and it turns out to be good.

If there is anything else i can check i'm all ears hehe
