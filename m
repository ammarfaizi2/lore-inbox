Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbRLURDJ>; Fri, 21 Dec 2001 12:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284969AbRLURC7>; Fri, 21 Dec 2001 12:02:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20234 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284965AbRLURCt>;
	Fri, 21 Dec 2001 12:02:49 -0500
Date: Fri, 21 Dec 2001 18:01:56 +0100
From: Jens Axboe <axboe@kernel.org>
To: rwhron@earthlink.net
Cc: Jens Axboe <axboe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011221180156.C2929@suse.de>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221114352.A8661@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011221114352.A8661@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21 2001, rwhron@earthlink.net wrote:
> On Fri, Dec 21, 2001 at 03:46:54PM +0100, Jens Axboe wrote:
> > You neglected to mention what disk I/O system you are using? IDE or
> > SCSI, and if the latter what host adapter?
> > 
> > -- 
> > Jens Axboe
> 
> Sorry about that.  It's an IDE drive.
> 
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> 00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
> 00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
> 00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)
> 
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=m
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_IDE_MODES=y

Thanks -- could you also try and do sysrq-t back traces when it seems
stuck?

Does a non-highmem kernel run ok?

-- 
Jens Axboe

