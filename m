Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266548AbUHIMkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266548AbUHIMkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUHIMkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:40:42 -0400
Received: from host-ip82-243.crowley.pl ([62.111.243.82]:33545 "HELO
	software.com.pl") by vger.kernel.org with SMTP id S266548AbUHIMkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:40:11 -0400
From: Karol Kozimor <kkozimor@aurox.org>
Organization: Aurox Sp. z o.o.
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Mon, 9 Aug 2004 14:39:28 +0200
User-Agent: KMail/1.6.2
References: <200408091224.i79COp69009736@burner.fokus.fraunhofer.de>
In-Reply-To: <200408091224.i79COp69009736@burner.fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Message-Id: <200408091439.28411.kkozimor@aurox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 of August 2004 14:24, Joerg Schilling wrote:
> On Linux, it is impossible to run cdrecord without root privilleges.
> Make cdrecord suid root, it has been audited....

[kkozimor@athlon1 kkozimor]$ cdrecord dev=/dev/hdd -atip
Cdrecord-Clone 2.01a31-dvd (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg 
Schilling
Note: This version is an unofficial (modified) version with DVD support
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to 
<warly@mandrakesoft.com>.
Note: The author of cdrecord should not be bothered with problems in this 
version.
scsidev: '/dev/hdd'
devname: '/dev/hdd'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   :
Vendor_info    : 'LITE-ON '
Identifikation : 'COMBO LTC-48161H'
Revision       : 'KH0M'
Device seems to be: Generic mmc2 DVD-ROM.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE FORCESPEED
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
ATIP info from disk:
  Indicated writing power: 5
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type B, low Beta category (B-) (4)
  ATIP start of lead in:  -11607 (97:27/18)
  ATIP start of lead out: 359849 (79:59/74)
Disk type:    Short strategy type (Phthalocyanine or similar)
Manuf. index: 18
Manufacturer: Plasmon Data systems Ltd.
[kkozimor@athlon1 kkozimor]$ ls -l `which cdrecord`
-rwxr-xr-x  1 root root 320148 cze 14 18:16 /usr/bin/cdrecord

Go figure...

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
