Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132024AbQL2TS7>; Fri, 29 Dec 2000 14:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132031AbQL2TSu>; Fri, 29 Dec 2000 14:18:50 -0500
Received: from gear.torque.net ([204.138.244.1]:23306 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S132024AbQL2TSh>;
	Fri, 29 Dec 2000 14:18:37 -0500
Message-ID: <3A4CDBBD.B613C101@torque.net>
Date: Fri, 29 Dec 2000 13:45:17 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test13-pre4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: georgek@netwrx1.com
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: SCSI Problems since upgrade from 2.2.16
In-Reply-To: <p3ap4ts0e58mr95csmeo8sgr0gc0p63n7t@4ax.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"George R. Kasica" wrote:
> 
> Hello:
> 
> I'm running an HP DAT 4mm Autochanger here and since going to 2.2.17
> and 2.2.18 I'm seeing failures when it attempts to unload the tape and
> load a new one while backing up using BRU PE...utilizing the mt or mtx
> commands as follows:
> 
> mt -f $DEV rewoffl 2>&1 >/dev/null
> 
> OR
> 
> /usr/local/bin/mtx -f /dev/sg1 eject 2>&1 >/dev/null
> 
> If I use the MTX command set to "manually" change the tapes all is
> well....any thoughts on the cause or a fix...I don't think the
> hardware is broken due to the fact it runs fine "manually" by doing
> the mtx -f /dev/sg1 next commnand to load the next tape
> 
> Pertinent info below:
> 
> Information about installed SCSI devices
> 
> Attached devices:
> Host: scsi0 Channel: 00 Id: 01 Lun: 00
>   Vendor: SEAGATE  Model: ST32550N         Rev: 0021
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 03 Lun: 00
>   Vendor: HP       Model: C1553A           Rev: NS01
>   Type:   Sequential-Access                ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 03 Lun: 01
>   Vendor: HP       Model: C1553A           Rev: NS01
>   Type:   Medium Changer                   ANSI SCSI revision: 02

While I am not familiar with mtx and the process you
are having problems with, 'man 1 mtx' contains the 
following:
       The first argument, given following -f, is the SCSI
       generic device corresponding to your media changer.

On the basis of the /proc/scsi/scsi output you have shown,
the mtx commands should read "mtx -f /dev/sg2 ..." 
(not /dev/sg1) as you have noted at the top.

Given those 2 sg devices are closely coupled (just
differing by the lun) mtx probably can sort this out.

Doug Gilbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
