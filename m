Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274783AbRIUSyA>; Fri, 21 Sep 2001 14:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274784AbRIUSxv>; Fri, 21 Sep 2001 14:53:51 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:47371 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S274783AbRIUSxf>; Fri, 21 Sep 2001 14:53:35 -0400
Date: Fri, 21 Sep 2001 20:53:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg Ward <gward@python.net>
Cc: bugs@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Message-ID: <20010921205356.A1104@suse.cz>
In-Reply-To: <20010921134402.A975@gerg.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010921134402.A975@gerg.ca>; from gward@python.net on Fri, Sep 21, 2001 at 01:44:02PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 01:44:02PM -0400, Greg Ward wrote:
> Having problems with an ATA/100 drive under Linux 2.4.{2,9}.
> 
> drive: Seagate Barracuda IV 80 GB (ST380021A)
> motherboard: ASUS A7V (VIA Apollo KT133 chipset)
> ide0, ide1: VIA VT82C686A
> ide2, ide3: Promise PDC20265 (these are the ATA/100 interfaces)
>   (all four IDE interfaces are right on the motherboard)
> 
> I have tried connecting the drive to both ide0 and ide2, with both a
> 40-conductor and 80-conductor cable.
> 
> Under 2.4.2, there was a very lengthy delay at boot time with this
> output:
>   Partition check:
>    hda:hda: timeout waiting for DMA
>   ide_dmaproc: chipset supported ide_dma_timeout func only: 14
>   hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
>   [...repeat 2 times...]
>   hda: DMA disabled
>   ide0: reset: success
>    hda1
> 
> Eventually the system booted, but the drive was really slow (no DMA).
> When I forced DMA on ("hdparm -d1 /dev/hda"), I got the same lengthy
> sequence of output as I had at boot time, and eventually the kernel
> turned DMA off again.
> 
> So far nothing new -- from the linux-kernel archive, I'm not the first
> person to report this problem in early 2.4 kernels.
> 
> Under 2.4.9, the boot-time delay is not quite as long, but it's still
> there.  And it's not nearly as noisy.  However, the end-result is the
> same: DMA is disabled for this drive; it's a lot slower than an ATA/100
> drive ought to be; if I force DMA back on, the first access to the drive
> has another looong delay that results in the kernel turning DMA back
> off.  Grumble.
> 
> This is a brand-new drive and brand-new cable.  The motherboard's only
> about 9 months old.
> 
> So: is this in fact a kernel problem? or is it more likely to be a cable
> problem, a motherboard problem, or a hard drive problem?

Do you have the VIA IDE support enabled?

-- 
Vojtech Pavlik
SuSE Labs
