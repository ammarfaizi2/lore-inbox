Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbTILIPU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 04:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbTILIPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 04:15:20 -0400
Received: from users.linvision.com ([62.58.92.114]:64221 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S261230AbTILIPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 04:15:15 -0400
Date: Fri, 12 Sep 2003 10:14:54 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eric Bickle <ebickle@healthspace.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem: IDE data corruption with VIA chipsets on2.4.20-19.8+others
Message-ID: <20030912101454.A17364@bitwizard.nl>
References: <001601c37891$660cc5d0$5d74ad8e@hyperwolf> <1063305812.3606.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063305812.3606.4.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 07:43:33PM +0100, Alan Cox wrote:
> On Iau, 2003-09-11 at 19:20, Eric Bickle wrote:
> > > > kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > > > kernel: hdc: dma_intr: error=0x40 { UncorrectableError },
> > LBAsect=150637065,
> > > > sector=150636992

> A test that rewrites such a sector will generally clear the error, its
> one of the problems of some diagnostic tools. A pure read test should
> fine the error again unless its something like overheat causing the
> problem. SMART data will tell you drive temperatures

Some drives don't have the sensor for that. :-(

Anyway, speaking about SMART, some "smartd" was interfering with
normal operation on one of our systems and we saw similar "nasty"
stuff on that system until I removed "smartd". 

Aug 10 06:54:25 falbala kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Aug 10 06:54:25 falbala kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
Aug 10 06:54:25 falbala kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Aug 10 06:54:25 falbala kernel: hdb: drive_cmd: error=0x04 { DriveStatusError }
Aug 10 07:24:25 falbala kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Aug 10 07:24:25 falbala kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
Aug 10 07:24:25 falbala kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Aug 10 07:24:25 falbala kernel: hdb: drive_cmd: error=0x04 { DriveStatusError }
Aug 10 08:24:25 falbala kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Aug 10 08:24:25 falbala kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
Aug 10 08:24:25 falbala kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Aug 10 08:24:25 falbala kernel: hdb: drive_cmd: error=0x04 { DriveStatusError }

Linux version 2.4.19-rc1 (root@zurix) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Mon Jul 8 15:37:19 CEST 2002


		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
