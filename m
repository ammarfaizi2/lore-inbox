Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbUKHIbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbUKHIbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 03:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUKHIbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 03:31:19 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:26542 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261777AbUKHIa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 03:30:29 -0500
Date: Mon, 8 Nov 2004 09:30:23 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Gregoire Favre <Gregoire.Favre@freesurf.ch>, linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
In-Reply-To: <418EBFE5.5080903@kolivas.org>
Message-ID: <Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net>
References: <20041107224621.GB5360@magma.epfl.ch> <418EB58A.7080309@kolivas.org>
 <20041108000229.GC5360@magma.epfl.ch> <418EB8EB.30405@kolivas.org>
 <20041108003323.GE5360@magma.epfl.ch> <418EBFE5.5080903@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Con Kolivas wrote:

> Gregoire Favre wrote:
>> On Mon, Nov 08, 2004 at 11:08:11AM +1100, Con Kolivas wrote:
>> 
>> 
>>>>>> I use DVB with VDR, but I can do the crash all the time without VDR, 
>>>>>> all
>>>>>> I have to do is to have xawtv running and having a process that write
>>>>>> fast enough data to an HD (I tested xfs, reiserfs, ext2 and ext3 with
>>>>>> same result). If I don't have xawtv running I can't make crashing my
>>>>>> system which is rock stable :-)
>>>>> 
>>>>> Is xawtv running as root or with real time privileges? That could do it.
>> 
>> 
>>> What does 'top' show as the PRI for xawtv?
>> 
>> 
>> I just started it and see 16 as priority in top. Should I renice it or
>> start it another way ?
>
> No I was just excluding whether you were running real time or not. You are 
> not, so that excludes that as the cause of your problem. I have no further 
> ideas though I'm afraid.

I am seeing the same problem with my bttv card. It was present in the 2.4 
day and is present to this day. There are some kernels that are more 
probable to hang while others are less. It does not depend on -ck or any 
other patchset or scheduling. I reported it to bttv maintainer year or two 
ago, but it looks like he is very unresponsive. :-) I know that this is 
not only my problem. And I know it is not probably related with nvidia or 
any other binary drivers. And it happens with zapping or mplayer v4l[12] 
too. And I tried every possible configuration of cards and IRQs. Nothing 
helps.

I suspect two things:
- there is some bug in bttv and similar drivers (DVB) that corrupts memory 
related with internal mm and vfs structures or does something equally bad,
- or maybe PCI bandwitch is overflowed, but I do not think it should 
happen.

But it is very hard to prove any of these I am afraid.


Grzegorz Kulewski

