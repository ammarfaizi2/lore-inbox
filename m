Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317638AbSGZJ6u>; Fri, 26 Jul 2002 05:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSGZJ6u>; Fri, 26 Jul 2002 05:58:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15112 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317638AbSGZJ57>; Fri, 26 Jul 2002 05:57:59 -0400
Message-ID: <3D411CB0.9000206@evision.ag>
Date: Fri, 26 Jul 2002 11:56:00 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 104
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>		<3D40F8F9.1050507@evision.ag>	<1027678411.13428.3.camel@irongate.swansea.linux.org.uk> 	<3D411134.60904@evision.ag> <1027680390.13428.33.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Fri, 2002-07-26 at 10:07, Marcin Dalecki wrote:
> 
>>The only thing which is really 'external API' there is the declaration
>>of the HDIO_XXX ioctl and among them in reality only HDIO_GETGEO 
>>      is really used outside the scope of the dreddy hdparm application. 
>>And
>>99% of times its usage is bogous anyway. Or do you know any better
>>examples I'm not aware of?
> 
> 
> The struct hd_geometry is used by ioctl HDIO_GETGEO. 
> The struct hd_driveid is used by ioctl HDIO_GETIDENTITY
> 
> 
>>The remainings will be moved away from there soon becouse it doesn't
>>make any sense to include this at every single place out there where
>>HDIO_GETGEO is the needed declaration. If some application needs ATA 
> 
> 
> This would be great, right now lots of drivers suck in the file for the 
> GETGEO stuff even though they are nothing to do with st506 or ide.

:-). That's the intention indeed behind the above game.
Please look at IDE patch nr 105. There is a change to the IDE parts to
include hdparm.h explicitely. The next change will be to let them
include a new header containing the definitions of ATA commands. This
time I will remove the ATA stuff from hdparm.h In hdparm only the
declarations of the ioctl stuff will with the two structures will
remain. At this point I will throw the double underscores in front of
the uXX-es to suite you.

OK?



