Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVCANMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVCANMC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVCANMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:12:02 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:57991 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261900AbVCANLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:11:11 -0500
Message-ID: <422469E3.7010805@andrew.cmu.edu>
Date: Tue, 01 Mar 2005 08:10:59 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
References: <422001CD.7020806@andrew.cmu.edu> <20050228134410.GA7499@bytesex>	<42232DFC.6090000@andrew.cmu.edu> <87mzto3c78.fsf@bytesex.org>	<42240EB3.6040504@andrew.cmu.edu> <87is4b21s5.fsf@bytesex.org>
In-Reply-To: <87is4b21s5.fsf@bytesex.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me for being annoying; I'm trying to be careful because I get 
one more failure in a test and then that's it.  The manufacturer no 
longer lists that model as being produced.  Thus if there's a way to 
ruin a bttv card through the V4L2 interface I will no longer be of any 
assistance in finding it.

Gerd Knorr wrote:
> James Bruce <bruce@andrew.cmu.edu> writes:
>>If you could suggest a very well tested kernel for bttv (2.6.9?),
> What do you expect?  With just one single report and not remotely
> being clear what exactly caused it ...

It goes further than that though; I have about 3+ people a month asking 
me what camera and capture card to use with my GPL'd machine vision library:
	http://www-2.cs.cmu.edu/~jbruce/cmvision/

Right now, I have to tell them "use 2.4 patched with V4L2", which is 
neither what they want to hear nor what I want to tell them.  CMVision 
can use IEEE1394 cameras, but since that has been "working, not working, 
then working again" in relatively recent 2.6.x, I can't sanely tell 
people to use that yet.  Now that the V4L2 API churn rate has gone down, 
I'm trying to get it working properly with the 2.6.x V4L2 API (which 
AFAICT doesn't match any 2.4.x V4L2 API variant).  If it works I could 
just tell people "Use 2.6.x with a commonly available bttv card", which 
would be great.  However, so far I've gotten that to work for five days 
before the cards stopped working.  I've been tracking the V4L API since 
1999, on something like 10 different cards, and this is the most serious 
failure I've had.  So I'm back to telling CMVision users "Use 2.4 + 
patches", which I would really like to *not* have to tell people.

As far as kernels go, there was the guy only one report on lkml by 
someone overwritting mozilla by running XawTV in 2.6.10-ac8.  The 
changes between 2.6.11-rc* and 2.6.10 seem to be minor, but I guess I2C 
has changed causing the reported 2.6.11-rc* bttv issues.  Going back to 
2.6.9 there are a lot more changes in the driver.  I'd know more if 
linux.bkbits didn't seem to be down at the moment.

Google says:
[linux bttv problem "2.6.7"]  -> 1230 hits
[linux bttv problem "2.6.8"]  -> 1010 hits
[linux bttv problem "2.6.9"]  ->  958 hits
[linux bttv problem "2.6.10"] ->  831 hits

That's certainly promising, so I guess I'll try 2.6.9 and 2.6.10 on 
another computer with the remaining card.  If you want me to also try 
some out-of-tree-latest-version patches, now would be the time to speak 
up before I've messed up the third card.

>>I've heard that there is some way to dump eeproms; Is there a way to
>>write them also?
> 
> Yes, you can.  That works only if you can still talk to it though.

I'll gather all the information I can from the remaining card.

>>If I could copy the eeprom from the unused cards to the (now broken)
>>pair that might fix things.
> 
> No.  It's not accessable, not just the content scrambled.
> 
>   Gerd

Ok.

Thanks,
   Jim Bruce
