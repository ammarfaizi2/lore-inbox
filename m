Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVGCLbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVGCLbn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 07:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVGCLbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 07:31:43 -0400
Received: from [202.136.32.45] ([202.136.32.45]:36275 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261317AbVGCLbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 07:31:41 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: CyberOptic <mail@cyberoptic.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppa / kernel 2.6.12.2 / fsck results in kernel error
Date: Sun, 03 Jul 2005 21:31:24 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <1eifc1ll55jemm78e2deefqt6hu4j4t2ij@4ax.com>
References: <42C7B5F0.40003@cyberoptic.de>
In-Reply-To: <42C7B5F0.40003@cyberoptic.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jul 2005 11:54:56 +0200, CyberOptic <mail@cyberoptic.de> wrote:
>this error (see blow) occours, if I "fsck -c" (bad cluster test) a
>medium in my parallel IOmega ZIP-Drive 100MB.
Unable to reproduce, sorry...
>
>A complete dd from /dev/zero to the device works like a charm.
Only if you read zeroes back again? :)

I wrote zeroes, format ext2, e2fsck -c, write kernel tarball, 
diff -> okay, used ATAPI zip drive in another box for 'diff'
so no cache issue/confusion.  Used low quality media (Nomai) 
that reported errors prior to format / zero / format again.

dmesg?
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Found device at ID 6, Attempting to use PS/2
ppa: Communication established with ID 6 using PS/2
scsi0 : Iomega VPI0 (ppa) interface
  Vendor: IOMEGA    Model: ZIP 100           Rev: D.17
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 6, lun 0

Only complaint is 'eject' doesn't for parport nor ATAPI :(

--Grant.

