Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVHHRpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVHHRpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVHHRpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:45:11 -0400
Received: from dialin-159-125.tor.primus.ca ([216.254.159.125]:3800 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S932128AbVHHRpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:45:10 -0400
Date: Mon, 8 Aug 2005 13:45:02 -0400
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: ide-cd: cmd 0x28 timed out
Message-ID: <20050808174502.GA2615@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Samsung dvd-rom and Via chipset (Apollo Pro 133A):

    hdc: SAMSUNG DVD-ROM SD-608, ATAPI CD/DVD-ROM drive

    VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
	ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
	ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio

Computer boots okey, and 'hdparm' shows that DMA is enabled on 'hdc'
But, when I try to play DVD using 'xine', I get into infinite loop, with
error messages

    /var/log/syslog:
	hdc: irq timeout: status=0xd0 { Busy }
	ide: failed opcode was: unknown
	hdc: ATAPI reset complete
	end_request: I/O error, dev hdc, sector 299056
	Buffer I/O error on device hdc, logical block 37382
    
    /var/log/messages:
	ide-cd: cmd 0x28 timed out

which repeat every minute.

Has anyone encountered this before, and solved it?  A DVD drive without
DMA is pretty useless. :-(

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
ThinFlash: Linux thin-client on USB key (flash) drive
	   http://home.eol.ca/~parkw/thinflash.html
BashDiff: Super Bash shell
	  http://freshmeat.net/projects/bashdiff/
