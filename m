Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUGNOpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUGNOpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUGNOnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:43:00 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:63391 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265510AbUGNOls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:41:48 -0400
From: Edward Macfarlane Smith <snowfire@blueyonder.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: missing cdrom in new kernel 2.4.26
Date: Wed, 14 Jul 2004 16:42:13 +0100
User-Agent: KMail/1.6.1
Cc: Hlaing Oo <hlaing_1999@yahoo.com>
References: <20040714121731.52870.qmail@web90005.mail.scd.yahoo.com>
In-Reply-To: <20040714121731.52870.qmail@web90005.mail.scd.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407141642.14047.snowfire@blueyonder.co.uk>
X-OriginalArrivalTime: 14 Jul 2004 14:42:05.0368 (UTC) FILETIME=[BB798380:01C469B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 July 2004 13:17, Hlaing Oo wrote:

> >>>>> my new kernel dmesg is below
>
> #cat /var/log/dmesg
> Linux version 2.4.26 (root@localhost.localdomain) (gcc
> version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #3 SMP

> BIOS strings suggest APM reports battery life in
> minutes and wrong byte order.
> Kernel command line: ro root=/dev/hda2 hdc=ide-scsi
> ide_setup: hdc=ide-scsi
---cut---
old
> EXT3-fs: mounted filesystem with ordered data mode.
> SCSI subsystem driver Revision: 1.00
> scsi0 : SCSI host adapter emulation for IDE ATAPI
> devices
>   Vendor: MATSHITA  Model: UJDA310           Rev: 1.34
>   Type:   CD-ROM                             ANSI SCSI
> revision: 02

In both old and new you are passing in hdc=ide-scsi on the boot line, telling 
the kernel to use ide-scsi  for hdc. (I'd guess that /dev/cdrom points 
to /dev/sr0). The bit below shows that it has correctly inserted the ide-scsi 
module in your old kernel and detected the cdrom. That is missing from the 
new one. Are you sure you built the ide-scsi module in your new kernel? Have 
you checked /var/log/messages or /var/log/warn to see if there were any 
errors about problems with the ide-scsi module?
Fairly certain I remember getting the same error one time when I forgot to 
build ide-scsi.
Regards,
Edward

