Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSKBRlo>; Sat, 2 Nov 2002 12:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbSKBRlo>; Sat, 2 Nov 2002 12:41:44 -0500
Received: from [212.104.37.2] ([212.104.37.2]:11278 "EHLO
	actnetweb.activenetwork.it") by vger.kernel.org with ESMTP
	id <S261317AbSKBRll>; Sat, 2 Nov 2002 12:41:41 -0500
Date: Sat, 2 Nov 2002 18:47:27 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.45] CDRW not working
Message-ID: <20021102174727.GA294@dreamland.darkstar.net>
Reply-To: kronos@kronoz.cjb.net
References: <20021102152143.GA515@dreamland.darkstar.net> <20021102152725.GD1922@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102152725.GD1922@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Nov 02, 2002 at 04:27:25PM +0100, Jens Axboe ha scritto: 
> > I can't even mount a cd using my CDRW drive (CD-ROM drive is ok).
> 
> Does 2.5.42 work?

I can reproduce it using hdparm -i /dev/hdd:

hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdd: drive_cmd: error=0x04Aborted Command
hdd: irq timeout: status=0xd0 { Busy }
hdd: irq timeout: error=0xd0LastFailedSense 0x0d
hdd: status timeout: status=0xd0 { Busy }
hdd: status timeout: error=0xd0LastFailedSense 0x0d
hdd: DMA disabled
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdd: request sense failure: error=0x50LastFailedSense 0x05

>From now on I can't use the drive. The same happens on 2.5.45. 

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
La differenza fra l'intelligenza e la stupidita`?
All'intelligenza c'e` un limite.
