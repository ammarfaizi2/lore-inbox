Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSEHJYQ>; Wed, 8 May 2002 05:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312576AbSEHJYP>; Wed, 8 May 2002 05:24:15 -0400
Received: from [195.63.194.11] ([195.63.194.11]:45574 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312619AbSEHJYO>; Wed, 8 May 2002 05:24:14 -0400
Message-ID: <3CD8DFF9.3020701@evision-ventures.com>
Date: Wed, 08 May 2002 10:21:13 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <E1759fR-0008Dg-00@the-village.bc.nu>	<Pine.LNX.4.44.0205071114200.975-100000@home.transmeta.com> <200205071840.g47Ie1m32403@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Richard Gooch napisa³:
> Linus Torvalds writes:
> 
>>
>>On Tue, 7 May 2002, Alan Cox wrote:
>>
>>>>>Fugly. What's wrong with readlink(2) as this "magic syscall"?
>>>>
>>>>Ehh - like the fact that it doesn't work on device files?
>>>
>>>I can't find anything in Posix/SuS that says it isnt allowed to however 8)
>>
>>We can certainly do it, it just doesn't buy us much of anything, since
>>none of the standard tools (ie "ls") will actually do the readlink() for
>>anything but a symlink.
>>
>>So at that point it's just another magic syscall, except we've overloaded
>>an old one.
>>
>>Which may certainly be acceptable, of course.
> 
> 
> I wasn't suggesting a magic readlink(2). I was suggesting a *real*
> one. Device nodes get stored in the physical tree (what you call
> driverfs), and the entries in the logical tree are symlinks. Such as:
> 
> 	/dev/scsi/host0  symlink to  /dev/bus/pci0/slot1/function2
> 
> or something like that. Easy to implement, easy to understand, easy to
> manage.

Now you take the last step toward solaris and realize why I was
always against your solution (no personal offence)
to the device management problem - they do it all in user space
by precisely the above symlink system....

