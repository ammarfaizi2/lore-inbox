Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275086AbSITFXe>; Fri, 20 Sep 2002 01:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275087AbSITFXe>; Fri, 20 Sep 2002 01:23:34 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:21272 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S275086AbSITFXd>; Fri, 20 Sep 2002 01:23:33 -0400
Date: Fri, 20 Sep 2002 08:28:32 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Cc: Jani Forssell <jani.forssell@viasys.com>
Subject: 2.4.20pre7, aic7xxx-6.2.8: Panic: HOST_MSG_LOOP with invalid SCB 0
Message-ID: <20020920052832.GH41965@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>, gibbs@scsiguy.com,
	linux-kernel@vger.kernel.org,
	Jani Forssell <jani.forssell@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Celeron 1.3GHz, Intel i815 chipset, 512MB ram.

AIC-2640 PCI card with uw and narrow connectors. A Seagate scsi disk
(rootfs) attached to uw, and a HP tape drive attached to narrow. Tape drive
never used.

I only ran 2.4.20pre7 (no other patches) for a night and it crashed:

-------------------------------------------------------------------
Kernel panic: HOST_MSG_LOOP with invalid SCB 0

In interrupt handler, not syncing
-------------------------------------------------------------------


Boot log snippet:
-------------------------------------------------------------------
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2940 SCSI adapter>
        aic7870: Wide Channel A, SCSI Id=7, 16/253 SCBs

  Vendor: SEAGATE   Model: ST19171W          Rev: 0024
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: HP        Model: C1537A            Rev: L708
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17783112 512-byte hdwr sectors (9105 MB)
 sda: sda1 sda2 < sda5 sda6 >
-------------------------------------------------------------------

.config
-------------------------------------------------------------------
_SCSI_AIC7XXX=y
_AIC7XXX_CMDS_PER_DEVICE=8
_AIC7XXX_RESET_DELAY_MS=15000
IG_AIC7XXX_PROBE_EISA_VL is not set
IG_AIC7XXX_BUILD_FIRMWARE is not set
-------------------------------------------------------------------

2.2.18pre18 with aic7xxx-5.1.31 was solid on this box (the motherboard has
been changed since, though).

 
-- v --

v@iki.fi
