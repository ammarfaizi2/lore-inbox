Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVH3US4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVH3US4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVH3US4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:18:56 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:20648 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S932432AbVH3US4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:18:56 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Harald Welte <laforge@gpl-violations.org>,
       LKML <linux-kernel@vger.kernel.org>
X-X-Sender: dlang@dlang.diginsite.com
Date: Tue, 30 Aug 2005 13:17:47 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: APs from the Kernel Summit run Linux
In-Reply-To: <20050830121810.GA11582@midnight.suse.cz>
Message-ID: <Pine.LNX.4.62.0508301315170.12108@qynat.qvtvafvgr.pbz>
References: <20050830085522.GA8820@midnight.suse.cz> <20050830101958.GJ4202@rama.de.gnumonks.org>
 <20050830121810.GA11582@midnight.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking into the airlink devices (fry's house brand) and they 
have a marvell based AP (the one that made /. a few weeks go, sells for 
$17 on sale). when I contacted airlink about getting the source they 
replaied that current versions only run in-house developed code, no eCos 
or uCLinux code, even thought the Libertas AP-32 and -52 kits provide no 
help in running anything else.

so far nobody has been able to uncompress the firmware to prove different.

David Lang

On Tue, 30 Aug 2005, Vojtech Pavlik wrote:

> On Tue, Aug 30, 2005 at 12:19:59PM +0200, Harald Welte wrote:
>
>>> The D-Link DWL-G730AP devices from the Kernel Summit run Linux, And it's
>>> likely a GPL violation, too, since sources are nowhere to be found.
>>
>> *lol*. Interestingly they must have twiddled the IP stack since when I
>> tried an "nmap" on the device, it didn't recognize it as a Linux TCP/IP
>> stack.
>
>>> They're based on a Marvell Libertas AP-32 (ARM9) design, similar
>>> to the ASUS WL-530g. A bootlog from the ASUS (which has telnet enabled
>>> for some reason, and thus can be logged in) is at the end of the mail.
>>
>> So you grabbed that bootlog from the ASUS device, or from the D-Link?
>
> This is from the ASUS.
>
>> If it is from the ASUS, what makes you think that the D-Link runs the
>> same OS?  It is quite often the case that one chipset design has
>> multiple operating systems ported to it (you see systems with the same
>> broadcom or Intersil chipset, one running Linux, the other VxWorks).
>
>> Please indicate how you came to the conclusion that the D-Link really
>> runs Linux.
>
> The device's ESSID during boot is 'Marvell AP-32', and the Libertas
> AP-32 and AP-52 design toolkits contain only ports of Linux and eCos to
> the device, according to Marvell. Considering the device's routing
> capabilities I'm believe it's running Linux, but I don't have a solid
> proof yet, unfortunately. The eCos port is intended for the non-router
> variety of the design.
>
> On the other hand, eCos seems to be GPL, too, although it's possible
> that the owner dual-licenses it.
>
>>> A firmware image is available from D-Link
>>> and it seems to be composed of compressed blocks padded by zeroes. I haven't
>>> verified yet that it's indeed a compressed kernel, cramfs, etc, but it seems
>>> quite likely.
>>
>> I'm downloading it right now, and I'll see whether I can find any Linux
>> in there.
>
> Good luck. I'll try to take a look, too.
>
>>> Anyone interested in dissecting it, and pushing D-Link/Marvell to release
>>> the kernel sources?
>>
>> Sure, it's (unfortunately) not the first time I'm dealing with D-Link on
>> their GPL [in]compliance :((
>
> Rather unrelated, I'm trying to figure out what to do with Elo
> Touchsystems, they used my HID driver as a base of their own binary-only
> driver and don't answer to e-mail.
>
>>> I'd love to get more out of this cute device ...
>>
>> If the design really is identical enough to the ASUS device, then I
>> suggest looking into
>> http://dlsvr02.asus.com/pub/ASUS/wireless/WL-530g/GPL_1825.zip
>
> I'll take a look, thanks!
>
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
