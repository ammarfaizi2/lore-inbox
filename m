Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273921AbRIRVCv>; Tue, 18 Sep 2001 17:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273923AbRIRVCm>; Tue, 18 Sep 2001 17:02:42 -0400
Received: from [64.66.225.143] ([64.66.225.143]:58116 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S273921AbRIRVCZ>; Tue, 18 Sep 2001 17:02:25 -0400
Date: Tue, 18 Sep 2001 16:00:40 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Joseph Cheek <joseph@cheek.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ide-]scsi timeouts while writing cdrom
Message-ID: <20010918160040.A27239@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Joseph Cheek <joseph@cheek.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10109142131030.28176-100000@forge.redmondlinux.org> <20010915122542.A23825@hapablap.dyn.dhs.org> <3BA79F09.9060509@cheek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA79F09.9060509@cheek.com>; from joseph@cheek.com on Tue, Sep 18, 2001 at 12:22:49PM -0700
X-Uptime: 3:54pm  up 19:27,  1 user,  load average: 1.08, 1.06, 1.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What chipset are you using?

On Tue, Sep 18, 2001 at 12:22:49PM -0700, Joseph Cheek wrote:
> cool, i turned off DMA on both cd's and it works now!  i still get 
> timeouts but not enough to crash the system.
> 
> Steven Walter wrote:
> 
> >With what drive chipset is this?
> >
> >In any event, try doing an 'hdparm -d0 /dev/hdd' and see if that fixes
> >it.  That will turn off DMA on the CD-RW, which is probably causing the
> >trouble.  If not, see if turning off DMA on /all/ the drives fixes it.
> >
> >I had a problem similar to this on my system, with an AMD-751 ide
> >controller.  To fix it, all I had to do was turn on CONFIG_EXPERIMENTAL
> >and then "AMD Viper ATA-66 Override (WIP)".  After that, the problem
> >went away.
> >
> >On Fri, Sep 14, 2001 at 09:36:26PM -0700, Joseph Cheek wrote:
> >
> >>hello all,
> >>
> >>my shiny new cdrw hangs the system when i try to burn a cdrom.  i've got a
> >>a completely IDE system.  hda and hdb are hard drives while hdc is a
> >>standard cdrom and hdd is a cdrw.
> >>
> >>while burning cdrecord writes a couple of tracks and then the whole system
> >>freezes [i need to hard power off].  i can blank cdrw's in the drive just
> >>fine, however.  i'm running 2.4.9-ac10 SMP [on a single-proc system] and
> >>all partitions are ext3.  ide-scsi is loaded as a module at boot.
> >>
> >>here's what /var/log/messages shows:
> >>
> >>Sep 14 21:12:45 sanfrancisco kernel: scsi : aborting command due to
> >>timeout : pid 0, scsi0, channel 0, id 1, lun 0 0x00 00 00 00 00 00
> >>Sep 14 21:12:54 sanfrancisco kernel: Device not ready.  Make sure there is
> >>a disc in the drive.
> >>Sep 14 21:12:55 sanfrancisco last message repeated 2 times
> >>Sep 14 21:13:20 sanfrancisco kernel: hdb: timeout waiting for DMA
> >>Sep 14 21:13:20 sanfrancisco kernel: ide_dmaproc: chipset supported
> >>ide_dma_timeout func only: 14
> >>Sep 14 21:13:26 sanfrancisco kernel: scsi : aborting command due to
> >>timeout : pid 0, scsi0, channel 0, id 1, lun 0 0x43 00 00 00 00 00 00 00
> >>0c 00
> >>Sep 14 21:13:37 sanfrancisco kernel: scsi : aborting command due to
> >>timeout : pid 0, scsi0, channel 0, id 0, lun 0 0x2a 00 00 00 05 92 00 00
> >>1f 00
> >>Sep 14 21:13:37 sanfrancisco kernel: hdc: timeout waiting for DMA
> >>Sep 14 21:13:37 sanfrancisco kernel: ide_dmaproc: chipset supported
> >>ide_dma_timeout func only: 14
> >>Sep 14 21:13:37 sanfrancisco kernel: hdd: status timeout: status=0xd8 {
> >>Busy }
> >>Sep 14 21:13:37 sanfrancisco kernel: hdd: DMA disabled
> >>Sep 14 21:13:37 sanfrancisco kernel: hdd: drive not ready for command
> >>Sep 14 21:13:41 sanfrancisco kernel: hdd: ATAPI reset complete
> >>Sep 14 21:13:41 sanfrancisco kernel: hdd: irq timeout: status=0xd0 { Busy
> >>}
> >>Sep 14 21:13:42 sanfrancisco kernel: hdd: ATAPI reset complete
> >>Sep 14 21:13:42 sanfrancisco kernel: hdd: irq timeout: status=0x80 { Busy
> >>}
> >>Sep 14 21:13:42 sanfrancisco kernel: scsi0 channel 0 : resetting for
> >>second half of retries.
> >>Sep 14 21:13:42 sanfrancisco kernel: SCSI bus is being reset for host 0
> >>channel 0.
> >>
> >>any guesses?
> >>
> >>thanks!
> >>
> >>joe
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >
> 

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
Freedom is slavery. Ignorance is strength. War is peace.
			-- George Orwell
