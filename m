Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267477AbTASO63>; Sun, 19 Jan 2003 09:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbTASO63>; Sun, 19 Jan 2003 09:58:29 -0500
Received: from services.erkkila.org ([24.97.94.217]:6030 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id <S267477AbTASO6Z> convert rfc822-to-8bit;
	Sun, 19 Jan 2003 09:58:25 -0500
Message-ID: <3E2ABD9C.9040903@erkkila.org>
Date: Sun, 19 Jan 2003 15:00:44 +0000
From: "Paul E. Erkkila" <pee@erkkila.org>
Reply-To: pee@erkkila.org
Organization: ErkkilaDotOrg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregoire Favre <greg@ulima.unil.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: Status of ide-cdrom writing?
References: <20030119130049.GA15941@ulima.unil.ch>
In-Reply-To: <20030119130049.GA15941@ulima.unil.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can confirm it worked this morning with 2.5.58.

cdrecord --version
Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling

uname -a
Linux nipplehead 2.5.58 #77 Thu Jan 16 02:57:13 GMT 2003 i686 AMD 
Athlon(TM) XP2000+ AuthenticAMD GNU/Linux

I do know vcdxrip hasn't worked since 2.5.42 or so.

This is a 1/2 gentoo, 1/2 my fault box.

-pee


Gregoire Favre wrote:

>Hello,
>
>I sent this email to the cdwrite ml a while ago, and the conclusion was
>that it was a kernel bug... so I forward here ;-)
>
>I got the same result with 2.5.58 (I need to compil a 2.5.59...).
>
>Thank you very much ;-)
>
>----- Forwarded message from Gregoire Favre <greg@ulima.unil.ch> -----
>
>Date: Sun, 12 Jan 2003 22:58:50 +0100
>From: Gregoire Favre <greg@ulima.unil.ch>
>To: cdwrite@other.debian.org
>Subject: Status of ide writing?
>
>Hello,
>
>is it possible to burn without idescsi under 2.5.56?
>
>I got:
>
>Cdrecord-ProDVD-Clone 2.0 (i586-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
>Unlocked features: ProDVD Clone 
>Limited  features: speed 
>This copy of cdrecord is licensed for: private/research/educational_non-commercial_use
>TOC Type: 1 = CD-ROM
>scsidev: '/dev/hdc'
>devname: '/dev/hdc'
>scsibus: -2 target: -2 lun: -2
>Warning: Open by 'devname' is unintentional and not supported.
>Linux sg driver version: 3.5.27
>Using libscg version 'schily-0.7'
>Driveropts: 'burnfree'
>atapi: 1
>Device type    : Removable CD-ROM
>Version        : 2
>Response Format: 2
>Capabilities   : 
>Vendor_info    : 'SONY    '
>Identifikation : 'DVD RW DRU-500A '
>Revision       : '1.0f'
>Device seems to be: Generic mmc2 DVD-R/DVD-RW.
>Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
>Driver flags   : DVD SWABAUDIO BURNFREE 
>Supported modes: TAO PACKET SAO SAO/R96R RAW/R96R
>Drive buf size : 8126464 = 7936 KB
>FIFO size      : 67108864 = 65536 KB
>Track 01: data  3502 MB        
>Total size:     3502 MB = 1793056 sectors
>Current Secsize: 2048
>Blocks total: 2298496 Blocks current: 2298496 Blocks remaining: 505440
>Starting to write CD/DVD at speed 1 in real SAO mode for single session.
>Last chance to quit, starting real write in 9 seconds.  0.28% done, estimate finish Sun Jan 12 22:32:14 2003
>  0.56% done, estimate finish Sun Jan 12 22:29:15 2003
>  0.84% done, estimate finish Sun Jan 12 22:28:15 2003
>  1.12% done, estimate finish Sun Jan 12 22:27:45 2003
>   8 seconds.  1.39% done, estimate finish Sun Jan 12 22:28:39 2003
>  1.67% done, estimate finish Sun Jan 12 22:28:15 2003
>   0 seconds. Operation starts.
>Waiting for reader process to fill input buffer ... input buffer ready.
>BURN-Free is ON.
>Starting new track at sector: 0
>Track 01:    4 of 3502 MB written (fifo  99%)  13.1x.cdrecord-prodvd: Input/output error. write_g1: scsi sendcmd: no error
>CDB:  2A 00 00 00 08 B8 00 00 1F 00
>status: 0x1 (GOOD STATUS)
>resid: 63488
>cmd finished after 0.011s timeout 100s
>
>write track data: error after 4571136 bytes
>Sense Bytes: 70 00 00 00 00 00 00 12 00 00 00 00 00 00 00 00 00 00
>Writing  time:    5.315s
>Average write speed 501.9x.
>Fixating...
>Fixating time:   84.976s
>cdrecord-prodvd: fifo had 1095 puts and 73 gets.
>cdrecord-prodvd: fifo was 0 times empty and 7 times full, min fill was 99%.
>Exit 254
>
>Should I compil again with ide-scsi?
>
>Thank you very much,
>
>	Grégoire
>________________________________________________________________
>http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

