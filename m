Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262518AbTCIOim>; Sun, 9 Mar 2003 09:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262519AbTCIOim>; Sun, 9 Mar 2003 09:38:42 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:37903 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262518AbTCIOih>; Sun, 9 Mar 2003 09:38:37 -0500
Date: Sun, 9 Mar 2003 15:49:09 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4: high system load with SG_IO on IDE-SCSI: PIO?
Message-ID: <20030309144909.GA6475@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have seen readcd ("sg driver 3.2.0") use 96% system time for a readcd
-c2scan on IDE-SCSI (ATAPI CD-ROM, Plextor PX-4824TA 1.04, UDMA/33),
Linux 2.4.19+SuSE patches (k_athlon-2.4.19-167).

...
ioctl(3, 0x2285, 0xbfffec20)            = 0
...

The same application on a real SCSI-device with SCSI host adaptor
(aic7xxx FWIW) is way below 5% system CPU time.

Might SG_IO use PIO on ATAPI CD-ROMs? If so, are there patches to enable
DMA? Is this at all possible with SG_IO?

I find 96% system load is way too high for modern hardware. (Duron/700
that is, VIA 82C686a).

Thanks in advance,

-- 
Matthias Andree
