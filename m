Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWFYLaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWFYLaF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWFYLaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:30:05 -0400
Received: from mail1.skjellin.no ([80.239.42.67]:4826 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S932374AbWFYLaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:30:02 -0400
Message-ID: <449E73C1.4050604@tomt.net>
Date: Sun, 25 Jun 2006 13:30:09 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060622)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and Power Management
 patches against v2.6.17
References: <20060625073003.GA21435@htj.dyndns.org>
In-Reply-To: <20060625073003.GA21435@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Hello, all.
> 
> libata-tj-stable patches against v2.6.17 and v2.6.17.1 are available.

It appears drivers/scsi/libata-eh.c isn't getting built in the 2.6.17 
patch, seems to be missing in drivers/scsi/Makefile:

> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map -b /build/kernel/linux-2.6.17/debian/linux-image-2.6.17-1-vs-exp -r 2.6.17-1-vs-exp; fi
> WARNING: /build/kernel/linux-2.6.17/debian/linux-image-2.6.17-1-vs-exp/lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/libata.ko needs unknown symbol ata_scsi_timed_out
> WARNING: /build/kernel/linux-2.6.17/debian/linux-image-2.6.17-1-vs-exp/lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/libata.ko needs unknown symbol ata_qc_schedule_eh
> WARNING: /build/kernel/linux-2.6.17/debian/linux-image-2.6.17-1-vs-exp/lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/libata.ko needs unknown symbol ata_scsi_error
> WARNING: /build/kernel/linux-2.6.17/debian/linux-image-2.6.17-1-vs-exp/lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/libata.ko needs unknown symbol ata_port_wait_eh
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_vsc.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_via.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_uli.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_sx4.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_svw.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_sis.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_sil24.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_sil.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_qstor.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_promise.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_nv.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/sata_mv.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/pdc_adma.ko ignored, due to loop
> WARNING: Loop detected: /build/kernel/linux-2.6.17/debian/linux-image-2.6.17-1-vs-exp/lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/libata.ko which needs libata.ko again!
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/libata.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/ata_piix.ko ignored, due to loop
> WARNING: Module /lib/modules/2.6.17-1-vs-exp/kernel/drivers/scsi/ahci.ko ignored, due to loop
> make[1]: Leaving directory `/build/kernel/linux-2.6.17/build/linux-image-2.6.17-1-vs-exp'
