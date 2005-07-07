Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVGGTh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVGGTh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVGGTdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:33:14 -0400
Received: from alpha.polcom.net ([217.79.151.115]:28305 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261261AbVGGTas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:30:48 -0400
Date: Thu, 7 Jul 2005 21:30:40 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ast@domdv.de
Subject: Re: [swsusp] encrypt suspend data for easy wiping
In-Reply-To: <20050707191429.GA1435@elf.ucw.cz>
Message-ID: <Pine.LNX.4.63.0507072123340.7125@alpha.polcom.net>
References: <20050703213519.GA6750@elf.ucw.cz> <20050706020251.2ba175cc.akpm@osdl.org>
 <20050706091104.GB1301@elf.ucw.cz> <Pine.LNX.4.63.0507061440470.7125@alpha.polcom.net>
 <20050707191429.GA1435@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Pavel Machek wrote:

> Hi!

Hi!

>>>>> To prevent data gathering from swap after resume you can encrypt the
>>>>> suspend image with a temporary key that is deleted on resume. Note
>>>>> that the temporary key is stored unencrypted on disk while the system
>>>>> is suspended... still it means that saved data are wiped from disk
>>>>> during resume by simply overwritting the key.
>>>>
>>>> hm, how useful is that?  swap can still contain sensitive userspace
>>>> stuff.
>>>
>>> At least userspace has chance to mark *really* sensitive stuff as
>>> unswappable. Unfortunately that does not work against swsusp :-(.
>>>
>>> [BTW... I was thinking about just generating random key on swapon, and
>>> using it, so that data in swap is garbage after reboot; no userspace
>>> changes needed. What do you think?]
>>
>> I (and many others) are doing it already in userspace. Don't you know
>> about dm-crypt? I think the idea is described in its docs or wiki...
>
> I could not find anything in device-mapper/*; do you have pointer to
> docs or wiki?

Just type dm-crypt in google and the first match is 
http://www.saout.de/misc/dm-crypt/ (the second is its wiki). Then grep 
that page for 'swap' and you are done. :-)


Grzegorz Kulewski
