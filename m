Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTFPFfP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 01:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTFPFfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 01:35:15 -0400
Received: from CM-lcon-177-66.cm.vtr.net ([200.83.177.66]:42368 "EHLO tonto")
	by vger.kernel.org with ESMTP id S263376AbTFPFfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 01:35:03 -0400
Message-ID: <32930.127.0.0.1.1055742534.squirrel@127.0.0.1>
In-Reply-To: <34134.127.0.0.1.1055734913.squirrel@127.0.0.1>
References: <34134.127.0.0.1.1055734913.squirrel@127.0.0.1>
Date: Mon, 16 Jun 2003 01:48:54 -0400 (CLT)
Subject: Re: 2.4.20, VIA VT8233, Maxtor 6Y080L0, drive not ready for command
From: "andrew cooke" <andrew@acooke.org>
To: linux-kernel@vger.kernel.org
Reply-To: andrew@acooke.org
X-Mailer: SquirrelMail (version 1.4.0 RC1)
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These problems appears to be purely due to my own stupidity - a
combination of incorrect BIOS settings and a missing driver.

Thanks to those who responded so quickly, and apologies to everyone,
Andrew

andrew cooke said:

> Hi,
>
> [Apologies in advance for posting here - I did google around and couldn't
> find a more appropriate forum, but please redirect me if this is not OK.
> Also, I'm not subscribed, so would appreciate CC, but will of course check
> the archives (didn't want to get swamped by mail just to be told to post
> elsewhere).]
>
> Using 2.4.20 (Debian system, but source from kernel.org) plus ext3 patches
> from http://www.zip.com.au/~akpm/linux/ext3/ I am trying to get a Maxtor
> DiamondMax Plus9 80Gb functioning.  AK77 Pro MB with VIA VT8233 SB (drive
> is ATA133, chipset might do ATA100).  Other disks are SCSI-3 and work
> fine.  Under load (copying /home from SCSI drive) the IDE drive gives
> errors like:
>
> Jun 15 22:31:08 tonto kernel: hdc: status timeout: status=0xd0 { Busy }
> Jun 15 22:31:08 tonto kernel: hdc: drive not ready for command
> Jun 15 22:31:08 tonto kernel: ide1: reset: success
> Jun 15 22:31:09 tonto kernel: hdc: write_intr error1: nr_sectors=10,
> stat=0x59
> Jun 15 22:31:09 tonto kernel: hdc: write_intr: status=0x59 { DriveReady
> SeekComplete DataRequest Error }
> Jun 15 22:31:09 tonto kernel: hdc: write_intr: error=0x01 {
> AddrMarkNotFound },
> LBAsect=123295591, sector=123295270
> (repeated ad infinitum with different values)
>
> tonto:/var/log# hdparm /dev/hdc1
>
> /dev/hdc1:
>  multcount    =  0 (off)
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  0 (off)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 158816/16/63, sectors = 160086465, start = 63
>
> The geometry values are correct, according to Maxtor's docs.  (IDE0 is
> occupied by CD+CDRW, hende hdc).
>
> Is this a kernel problem?  If not, where should I go for help?
>
> Feel free to ask for more data, tests, recompilation of kernel with
> different params, etc - happy to help.  Will include kernel .config as a
> bzipped attachment.
>
> Thanks,
> Andrew
>
> --
> http://www.acooke.org/andrew


-- 
http://www.acooke.org/andrew
