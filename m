Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSE3PTT>; Thu, 30 May 2002 11:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSE3PTS>; Thu, 30 May 2002 11:19:18 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47887 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316695AbSE3PS5>; Thu, 30 May 2002 11:18:57 -0400
Message-ID: <3CF63535.6000907@evision-ventures.com>
Date: Thu, 30 May 2002 16:20:37 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <UTC200205300019.g4U0JtH24034.aeb@smtp.cwi.nl>	<3CF622F0.4050304@evision-ventures.com>	<1022772774.12888.380.camel@irongate.swansea.linux.org.uk> 	<3CF62F2A.6030009@evision-ventures.com> <1022775219.9255.385.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Thu, 2002-05-30 at 14:54, Martin Dalecki wrote:
> 
>>I don't use and don't care about devfs - it's a misconception in my opinnion.
> 
> 
> Yes but there are lots of other opinions. And it was just one of several
> examples of why you were proposing something utterly bogus
> 
> 
> 
>>And last but not least: some devices which should be viewd as "same type"
>>are hooked up to different major numbers instead of sharing them.
>>Most prominent here are the differences between SCSI disks and ATA disks
>>for example. From a technical point of view they don't make *any* sense.
> 
> 
> Linus has explicitly stated he wants to do this and make all disks
> appear the same and the same place. It actually makes lots of sense. 

LAST WARNING:

Every body out there: watch out to use LABEL= in /etc/fstab or you will
not be able to reboot between 2.4 and 2.5 soon!

Things which have to be done in front:

1. Extract device registration from SCSI code.

2. Let the ATA/ATAPI code hook up on it. (ide-cs is the most difficult one.)

3. Let the old ATA/ATAPI major go down the bin...

