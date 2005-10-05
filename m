Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVJEE00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVJEE00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 00:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVJEE00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 00:26:26 -0400
Received: from havoc.gtf.org ([69.61.125.42]:31676 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965073AbVJEE0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 00:26:25 -0400
Date: Wed, 5 Oct 2005 00:26:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: libata queue, status report updated
Message-ID: <20051005042623.GA7561@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Though I have been updating the libata-dev.git repository regularly, I
haven't been posting updates to the lists very often, aside from the
random 'applied' response from me.

So, here are the changes currently in the 'ALL' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

You can generate a patch from this using the following recipe:

	git clone $url libata-dev
	cd libata-dev
	git diff master..ALL > git-libata.patch

All these changes auto-propagate into Andrew Morton's -mm tree, each
time he generates a new one.  Many of these changes are in the
'upstream' branch, which means it is queued for pushing upstream as soon
as the 2.6.14-rc cycle ends.

Finally, the SATA status reports at
	http://linux.yyz.us/sata/
have been updated in the past several days, to reflect movement in
various drivers and features.



Alan Cox:
  ata: re-order speeds sensibly.
  libata: bitmask based pci init functions for one or two ports

Albert Lee:
  [libata] C/H/S support, for older devices
  libata: indent and whitespace change
  libata: rename host states
  libata: interrupt driven pio for libata-core
  libata: interrupt driven pio for LLD
  libata irq-pio: add comments and cleanup
  libata irq-pio: rename atapi_packet_task() and comments
  libata irq-pio: simplify if condition in ata_dataout_task()
  libata irq-pio: cleanup ata_qc_issue_prot()
  libata: move atapi_send_cdb() and ata_dataout_task()
  libata: minor whitespace, comment, debug message updates
  [libata scsi] tidy up SCSI lba and xfer len calculations
  [libata scsi] add CHS support to ata_scsi_start_stop_xlat()

Brett Russ:
  libata: Marvell SATA support (DMA mode) (resend: v0.22)

Erik Benada:
  [libata sata_promise] support PATA ports on SATA controllers

Jeff Garzik:
  [libata] add new driver ata_adma
  [libata adma] enable PCI MWI during controller initialization
  [libata] ATA passthru (arbitrary ATA command execution)
  [libata] ata_adma: update for recent ->host_stop() API changes
  libata: Update 'passthru' branch for latest libata
  [libata] update ata_adma license from OSL+GPL to GPL
  [libata sata_promise] merge upstream into 'promise-sata-pata' branch by hand
  libata: move EH docs to separate DocBook chapter
  [libata] improve device scan
  [libata] improve device scan even more
  libata: fix build error (missing ata_pio_error prototype)

Jeff Raubitschek:
  [libata passthru] fix leak on error

Tejun Heo:
  SATA: rewritten sil24 driver
  sil24: add FIXME comment above ata_device_add
  sil24: remove irq disable code on spurious interrupt
  sil24: add testing for PCI fault
  sil24: move error handling out of hot interrupt path
  sil24: remove PORT_TF
  sil24: replace pp->port w/ ap->ioaddr.cmd_addr
  sil24: fix PORT_CTRL_STAT constants
  sil24: add more comments for constants
  sil24: initialization fix
  libata EH document update
  libata: add ATA exceptions chapter to doc

