Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSGIMZw>; Tue, 9 Jul 2002 08:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSGIMZv>; Tue, 9 Jul 2002 08:25:51 -0400
Received: from [195.63.194.11] ([195.63.194.11]:27141 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314602AbSGIMZu> convert rfc822-to-8bit; Tue, 9 Jul 2002 08:25:50 -0400
Message-ID: <3D2AD6EE.6020303@evision-ventures.com>
Date: Tue, 09 Jul 2002 14:28:30 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Paul Bristow <paul@paulbristow.net>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
References: <20020703155113.GA26299@zombie.inka.de> <3D2913C9.3030409@evision-ventures.com> <3D29F70D.6020001@paulbristow.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Paul Bristow napisa³:
> OK.  I kept quiet while the IDE re-write went on so that when it was 
> over I could fix up ide-floppy and start adding some of the requested 
> features that were only really possible with the taskfile capabilities. 
> But I have to jump in with the latest statements from Martin... 
> Martin Dalecki wrote:
> 
>> U¿ytkownik Eduard Bloch napisa³:
>>  
>>
>>> Why not another way round? Just make the ide-scsi driver be prefered,
>>> and hack ide-scsi a bit to simulate the cdrom and adv.floppy devices
>>> that are expected as /dev/hd* by some user's configuration?
>>>   
>>
>>
>> This is the intention.
>>
> Since when?  I thought Jens was in the process of getting rid of the 
> ide-scsi kludge with his moves to support cd/dvd writing directly in 
> ide-cd?

Well code decides. And in reality I have tried the much simpler goal
to unify the ide-floppy ide-tape and ide-cd parts which
should be common. Like for example a simple SCSI multi media command set
preparation library. Admittedly I have failed. Therefore and in
fact of the 2.6 release schedule it's simple not practical to
persue this road further. It makes much more sense to just

1. Scrap the specific atapi drivers.

2. Try to make ide-scsi independant from SCSI subsystem from users view.

3. Replicate some of the workarounds in the previous ide-xxxx drivers.

> 
> The current system may be ugly, but if we have to break it in the name 
> of progress we have at least to make the new, improved version work as 
> well (and hopefully better) than the old one.
> 
>>> Other operating systems did switch to constitent (scsi-based) way of
>>> accessing all kinds of removable media drivers. Why does Linux have to
>>> keep a kludge, written years ago without having a good concept?
>>>
>>>   
>>
> If we can address all these issues I will be extremely happy to helping 
> create a sensible removeable media subsystem.

That's a deal.



