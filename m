Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVA2BPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVA2BPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 20:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbVA2BPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 20:15:54 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:7813 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262834AbVA2BPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 20:15:36 -0500
To: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
CC: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com,
       arjan@infradead.org
Subject: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
From: Martins Krikis <mkrikis@yahoo.com>
Date: 28 Jan 2005 20:15:04 -0500
Message-ID: <87651hdoiv.fsf@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.1.5 of the Intel Sofware RAID driver (iswraid) is now
available for the 2.4 series kernels at
http://prdownloads.sourceforge.net/iswraid/2.4.29-iswraid.patch.gz?download

It is an ataraid "subdriver" but uses the SCSI subsystem to find the
RAID member disks. It depends on the libata library, particularly on
either the ata_piix or the ahci driver, that enable the Serial ATA 
capabilities in ICH5/ICH6/ICH7 chipsets. More information is available
at the project's home page at http://iswraid.sourceforge.net/.

Driver documentation is included in Documentation/iswraid.txt,
which is part of the patch. The license is GPL.

The changes WRT version 0.1.4.3 are the following:
* Resource deallocation bug fixed for failed initializations.
* Read IO resubmission to mirror bug fixed.
* RAID1E (covers 4-disk RAID10) code added.
* More aggressive marking disks as bad in metadata.
* Claiming disks for RAID "feature" removed.
* Option defaults now customizable from the build configuration.
* iswraid_never_fail "feature" watered down into iswraid_resist_failing.
* iswraid_halt_degraded now prevents degraded volumes from being registered.
* Debug printouts more customizable.
* Some code cleanup and optimization.
* Documentation changes.

Please consider this driver for inclusion in the 2.4 kernel tree.

  Martins Krikis
  Storage Components Division
  Intel Massachusetts



P.S. I've CC-d directly to the potential reviewers suggested a few months ago
     by Marcelo. I'll appreciate any feedback you (and others) can provide.

