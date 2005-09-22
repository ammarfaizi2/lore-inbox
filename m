Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbVIVNZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVIVNZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVIVNZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:25:48 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:61880 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030313AbVIVNZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:25:47 -0400
Date: Thu, 22 Sep 2005 09:25:46 -0400
To: David R <david@industrialstrengthsolutions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA broken in mainline 2.6.13.2 _AND_ opensuse vendor 2.6.13-15
Message-ID: <20050922132546.GK28578@csclub.uwaterloo.ca>
References: <433216C2.4020707@industrialstrengthsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433216C2.4020707@industrialstrengthsolutions.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 10:28:18PM -0400, David R wrote:
> DMA is broken in 2.6.13.2 and opensuse 2.6.13-15, for  my  cdrom/dvd 
> burner.
> 
> My chipset is:
> 
> 00:0f.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> 
> I have also heard ICH5 has this problem as well.
> 
> I can tell you that hdparm -iI /dev/hdb reports the drive in udma4 mode.
> 
> This drive is a: LITE-ON DVDRW SOHW-1693S, FwRev=KS09 However I think 
> that maybe irrelevant.
> 
> On .13 I get this at the end of dmesg:
> 
> hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hdb: drive_cmd: error=0x04 { AbortedCommand }
> ide: failed opcode was: 0xec
> hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hdb: drive_cmd: error=0x04 { AbortedCommand }
> ide: failed opcode was: 0xec
> 
> On .12 I get this but not on .13:
> 
> VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
>    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:pio, hdb:DMA
>    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio

What is on hda?

If nothing, fix your system.  You should NOT have a slave without a
master on an ide bus.

Probably won't fix things, but sometimes it does fix things.

Len Sorensen
