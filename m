Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTLPWih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 17:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTLPWih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 17:38:37 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5099 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263868AbTLPWig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 17:38:36 -0500
Date: Tue, 16 Dec 2003 23:38:33 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.24-pre1: Instant reboot
Message-ID: <20031216223833.GC12564@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FDF63A2.9090205@enterprise.bidmc.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDF63A2.9090205@enterprise.bidmc.harvard.edu>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Kristofer T. Karas wrote:

> Hi Marcelo, et al,
> 
> Just wanted to report an instantaneous reboot problem with 2.4.24-pre1.
> 
> I don't even see any printk's to the screen; as soon as LILO is finished 
> loading the new kernel, the screen blanks and the BIOS goes through its 
> boot sequence again.  Since I seem to be the only one reporting this to 
> LKML, I suspect I'll have to back out various patches to try to track 
> this down. :-P

I've seen this, too, with XFS=y and OOM_KILLER=n, but haven't yet gotten
around to "make clean" and try again with a fresh build (I had 2.4.23
code traces in the .o files). I also have device-manager 1.00.07
patched in (no rejects, no manual edits necessary). My version was
pulled from BK, I can look up the latest ChangeSet I pulled from the
official kernel if necessary. I'll now try a "make clean" build after
yet another BK pull.

> At work now, so I don't have a full .config handy, but:
> * Slackware 8.1 based; glibc 2.2.5; gcc 2.95.3
> * Soltek SL-75DRV2 (UP, Athlon XP 1700, VIA KT266A [VT8366A/VT8233])
> * Root = ext3 on IDE partition
> * DevFS, DevPTS, IDE-SCSI=cdrom0, USBStorage, USB EHCI, VFAT
> * RadeonFB, IPTables, Realtek-8139

SuSE Linux 8.2, gcc 3.3.1, Gigabyte 7ZX-R (VIA KT133 + Promise 20265R),
root ext3 on SCSI (sym53c8xx_2), no devfs, no usb storage, vfat, xfs.

However, I doubt the file systems matter, the machine apparently hasn't
probed my partitions when it reboots.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
