Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279502AbRJ2UwM>; Mon, 29 Oct 2001 15:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279500AbRJ2UwC>; Mon, 29 Oct 2001 15:52:02 -0500
Received: from f05s15.cac.psu.edu ([128.118.141.58]:18900 "EHLO
	f05n15.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S279499AbRJ2Uvx>; Mon, 29 Oct 2001 15:51:53 -0500
Message-ID: <3BDDC1D5.2040305@stones.com>
Date: Mon, 29 Oct 2001 15:53:41 -0500
From: Justin Mierta <Crazed_Cowboy@stones.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.5) Gecko/20011011
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: ECS k7s5a motherboard doesnt work
In-Reply-To: <Pine.LNX.4.10.10110291523140.27909-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>2) its not the cables, i checked them
>>
>most people are unaware that IDE must always be <=18".  I mean no
>insult, but do you know the rules for ide?
>

no, i'm not taking it as an insult, but yes, they are shorter than 18". 
 i dont have any cables that long, but i wouldnt expect them to work at 
all at ata100 if they were that long....(hence why i figured saying that 
it works in the other OSs was also saying the cables were shorter than 18")

>>3) its not the ram, i checked it
>>
>how?
>
this motherboard is an upgrade.  the old motherboard/ram/processor 
worked fine in all the linux's, as well as freebsd and beos.  i put that 
ram in there (pc133), and i still get dma errors.  i also tried my 
roommate's ddr ram (he used to use linux with it), and still the dma errors.

>>4) its not the harddrive, cdroms - they worked fine in linux before i 
>>upgraded the mobo
>>
>same arrangement?
>
yeah.  in fact, they were never unplugged (except for obviously from the 
motherboard) until i was testing the cables.

>>8) seems to be having real dma issues.  BeOS doesnt use DMA, and i'm 
>>pretty sure that FreeBSD wasnt either (because it wasnt familiar with 
>>the chipset, so was just going thru the bios)
>>
>what mode does it come up in?  do you do some hdparm tweaking?
>anything in /proc/ide?
>
well, when freebsd boots it says a few lines about "Drive C: bios" or 
something like that.  i'm not really very familiar with it.  but no, i 
didnt use any special settings.  its not exactly easy, but i can 
probably get you the first few lines of dmesg if you think it'll help

>>9) *new* - the machine is not overheating, the hottest spot is at a cool 
>>57 C
>>
>57C is hardly cool, though it shouldn't cause problems.
>
last i saw, amd rates these chips at 95C, so 57 is downright chilly :)

>>now i'm not sure where the problem is, but it seems pretty clearly to me 
>>that it is dma-related.  neither BeOS or FreeBSD is trying to use dma, 
>>and they work. i'm pretty sure windows is using dma, but its using the 
>>drivers that came with the mobo.  linux is trying to use dma using 
>>drivers not written by ECS, and it doesnt work.
>>
>udma or even mdma?  if mdma, does hdparm -m settings effect it?
>
i'm not sure how to check, and i have a very difficult time even getting 
to a shell in linux, because the damn thing keeps dma erroring about 
reading the cd's.  is there some boot-up settings i can feed it so it 
wont try using dma at all?


>>or that there's some minor timing quirk (like a 
>>race condition) in the linux driver that my computer just likes to hit? 
>>
>unlikley.  in part because the sis driver, like most others,
>doesn't do much itself, since the interesting/subtle parts of 
>doing ide are all done in generic code.
>
>but why do you mention timing?  sure, the sis driver is hardly the most
>well tested (widely used) driver, so perhaps it fiddles a reg that 
>needs a microsecond of "rest" afterwards.
>
i just mentioned timing, because in my (somewhat limited) experience 
writing drivers, timing booboos tend to be the cause of lots of problems 
(especially when timeouts are involved)

>>at this point, i'm tending to think that there's several versions of 
>>sis735 floating around (similar to the maneuver that ensoniq pulled with 
>>their sound cards) -- possibly even within the revisions of the k7s5a 
>>motherboard itself.
>>
>lspci /proc/pci will give you the revisions of the chipset components.
>
again, cant easily get to a command prompt in linux, making things like 
this very difficult :)

i think the best thing is to try and find a startup parameter to prevent 
it from using dma, and see if that works.  anyone know how? :)

justin

