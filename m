Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135416AbRA0UDn>; Sat, 27 Jan 2001 15:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135417AbRA0UDd>; Sat, 27 Jan 2001 15:03:33 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:16140
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S135416AbRA0UDW>; Sat, 27 Jan 2001 15:03:22 -0500
Date: Sat, 27 Jan 2001 11:59:22 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: jacob@chaos2.org, linux-kernel@vger.kernel.org
Subject: Re: hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete
 Error }
In-Reply-To: <20010127141730.C27929@suse.de>
Message-ID: <Pine.LNX.4.10.10101271159000.25130-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001, Jens Axboe wrote:

> On Sat, Jan 27 2001, Andre Hedrick wrote:
> > > I've been getting this during the boot sequence for quite some time now.
> > > They don't seem to impact the functionality of the drive any though.  Just
> > > another extra-verbose kernel message I should ignore?  :)
> > > 
> > > (This is from the 2.4.1-pre10 btw.)
> > > 
> > > hdd: CD-ROM TW 120D, ATAPI CD/DVD-ROM drive
> > > hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> > > hdd: set_drive_speed_status: error=0x04
> > 
> > Means your device did not like that command and barfed.
> > status=0x51, error=0x04 == command aborted next....
> 
> My gut tells me that this is the 'get last written' command, and even
> with the quiet flag we get the IDE error status printed. Could you
> try and add
> 
> 	goto use_toc;
> 
> add the top of drivers/cdrom/cdrom.c:cdrom_get_last_written() and
> see if that makes the error disappear?

It is an ATA command not ATAPI.

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
