Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSFEKHO>; Wed, 5 Jun 2002 06:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSFEKHN>; Wed, 5 Jun 2002 06:07:13 -0400
Received: from [195.63.194.11] ([195.63.194.11]:61714 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314340AbSFEKHL>; Wed, 5 Jun 2002 06:07:11 -0400
Message-ID: <3CFDD513.4030109@evision-ventures.com>
Date: Wed, 05 Jun 2002 11:08:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: device model documentation 1/3
In-Reply-To: <Pine.LNX.4.33.0206041115540.654-100000@geena.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> On Tue, 4 Jun 2002, Patrick Mochel wrote:
> 
> 
>>>>	int	(*bind)		(struct device * dev, struct device_driver * drv);
>>>>};
>>>>
>>>
>>>Please - Why do you call it bind? Does it have something with
>>>netowrking to do? Please just name it attach. This way the old UNIX
>>>guys among us won't have to drag a too big
>>>"UNIX to Linux translation dictionary" around with them.
>>>As an "added bonus" you will stay consistent with -
>>>
>>>PCMCIA code base in kernel
>>>USB code base in kernel
>>>IDE code base (well recently)
>>
>>Ok, I can live with that.
> 
> 
> Actually, I take that back. attach is the wrong nomenclature as well for 
> the action. 'match' would be more correct.

That would be fine with me. At least this would not confuse at least me
about what's up with it. matchid would be even more obvious.
Perhaps "validate" could be used too, becouse the method is
not acting on equivalent objects.

> The entry point is the opportunity for the bus to compare a device ID with
> a list of IDs that a particular driver supports. It's a 'compare' or
> 'match' operation. At this point, the driver is not attaching to the
> device; it's only checking that's its ok to attach.
> 
> So, how about naming it 'match', and changing the 
> {driver,device}_{,un}bind() in drivers/base/core.c to 
> {driver,device}_{,un}attach() (since those are what is doing the 
> attachment)?

Fine with me. This would be not confusing.

> The entire process, though, I think is still best described as "Driver 
> Binding", as it is a common, modern term for what's happening.

Common or not on unix driver binding has already a meaning and
the term confused at least one person (me).

Also please think about the following: terms should always
be related to the object they act *on* and not the object they
are the *method of* - becouse this is already known by the
"method from" relation. Therefore validate or match is more
"obvious" then bind at the respecitve places. IMHO.

