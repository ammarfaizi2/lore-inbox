Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUBCT4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266091AbUBCT4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:56:53 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:57102 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S266049AbUBCT4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 14:56:49 -0500
Message-ID: <401FFCFF.6020309@murder.cz>
Date: Tue, 03 Feb 2004 20:56:47 +0100
From: "Fox!MURDER" <fox@murder.cz>
User-Agent: Mozilla Thunderbird 0.5a (20031223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Martin_Povoln=FD?= <xpovolny@aurora.fi.muni.cz>
CC: Derek Foreman <manmower@signalmarketing.com>,
       John Bradford <john@grabjohn.com>, M?ns Rullg?rd <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos> <401FB78A.5010902@zvala.cz> <Pine.LNX.4.53.0402031018170.31411@chaos> <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk> <yw1xsmhsf882.fsf@kth.se> <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402031251000.495@uberdeity> <20040203195116.GA2961@aurora.fi.muni.cz>
In-Reply-To: <20040203195116.GA2961@aurora.fi.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you mount it even after issuing cdrecord -toc?

Tomas Zvala


Martin Povolný wrote:

>Dne: Tue, Feb 03, 2004 at 01:09:45PM -0600, Derek Foreman napsal:
>  
>
>>Just making cdrecord -eject at the end of the process will probably
>>workaround what is almost certainly a hardware bug.  or just eject the
>>disc by hand before attempting to re-use it.
>>    
>>
>
>yes, -eject helps, as well as ejecting manually or ejecting using 'eject'
>
>  
>
>>I had an old writer that did much the same thing.  After burning a disc,
>>it would still see it as blank until you ejected and reloaded.
>>
>>to Martin:
>>Does cdrecord -toc still show a valid toc after you blank the disc?
>>(definately buggy hardware)
>>    
>>
>
>no, it does not:
>
>$ cdrecord -dev=/dev/cdrom -toc
>Cdrecord-Clone 2.01a19 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg Schilling
>scsidev: '/dev/cdrom'
>devname: '/dev/cdrom'
>scsibus: -2 target: -2 lun: -2
>Warning: Open by 'devname' is unintentional and not supported.
>Linux sg driver version: 3.5.27
>Using libscg version 'schily-0.7'
>Device type    : Removable CD-ROM
>Version        : 0
>Response Format: 1
>Vendor_info    : 'HL-DT-ST'
>Identifikation : 'RW/DVD GCC-4480B'
>Revision       : '1.00'
>Device seems to be: Generic mmc2 DVD-ROM.
>Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
>Driver flags   : MMC-2 SWABAUDIO BURNFREE
>Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
>cdrecord.mmap: Success. read toc: scsi sendcmd: no error
>CDB:  43 00 00 00 00 00 00 00 04 00
>status: 0x2 (CHECK CONDITION)
>Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 00
>Sense Key: 0x5 Illegal Request, Segment 0
>Sense Code: 0x24 Qual 0x00 (invalid field in cdb) Fru 0x0
>Sense flags: Blk 0 (not valid)
>resid: 4
>cmd finished after 0.000s timeout 40s
>cdrecord.mmap: Cannot read TOC header
>cdrecord.mmap: Cannot read TOC/PMA
>pie:martin:~
>
>but I can still mount it, and see the erased data:
>
>pie:martin:~
>$ mount /cdrom/
>pie:martin:~
>$ ls /cdrom/
>Beskydy2003-2004
>  
>  
>
>>And does ejecting and reloading the disc make things work as expected?
>>    
>>
>
>it does
>
>  
>
