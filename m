Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbTADING>; Sat, 4 Jan 2003 03:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbTADING>; Sat, 4 Jan 2003 03:13:06 -0500
Received: from d40.sstar.com ([209.205.179.40]:34558 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id <S265960AbTADINF>;
	Sat, 4 Jan 2003 03:13:05 -0500
Message-ID: <3E169992.8080200@asjohnson.com>
Date: Sat, 04 Jan 2003 02:21:38 -0600
From: "Andrew S. Johnson" <andy@asjohnson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE-SCSI grabs too many drives
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have append="hdc=ide-scsi" in my lilo.conf file,
but when I modprobe ide-scsi, it grabs both the
CD-RW and the DVD-ROM:

SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: HP        Model: CD-Writer+ 9100   Rev: 1.0c
   Type:   CD-ROM                             ANSI SCSI revision: 02
   Vendor: RAITE     Model: RDR-108H          Rev: 1.7
   Type:   CD-ROM                             ANSI SCSI revision: 02

Shouldn't it just make only hdc a SCSI drive?

If I unload ide-scsi and modprobe ide-cd instead, I get this:

hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
hdd: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)

Of course, I can't burn CD's with this configuration.

I want the CD-RW as a SCSI drive, and the DVD-ROM as an IDE drive.

For some reason, mplayer only works when the DVD-ROM is an IDE
device.  If I try to use the SCSI equivalent, it hangs.

So, how do I get hdc as a SCSI drive, and hdd as an IDE drive?

Any and all help will be appreciated.

Andy Johnson

