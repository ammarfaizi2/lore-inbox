Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269096AbUJKSEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269096AbUJKSEi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUJKSEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:04:38 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:4011 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S269096AbUJKSDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:03:33 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: CDROM support in ata_piix?
From: Doug McNaught <doug@mcnaught.org>
Date: Mon, 11 Oct 2004 14:03:30 -0400
Message-ID: <87k6txdte5.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an IBM server with a SATA controller listed as:

0000:00:1f.2 IDE interface: Intel Corp. 6300ESB SATA Storage Controller (rev 02)

Debian's 2.6.8 kernel with libata works fine, except that the CDROM
(which is on a PATA port) does not appear as a SCSI device.  It's also
not seen by the regular IDE driver, because ata_piix has already
grabbed the i/o resources--I get:

ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe

Is there any way to get ata_piix to register my CDROM, or
alternatively to have the regular IDE driver handle it? 

This seems to be a known problem (it's filed as a Debian bug)--is it
fixed in 2.6.9-rc4?  I had a look at the -rc4 patch but couldn't tell
from the diff whether there's anything CDROM-related in there...

Thanks,
Doug

