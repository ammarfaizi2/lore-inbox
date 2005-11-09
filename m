Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVKIMmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVKIMmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 07:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVKIMmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 07:42:38 -0500
Received: from [195.23.16.24] ([195.23.16.24]:43975 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1750712AbVKIMmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 07:42:38 -0500
Message-ID: <4371EEBA.2080706@grupopie.com>
Date: Wed, 09 Nov 2005 12:42:34 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Jens Axboe <axboe@suse.de>, Neil Brown <neilb@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: userspace block driver?
References: <4371A4ED.9020800@pobox.com> <17265.42782.188870.907784@cse.unsw.edu.au> <4371A944.6070302@pobox.com> <20051109075455.GN3699@suse.de> <4371ACE6.7010503@pobox.com>
In-Reply-To: <4371ACE6.7010503@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Jens Axboe wrote:
>> On Wed, Nov 09 2005, Jeff Garzik wrote:
>>> Neil Brown wrote:
>>>> On Wednesday November 9, jgarzik@pobox.com wrote:
>>>>
>>>>> Has anybody put any thought towards how a userspace block driver
>>>>> would work?
>>>>
>>>> Isn't this was enbd does? http://www.it.uc3m.es/~ptb/nbd/
>>>
>>> Is there something there relevant for modern kernels?  I would sure 
>>> hope I could come up with something more lightweight than that.
>>
>> I was going to say drbd, but then you did say more lightweight :-)
>[...]
> 
> loop is a closer model to a generic userspace block device than nbd, I 
> think.

That got me thinking... theoretically we should be able to do a FUSE 
server that served a single file that could be used by a loopback 
device, couldn't we?

IIRC, Miklos Szeredi tried hard to avoid the deadlock scenarios that nbd 
suffers from in FUSE, but I don't know if it would stand being called by 
the loopback device.

If it works, it should be extremely simple to do the server. Just check 
the FUSE hello world server example:

http://fuse.sourceforge.net/helloworld.html

I've CC'ed Miklos Szeredi to see if he can shed some light on the 
loopback <-> FUSE combination...

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain
