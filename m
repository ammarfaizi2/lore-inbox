Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbTASRGP>; Sun, 19 Jan 2003 12:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267673AbTASRGP>; Sun, 19 Jan 2003 12:06:15 -0500
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:7685 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S267672AbTASRGN>;
	Sun, 19 Jan 2003 12:06:13 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
Message-Id: <200301191810.3533@gandalf>
To: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: Status of ide-cdrom writing?
Date: Sun, 19 Jan 2003 18:15:10 +0100
X-Mailer: KMail [version 1.3.2]
References: <20030119130049.GA15941@ulima.unil.ch> <3E2ABD9C.9040903@erkkila.org> <20030119152458.GA28354@ulima.unil.ch>
In-Reply-To: <20030119152458.GA28354@ulima.unil.ch>
Cc: "Paul E. Erkkila" <pee@erkkila.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 January 2003 16:24, Gregoire Favre wrote:
> On Sun, Jan 19, 2003 at 03:00:44PM +0000, Paul E. Erkkila wrote:
> 
> > I can confirm it worked this morning with 2.5.58.
> > 
> > cdrecord --version
> > Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
> > 
> > uname -a
> > Linux nipplehead 2.5.58 #77 Thu Jan 16 02:57:13 GMT 2003 i686 AMD 
> > Athlon(TM) XP2000+ AuthenticAMD GNU/Linux
> > 
> > I do know vcdxrip hasn't worked since 2.5.42 or so.
> > 
> > This is a 1/2 gentoo, 1/2 my fault box.
> 
> Well, lots of people have CD-writer working, as you don't tell which
> unit you have, I don't know wheter it's a CD or a DVD writer one???
> 
> And are you really not using ide-scsi?
> 
> Is there anybody which has success with DVD-writer under 2.5.59 without
> ide-scsi?

yep:

Calling: /usr/lib/xcdroast-0.98/bin/xcdrwrap CDRECORD dev= "/dev/hdc" 
fs=4096k -v driveropts=burnfree  speed=16 -eject -pad tsize=14928s -

scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Cdrecord 1.11a40 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
TOC Type: 1 = CD-ROM
Using libscg version 'schily-0.7'
Driveropts: 'burnfree'
atapi: 1
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   :
Vendor_info    : 'HL-DT-ST'
Identifikation : 'CD-RW GCE-8240B '
Revision       : '1.06'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
Drive buf size : 6037504 = 5896 KB
FIFO size      : 4194304 = 4096 KB
Track 01: data    29 MB         padsize:   30 KB
Total size:       33 MB (03:19.26) = 14945 sectors
Lout start:       33 MB (03:21/20) = 14945 sectors
Current Secsize: 2048
ATIP info from disk:
Indicated writing power: 2
Reference speed: 6
Is not unrestricted
Is erasable
Disk sub type: High speed Rewritable (CAV) media (1)
ATIP start of lead in:  -11077 (97:34/23)
ATIP start of lead out: 336075 (74:43/00)
1T speed low:  4 1T speed high: 10
power mult factor: 2 6
recommended erase/write power: 5
A1 values: 24 2C DC
A2 values: 00 00 00
Disk type:    Phase change
Manuf. index: 11
Manufacturer: Mitsubishi Chemical Corporation
Blocks total: 336075 Blocks current: 336075 Blocks remaining: 321130
Starting to write CD/DVD at speed 10 in real TAO mode for single session.
                0 seconds. Operation starts.
Waiting for reader process to fill input buffer ...
input buffer ready.
BURN-Free is ON.
Performing OPC...
Starting new track at sector: 0

Track 01: writing  30 KB of pad data.
Track 01: Total bytes read/written: 30572544/30603264 (14943 sectors).
Writing  time:   27.663s
Average write speed   7.2x.
Min drive buffer fill was 99%
Fixating...
Fixating time:   25.951s

to check that it really worked:

rudmer:~ # mount /mnt/cdrom/
rudmer:~ # ls /mnt/cdrom/
test_file_for_burning
rudmer:~ # cmp test_file_for_burning /mnt/cdrom/test_file_for_burning
rudmer:~ # 

so it works for me(TM)...

	Rudmer
