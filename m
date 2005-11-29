Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVK2PL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVK2PL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVK2PL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:11:59 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:20616 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751373AbVK2PL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:11:58 -0500
Date: Tue, 29 Nov 2005 10:11:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: cx88 totally fried in 2.6.15-rcX -was- Re: HD3000 - no NTSC via
 tuner
In-reply-to: <438BDF72.1000704@m1k.net>
To: linux-kernel@vger.kernel.org
Cc: Michael Krufky <mkrufky@m1k.net>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Message-id: <200511291011.20688.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <200511282340.46506.gene.heskett@verizon.net> <438BDF72.1000704@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 November 2005 23:56, Michael Krufky wrote:
>Gene Heskett wrote:
>>On Monday 28 November 2005 22:43, Michael Krufky wrote:
>>>Michael Krufky wrote:
>>>>Gene Heskett wrote:
>>>>>Like I said, complete instructions please so that we are on the
>>>>> same page.  I still have the rc2-git6 tree that didn't work, so as
>>>>> my script does a make clean, it should be easy enough to do with
>>>>> the right instructions.  Like what dir in the kernel tree am I
>>>>> supposed to be in when I issue the cvs checkout command etc.
>>>
>>>Oops.... I forgot to answer this question....
>>>
>>>It doesnt matter in what directory you are issuing the commands
>>>below... Although you certainly should NOT issue these within your
>>>kernel source, and you should be inside the newly-downloaded v4l-dvb
>>>tree after you "cd" into it.  I recommend either doing this in your
>>>~home directory, or in /usr/src
>>
>>I built it in /usr/src, seemed to be ok ANAICT.  It just didn't work.
>>Bear in mind I have no ATSC signals out here in the West Virginia
>> hills yet, all ntsc.  So I can't as yet test the ATSC side.
>
>Very interesting...  This whole time I thought that your testing was
>using a VSB stream.
>
>So, you're only talking about problems with analog NTSC?
>
Correct.

And there is one difference between the modprobe cx88-dvb that works,
and the ones that don't.  The ones that do report:
kernel: DVB: registering new adapter (cx88[0]).
kernel: DVB: registering frontend 0 (Oren OR51132 VSB/QAM Frontend)...

echoed on the cli, those that don't work are silent.

The complete section from the messages file is:
Nov 28 23:25:55 coyote kernel: Linux video capture interface: v1.00
Nov 28 23:25:55 coyote kernel: cx2388x v4l2 driver version 0.0.5 loaded
Nov 28 23:25:55 coyote kernel: ACPI: PCI Interrupt Link [LNK2] enabled
at IRQ 5
Nov 28 23:25:55 coyote kernel: ACPI: PCI Interrupt 0000:01:07.0[A] ->
Link [LNK2] -> GSI 5 (level, low) -> IRQ 5
Nov 28 23:25:55 coyote kernel: CORE cx88[0]: subsystem: 7063:3000,
board: pcHDTV HD3000 HDTV [card=22,autodetected]
Nov 28 23:25:55 coyote kernel: TV tuner 52 at 0x1fe, Radio tuner -1 at
0x1fe
Nov 28 23:25:55 coyote kernel: i2c-algo-bit.o: cx88[0] passed test.
Nov 28 23:25:55 coyote kernel: tuner 2-0061: chip found @ 0xc2 (cx88[0])
Nov 28 23:25:55 coyote kernel: tuner 2-0061: type set to 52 (Thomson DDT
7610 (ATSC/NTSC))
Nov 28 23:25:55 coyote kernel: cx88[0]/0: found at 0000:01:07.0, rev: 5,
irq: 5, latency: 32, mmio: 0xea000000
Nov 28 23:25:55 coyote kernel: cx88[0]/0: registered device video0
[v4l2]
Nov 28 23:25:55 coyote kernel: cx88[0]/0: registered device vbi0
Nov 28 23:25:55 coyote kernel: cx88[0]/0: registered device radio0
Nov 28 23:25:55 coyote kernel: cx2388x dvb driver version 0.0.5 loaded
Nov 28 23:25:55 coyote kernel: ACPI: PCI Interrupt 0000:01:07.2[A] ->
Link [LNK2] -> GSI 5 (level, low) -> IRQ 5
Nov 28 23:25:55 coyote kernel: cx88[0]/2: found at 0000:01:07.2, rev: 5,
irq: 5, latency: 32, mmio: 0xeb000000
Nov 28 23:25:55 coyote kernel: cx88[0]/2: cx2388x based dvb card

Now, from a 2.6.15-rc2-git6 + cvs boot that doesn't work:
Nov 28 23:15:24 coyote kernel: Linux video capture interface: v1.00
Nov 28 23:15:24 coyote kernel: cx2388x v4l2 driver version 0.0.5 loaded
Nov 28 23:15:24 coyote kernel: ACPI: PCI Interrupt Link [LNK2] enabled
at IRQ 5
Nov 28 23:15:24 coyote kernel: ACPI: PCI Interrupt 0000:01:07.0[A] ->
Link [LNK2] -> GSI 5 (level, low) -> IRQ 5
Nov 28 23:15:24 coyote kernel: CORE cx88[0]: subsystem: 7063:3000,
board: pcHDTV HD3000 HDTV [card=22,autodetected]
Nov 28 23:15:24 coyote kernel: TV tuner 52 at 0x1fe, Radio tuner -1 at
0x1fe
Nov 28 23:15:24 coyote kernel: i2c-algo-bit.o: cx88[0] passed test.
Nov 28 23:15:24 coyote kernel: tuner 2-0061: chip found @ 0xc2 (cx88[0])
Nov 28 23:15:24 coyote kernel: tuner 2-0061: type set to 52 (Thomson DDT
7610 (ATSC/NTSC))
Nov 28 23:15:24 coyote kernel: cx88[0]/0: found at 0000:01:07.0, rev: 5,
irq: 5, latency: 32, mmio: 0xea000000
Nov 28 23:15:24 coyote kernel: cx88[0]/0: registered device video0
[v4l2]
Nov 28 23:15:24 coyote kernel: cx88[0]/0: registered device vbi0
Nov 28 23:15:24 coyote kernel: cx88[0]/0: registered device radio0
Nov 28 23:15:25 coyote kernel: cx2388x dvb driver version 0.0.5 loaded
Nov 28 23:15:25 coyote kernel: ACPI: PCI Interrupt 0000:01:07.2[A] ->
Link [LNK2] -> GSI 5 (level, low) -> IRQ 5
Nov 28 23:15:25 coyote kernel: cx88[0]/2: found at 0000:01:07.2, rev: 5,
irq: 5, latency: 32, mmio: 0xeb000000
Nov 28 23:15:25 coyote kernel: cx88[0]/2: cx2388x based dvb card
Nov 28 23:15:25 coyote kernel: DVB: registering new adapter (cx88[0]).
Nov 28 23:15:25 coyote kernel: DVB: registering frontend 0 (Oren OR51132
VSB/QAM Frontend)...

Which *looks* the same to me, but it doesn't work.  Those last 2 lines
that are normally echoed to the cli, are not with the newer code
although they are in the messages log.

>It seems that I might be having a similar (but NOT the same) problem
>with my FusionHDTV3 Gold-T, but it has nothing to do with the kernel
>version.  Let me remind you that this card uses Thomson DDT 7611, and
>your card uses Thomson DDT 7610.  It simply doesnt work anymore,
>regardless of whether I am in Linux or Windows, no matter which kernel
>version.  Only digital ATSC (using QAM256) is working for me.
>
>I will have to test NTSC using my FusionHDTV5 Gold, installed in my
>other box.  It doesnt have 2.6.15 installed right now.  I will wait for
>2.6.15-rc3 to propogate to the kernel.org mirrors before I install it,
>so this may take some time.  The other card, however, has a TUA6034
>tuner, inside an LG TDVS-H062F ... not the same tuner as you this time,
>but still a cx88 board.
>
>Anyway, after 2.6.15-rc3 propogates and I get it installed, I'll let
> you know how my testing goes.  Would you do the same?

Yes of course.  I need to do some housekeeping in my grub.conf though,
I'm currently up to 24 entries. :)  So stuff before 2.6.14 is about to
go away.

>Cheers,
>
>Mike

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

