Return-Path: <linux-kernel-owner+willy=40w.ods.org-S289515AbUKBBwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S289515AbUKBBwP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265680AbUKAX1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:27:02 -0500
Received: from proxy.vc-graz.ac.at ([193.171.121.30]:44283 "EHLO
	proxy.vc-graz.ac.at") by vger.kernel.org with ESMTP id S262256AbUKAWTX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:19:23 -0500
From: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
To: zaitcev@yahoo.com
Subject: Re: 2.6.9 USB storage problems
Date: Mon, 1 Nov 2004 23:19:13 +0100
User-Agent: KMail/1.7
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-kernel@vger.kernel.org
References: <200410121424.59584.worf@sbox.tu-graz.ac.at> <200411012040.33285.worf@sbox.tu-graz.ac.at> <20041101213501.GD18227@one-eyed-alien.net>
In-Reply-To: <20041101213501.GD18227@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411012319.13676.worf@sbox.tu-graz.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 1. November 2004 22:35 schrieb Matthew Dharm:
> On Mon, Nov 01, 2004 at 08:40:32PM +0100, Wolfgang Scheicher wrote:
>> Am Montag, 1. November 2004 20:10 schrieb Matthew Dharm:
>>> You're using the UB driver.  Does it work if you turn that off and use
>>> the usb-storage driver instead?
>>
>> Damn, you are right - this is a new driver...
>> I didn't notice that, i did rely on hotplug to load the correct modules.
>>
>> Removed the ub driver and everything is fine now.
>>
>> That means - just unloadin ub and loading usb-storage didn't work.
>>
>> I had to remove it from the kernel config and rebuild the modules.
>> Actually usb-storage was the only module being rebuilt. Looks like
>> usb-storage's functionality is different if ub is built.
>>
>> So, my system works fine again, thank you.
>> But it leaves the question: why does ub perform so badly?
>
> Talk to Pete Zaitcev about that.

ok - so this goes to him too :-)

Pete, i don't know if you have seen my previous posts...
I did now have a look at the comments in ub.c
Looks like the driver is very new and a lot has yet to be done.
I cannot really tell what of the points on the todo list may be related to my 
problem. I miss information and "ub" isn't really a good keyword to google 
for either.

What is the difference to the usb-storage driver?
What is the state, what are the plans?

>> And: could maybe somebody put some hints into the ub help?
>> "This driver supports certain USB attached storage devices such as flash
>> keys." didn't sound so bad to me...
>
> That should definately happen.  Along with a note that this blocks
> usb-storage from working with many devices if enabled.

Yep. Absolutely.

Worf
