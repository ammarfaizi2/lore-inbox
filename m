Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbTIMRFo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbTIMRFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:05:44 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:7579 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261458AbTIMRFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:05:38 -0400
Subject: Re: Problem: IDE data corruption with VIA chipsets
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Resident Boxholder <resid@boxho.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F62A18A.4090901@boxho.com>
References: <001601c37891$660cc5d0$5d74ad8e@hyperwolf>
	 <1063305812.3606.4.camel@dhcp23.swansea.linux.org.uk>
	 <20030912101454.A17364@bitwizard.nl>
	 <1063363467.5330.5.camel@dhcp23.swansea.linux.org.uk>
	 <3F62A18A.4090901@boxho.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063472654.8519.2.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sat, 13 Sep 2003 18:04:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 05:48, Resident Boxholder wrote:
> Sep 12 06:27:22 heinous logger: rundig htdig start incremental
> # errors are on md3 which is /var, and htdig was indexing
> # /var/www/www.some.com's--hdc: ST340016A, ATA DISK drive
> Sep 12 06:31:33 heinous kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Sep 12 06:31:33 heinous kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=67028386, sector=67028382

Again the drive is reporing that it failed.

> hdc: dma_int: error=0x40 {UnrecoverableError}, LBAsect=57970918, sector=57970918
> end_request: I/O error, dev hdc, sector 57970918
> Buffer I/O error on device md3, logical block 6101
> lost page write due to I/O error on md3
> journal-601, buffer write failed

Finally reiserfs got into a state where it couldnt recover so it pulled
things down rather than cause further damage. I'm not aware of paticular
problems with modern seagate drives.


