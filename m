Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbQL2Prj>; Fri, 29 Dec 2000 10:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQL2Pr3>; Fri, 29 Dec 2000 10:47:29 -0500
Received: from ip-205-254-202-114.netwrx1.com ([205.254.202.114]:16910 "EHLO
	eagle.netwrx1.com") by vger.kernel.org with ESMTP
	id <S129228AbQL2PrK>; Fri, 29 Dec 2000 10:47:10 -0500
From: "George R. Kasica" <georgek@netwrx1.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: SCSI Problems since upgrade from 2.2.16
Date: Fri, 29 Dec 2000 09:16:38 -0600
Organization: Netwrx Consulting Inc.
Reply-To: georgek@netwrx1.com
Message-ID: <p3ap4ts0e58mr95csmeo8sgr0gc0p63n7t@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I'm running an HP DAT 4mm Autochanger here and since going to 2.2.17
and 2.2.18 I'm seeing failures when it attempts to unload the tape and
load a new one while backing up using BRU PE...utilizing the mt or mtx
commands as follows:

mt -f $DEV rewoffl 2>&1 >/dev/null

OR 

/usr/local/bin/mtx -f /dev/sg1 eject 2>&1 >/dev/null


If I use the MTX command set to "manually" change the tapes all is
well....any thoughts on the cause or a fix...I don't think the
hardware is broken due to the fact it runs fine "manually" by doing
the mtx -f /dev/sg1 next commnand to load the next tape

Pertinent info below:

Information about installed SCSI devices 

Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST32550N         Rev: 0021
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: HP       Model: C1553A           Rev: NS01
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 01
  Vendor: HP       Model: C1553A           Rev: NS01
  Type:   Medium Changer                   ANSI SCSI revision: 02

Bus  0, device   9, function  0:
    SCSI storage controller: Adaptec AIC-7850 (rev 1).
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master
Capable.  Latency=32.  Min Gnt=4.Max Lat=4.
      I/O at 0xd000 [0xd001].
      Non-prefetchable 32 bit memory at 0xdf000000 [0xdf000000].
  
SCSI support 

CONFIG_SCSI = 1
CONFIG_BLK_DEV_SD = 1
CONFIG_CHR_DEV_ST = 1
CONFIG_BLK_DEV_SR = 1
CONFIG_CHR_DEV_SG = 1
CONFIG_SCSI_MULTI_LUN = 1
CONFIG_SCSI_CONSTANTS = 1
CONFIG_SCSI_LOGGING = 1


SCSI low-level drivers 

CONFIG_SCSI_AIC7XXX = 1
CONFIG_AIC7XXX_CMDS_PER_DEVICE = (8)
CONFIG_AIC7XXX_RESET_DELAY = (5)


> Len: 20480
> 
> Dec 23 01:24:37 eagle kernel: [valid=0] Info fld=0x0, EOM Current
> st09:00: sense key None
> Dec 23 01:24:37 eagle kernel: Additional sense indicates
> End-of-partition/medium detected
> Dec 23 01:24:37 eagle kernel: st0: Async write error (write) 7fffffff.
> Dec 23 01:24:40 eagle kernel: st0: File length 641863680 bytes.
> Dec 23 01:24:40 eagle kernel: st0: Async write waits 30037, finished
> 1304.
> Dec 23 01:24:42 eagle kernel: st0: Error: 28000002, cmd: 10 0 0 0 1 0
> Len: 0
> Dec 23 01:24:42 eagle kernel: [valid=0] Info fld=0x0, FMK EOM Current
> st09:00: sense key None
> Dec 23 01:24:42 eagle kernel: Additional sense indicates
> End-of-partition/medium detected
> Dec 23 01:24:42 eagle kernel: st0: Buffer flushed, 1 EOF(s) written

===[George R. Kasica]===        +1 262 513 8503
President                       +1 206 374 6482 FAX 
Netwrx Consulting Inc.          Waukesha, WI USA 
http://www.netwrx1.com
georgek@netwrx1.com
ICQ #12862186
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
