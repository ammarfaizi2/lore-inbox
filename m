Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269192AbUISISa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269192AbUISISa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 04:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269196AbUISISa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 04:18:30 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:45713 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S269192AbUISIS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 04:18:27 -0400
Message-ID: <414D40CD.8060202@softhome.net>
Date: Sun, 19 Sep 2004 10:18:21 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.8 (Macintosh/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
References: <414C9003.9070707@softhome.net> <20040918213023.GB1901@kroah.com> <414CCD88.30001@softhome.net> <20040919004115.GB18309@kroah.com>
In-Reply-To: <20040919004115.GB18309@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
>>P.P.S. Another day, I hope, you will understand that right system need 
>>to provide people with two opposite ways of doing things. Sometimes it 
>>is advantage to be event-based and asynchronous, sometimes it is very 
>>convient to be dumb & synchronous.
> 
> My point is we _can not_ be dumb and synchronous in this situation.  It
> just will not work with busses that have devices that can come and go as
> the system is running.  It is pretty much impossible to correctly do
> what you are proposing.  Just think about the different situations that
> we have to handle properly.
> 

   Example? Your "we can not" sounds like "we not capable enough to 
implement."

    I thought that discovery deterministic process. What I'm missing?

    For now, You haven't gave any example besides "slow USB hub" - but 
this is rather example which supports me: you are not going to put 
/variable/ delays into init scripts? aren't you?

    Here we definitely need to hide asynchronousity of process - 
handling this volatility in user space will never work reliably.

P.S. You do not need to reply, it seems like case of init scripts is not 
interesting for you. What is for me about 90% of work I usually do 
preparing new system. Number-wise, most of devices attached to system, 
initialized by init scripts - and you just dumbly avoid answering that. 
You have to modprobe/insmod harddrive & filesystem to be able run your 
udev, after all. Think about it. And people have had problems with 
discovery - one of the patches for usb-storage root fs is adding a delay 
and retries for root fs mounting. Moving problem around is easier than 
solving it, that's true.
