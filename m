Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbTCJLVD>; Mon, 10 Mar 2003 06:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbTCJLVD>; Mon, 10 Mar 2003 06:21:03 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:35087 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261297AbTCJLVC>; Mon, 10 Mar 2003 06:21:02 -0500
Date: Mon, 10 Mar 2003 12:31:39 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: high system load with SG_IO on IDE-SCSI: PIO?
Message-ID: <20030310113139.GA6101@merlin.emma.line.org>
Mail-Followup-To: Douglas Gilbert <dougg@torque.net>,
	linux-kernel@vger.kernel.org
References: <3E6C2436.1000007@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E6C2436.1000007@torque.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003, Douglas Gilbert wrote:

> The experience from the early 2.4 series was that the ide
> subsystem was too aggressive in its DMA settings for CD/DVD
> burners. [My experience with scsi devices is that disks have
> much better target implementations (i.e. more robust) than
> CD/DVD devices and scanners.] Later versions of the 2.4 series

ATAPI scanners? Cool stuff. Seriously, there is cheap ATAPI junk and
there is serious stuff.

> are a lot more conservative in their speed treatment of ATAPI
> devices. The robustness comes at the expense of system load.

Well, some amount of configurability would be nice for the ones of us
who have working ATAPI hardware. Even if it's a boot-time parameter like
"hdc=atapidma" or something (that's what FreeBSD does, with the
boot-time variable hw.ata.atapi_dma, it defaults to 0 but drop
hw.ata.atapi_dma="1" into /boot/loader.conf.local and have the machine
talk DMA to ATAPI stuff). Am I missing such an option?

I am currently facing the choice "switch to some other OS that talks DMA
to my CD-writer" or "buy an ATAPI-SCSI-converter" (which is above 100
EUR). I'd like to have a third option to choose, tell the kernel "forget
your sorrows and talk DMA." -- it could use a (user-space) whitelist,
say "Plextor CD-R   4824TA 1.04 is fine".

> ** Even though a CD writer appears as /dev/scd0 with ide-scsi
> appropriately configured, the hdparm command can still be used
> on /dev/hdd (for example, if the writer is the slave on the
> second IDE bus).

/sbin/hdparm -X66 -d1 -u1 happens at boot time (for hdc) -- still I'm
facing unreasonably high system load when writing a CD.

-- 
Matthias Andree
