Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSIJRLz>; Tue, 10 Sep 2002 13:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSIJRLy>; Tue, 10 Sep 2002 13:11:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45582 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316856AbSIJRLx>;
	Tue, 10 Sep 2002 13:11:53 -0400
Message-ID: <3D7E28D3.4070200@mandrakesoft.com>
Date: Tue, 10 Sep 2002 13:16:03 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
References: <Pine.LNX.4.44.0209100947481.2842-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Tue, 10 Sep 2002, David Brownell wrote:
> 
>>>In short:
>>> 
>>>  Either you want debugging (in which case BUG() is the wrong thing to
>>>  do), or you don't want debugging (in which case BUG() is the wrong thing
>>>  to do). You can choose either, but in neither case is BUG() acceptable.
>>
>>Or in even shorter sound bite format:  "Just say no to BUG()s."
> 
> 
> Well, the thing is, BUG() _is_ sometimes useful. It's a dense and very 
> convenient way to say that something catastrophic happened.
> 
> And actually, outside of drivers and filesystems you can often know (or
> control) the number of locks the surrounding code is holding, and then a
> BUG() may not be as lethal. At which point the normal "oops and kill the
> process" action is clearly fine - the machine is still perfectly usable.


I know you probably don't like the name, but all over the kernel people 
are using BUG() as ASSERT()... so why not create what people want?

IMO we should have ASSERT() and OHSHIT(), the latter being the true 
meaning and current implementation of BUG(), the former being used when 
the machine is still useable.

	Jeff



