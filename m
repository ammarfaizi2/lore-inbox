Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031161AbWI0WfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031161AbWI0WfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031162AbWI0WfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:35:17 -0400
Received: from post-24.mail.nl.demon.net ([194.159.73.194]:27843 "EHLO
	post-24.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1031161AbWI0WfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:35:15 -0400
Message-ID: <451AFCA1.4060407@rebelhomicide.demon.nl>
Date: Thu, 28 Sep 2006 00:35:13 +0200
From: Michiel de Boer <x@rebelhomicide.demon.nl>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Chipset addition for the VIA Southbridge workaround /
 quirk
References: <451AE795.6030804@rebelhomicide.demon.nl> <1159393487.1275.52.camel@mindpipe>
In-Reply-To: <1159393487.1275.52.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2006-09-27 at 23:05 +0200, Michiel de Boer wrote:
>   
>> Also built in is an Creative Labs SB Live! audio device. When i was
>> still using windows 98, i experienced corruptions when burning DVD's,
>> and after lengthy investigation i discovered i had a buggy
>> southbridge.[1]
>> Apparently the presence of the SB Live! audio device might even
>> accelerate the problem, although it does not actually disappear when
>> this PCI card is removed. When i moved to Linux, i decided that
>> writing a kernel patch based on the fixup programs i found for windows
>> 98 would be appropriate. 
>>     
>
> Just FYI, the onboard "SBLive" is not a real SBLive! - it uses a newer,
> cheaper, and vastly inferior chipset that moves all of the interesting
> hardware features of the good old SBLive! into the (Windows) driver. 
>
> I would be surprised if it had the same issues as the original emu10k1
> chipset, which generated a lot more bus traffic by implementing multiple
> stream mixing in hardware.
>
> IOW, this bug is probably unrelated to the SBLive...
>
> Lee
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   
Lee,

I might have led you to think i meant an onboard card because of my 
wording, sorry.
It's a PCI extension card, here's some output from lspci:

00:09.0 Multimedia audio controller [0401]: Creative Labs SB Live! 
EMU10k1 [1102:0002] (rev 08)
        Subsystem: Creative Labs CT4832 SBLive! Value [1102:8027]
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at dc00 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

However, you're right, the role of this sound card in creating or 
accellerating the data corruption has been
disputed. I might as well be irrelevant. When i remove it, i still have 
data corruption problems when burning
DVD's. I've tested all this back when i was investigating to make sure. 
The discussion, (iirc, because i can't
find the specific articles anymore) revolved around Creative 
interpreting certain PCI specs wrather loosely.

Regards, Michiel de Boer

