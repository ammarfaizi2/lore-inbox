Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbULER6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbULER6o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbULER6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:58:44 -0500
Received: from mail.aei.ca ([206.123.6.14]:8907 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261345AbULER6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:58:36 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Time sliced CFQ #2
Date: Sun, 5 Dec 2004 12:58:28 -0500
User-Agent: KMail/1.7.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20041204104921.GC10449@suse.de> <200412050921.20468.edt@aei.ca> <20041205151840.GE6430@suse.de>
In-Reply-To: <20041205151840.GE6430@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412051258.28914.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 December 2004 10:18, Jens Axboe wrote:
> On Sun, Dec 05 2004, Ed Tomlinson wrote:
> > Jens,
> > 
> > Booting 10-rc3 with this patch applied hangs when I su from root
> > to my working user.  Same kernel without elevator=cfq works.   By
> > hangs I mean that the su does not complete nor do logins to other
> > ids work.  The sysrq keys are active.  
> > 
> > Please let me know what other info will help.
> 
> What type of storage is involved, that's the main question?

IDE.  Just in case this is from the 10-rc3 boot with the default scheduler.  

Dec  5 09:25:17 bert kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Dec  5 09:25:17 bert kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec  5 09:25:17 bert kernel: PIIX4: IDE controller at PCI slot 0000:00:14.1
Dec  5 09:25:17 bert kernel: PIIX4: chipset revision 1
Dec  5 09:25:17 bert kernel: PIIX4: not 100%% native mode: will probe irqs later
Dec  5 09:25:17 bert kernel:     ide0: BM-DMA at 0x10e0-0x10e7, BIOS settings: hda:DMA, hdb:pio
Dec  5 09:25:17 bert kernel:     ide1: BM-DMA at 0x10e8-0x10ef, BIOS settings: hdc:DMA, hdd:DMA
Dec  5 09:25:17 bert kernel: hda: Maxtor 6Y080L0, ATA DISK drive
Dec  5 09:25:17 bert kernel: elevator: using anticipatory as default io scheduler
Dec  5 09:25:17 bert kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec  5 09:25:17 bert kernel: hdc: HL-DT-ST RW/DVD GCC-4480B, ATAPI CD/DVD-ROM drive
Dec  5 09:25:17 bert kernel: hdd: HP COLORADO 20GB, ATAPI TAPE drive
Dec  5 09:25:17 bert kernel: ide1 at 0x170-0x177,0x376 on irq 15

Using udma2.

Ed
