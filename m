Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbUC1R66 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUC1R65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:58:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33749 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262269AbUC1R6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:58:46 -0500
Message-ID: <40671249.8030008@pobox.com>
Date: Sun, 28 Mar 2004 12:58:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phil Rigby <phil@philrigby.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA: Bug?
References: <4066B2FE.1020903@philrigby.com>
In-Reply-To: <4066B2FE.1020903@philrigby.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Rigby wrote:
> VFS: Mounted root (ext2 filesystem).
> SCSI subsystem initialized
> libata: Unknown symbol pci_dma_mapping_error
> sata_sil: Unknown symbol ata_std_bios_param
> sata_sil: Unknown symbol ata_tf_load_mmio
> sata_sil: Unknown symbol ata_bmdma_start_mmio
> sata_sil: Unknown symbol ata_tf_read_mmio
> sata_sil: Unknown symbol ata_exec_command_mmio
> sata_sil: Unknown symbol sata_phy_reset
> sata_sil: Unknown symbol ata_check_status_mmio
> sata_sil: Unknown symbol ata_interrupt
> sata_sil: Unknown symbol ata_scsi_slave_config
> sata_sil: Unknown symbol ata_fill_sg
> sata_sil: Unknown symbol ata_std_ports
> sata_sil: Unknown symbol ata_scsi_error
> sata_sil: Unknown symbol ata_port_disable
> sata_sil: Unknown symbol ata_scsi_queuecmd
> sata_sil: Unknown symbol ata_eng_timeout
> sata_sil: Unknown symbol ata_port_stop
> sata_sil: Unknown symbol ata_pci_remove_one
> sata_sil: Unknown symbol ata_device_add
> sata_sil: Unknown symbol ata_port_start

You're system needs to load the "libata" kernel module, that provides 
these functions.

Looks like you're doing "insmod" when you should be doing "modprobe", or 
your mkinitrd is broken, or something like that.

	Jeff



