Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSEONDk>; Wed, 15 May 2002 09:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSEONDj>; Wed, 15 May 2002 09:03:39 -0400
Received: from mail.spylog.com ([194.67.35.220]:63378 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S311752AbSEONDi>;
	Wed, 15 May 2002 09:03:38 -0400
Date: Wed, 15 May 2002 17:03:28 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Cc: Andrea Arcangeli <andrea@suse.de>, gibbs@FreeBSD.org
Subject: Adaptec Aic7xxx driver & 2.4.19pre8aa2
Message-ID: <20020515130328.GA19698@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrea Arcangeli <andrea@suse.de>, gibbs@FreeBSD.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Hardware motherboard: Intel "Lancewood" L440GX, SCSI integrated, last BIOS/BMC

1. 2.4.19pre1aa1 :  : 1CPU/HIGHMEM/3.5Gb

...
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue e228f018, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IBM       Model: DDYS-T18350M      Rev: S93E
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue e228f218, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: IBM       Model: DDYS-T18350M      Rev: S93E
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue e228f818, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
scsi0:A:1:0: Tagged Queuing enabled.  Depth 64
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
...

load and work perfect


2. kernel 2.4.19pre8aa2 : 1CPU/HIGHMEM/3.5Gb

SCSI subsystem driver Revision: 1.00
PCI: Assigned IRQ 11 for device 00:0c.0
PCI: Sharing IRQ 11 with 00:0c.1
PCI: Found IRQ 11 for device 00:0c.1
PCI: Sharing IRQ 11 with 00:0c.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue e1e5f218, I/O limit 4095Mb (mask 0xffffffff)
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x9
ACCUM = 0x0, SINDEX = 0x3, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0xa
...
...
Pending list: 
Kernel Free SCB list: 3 1 0 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
scsi0:0:4:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:4:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x45
ACCUM = 0x2, SINDEX = 0x48, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0x0
STACK == 0x175, 0xe5, 0xe5, 0x3
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 3
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Sequencer SCB Info: 0(c 0x0, s 0x47, l 0, t 0xff) 1(c 0x0, s 0x17, l 0, t 0xff) 2(c 0x0, s 0x17, l 0, t 0xff) 3(c 0x0, s 0x17, l 0, t 0xff) 4(c
 0x0, s 0x0, l 0, t 0xff) 5(c 0x0, s 0x17, l 0, t 0xff) 6(c 0x0, s 0x17, l 0, t 0xff) 7(c 0x0, s 0x17, l 0, t 0xff) 8(c 0x0, s 0x7, l 0, t 0xff
) 9(c 0x0, s 0x17, l 0, t 0xff) 10(c 0x0, s 0x17, l 0, t 0xff) 11(c 0x0, s 0x7, l 0, t 0xff) 12(c 0x0, s 0x17, l 0, t 0xff) 13(c 0x0, s 0x7, l 
0, t 0xff) 14(c 0x0, s 0x7, l 0, t 0xff) 15(c 0x0, s 0x17, l 0, t 0xff) 16(c 0x0, s 0x7, l 0, t 0xff) 17(c 0x0, s 0x17, l 0, t 0xff) 18(c 0x0, 
s 0x17, l 0, t 0xff) 19(c 0x0, s 0x7, l 0, t 0xff) 20(c 0x0, s 0x7, l 0, t 0xff) 21(c 0x0, s 0x17, l 0, t 0xff) 22(c 0x0, s 0x17, l 0, t 0xff) 
23(c 0x0, s 0x17, l 0, t 0xff) 24(c 0x0, s 0x17, l 0, t 0xff) 25(c 0x0, s 0x17, l 0, t 0xff) 26(c 0x0, s 0x17, l 0, t 0xff) 27(c 0x0, s 0x17, l
 0, t 0xff) 28(c 0x0, s 0x17, l 0, t 0xff) 29(c 0x0, s 0x17, l 0, t 0xff) 30(c 0x0, s 0x17, l 0, t 0xff) 31(c 0x0, s 0x7, l 0, t 0xff) 
Pending list: 
Kernel Free SCB list: 2 1 0 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
scsi0:0:4:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:4:0: Attempting to queue a TARGET RESET message
scsi0:0:4:0: Is not an active device
aic7xxx_dev_reset returns 0x2002
...

and not load.

3. My .config

...
#                                                                                                                      
# SCSI support                                                                                                         
#                                                                                                                      
CONFIG_SCSI=y                                                                                                          
CONFIG_BLK_DEV_SD=y                                                                                                    
CONFIG_SD_EXTRA_DEVS=40                                                                                                
# CONFIG_CHR_DEV_ST is not set                                                                                         
# CONFIG_CHR_DEV_OSST is not set                                                                                       
# CONFIG_BLK_DEV_SR is not set                                                                                         
# CONFIG_CHR_DEV_SG is not set                                                                                         
CONFIG_SCSI_DEBUG_QUEUES=y                                                                                             
CONFIG_SCSI_MULTI_LUN=y                                                                                                
CONFIG_SCSI_CONSTANTS=y                                                                                                
# CONFIG_SCSI_LOGGING is not set                                                                                       
                                                                                                                       
#                                                                                                                      
# SCSI low-level drivers                                                                                               
#                                                                                                                      
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set                                                                               
# CONFIG_SCSI_7000FASST is not set                                                                                     
# CONFIG_SCSI_ACARD is not set                                                                                         
# CONFIG_SCSI_AHA152X is not set                                                                                       
# CONFIG_SCSI_AHA1542 is not set                                                                                       
# CONFIG_SCSI_AHA1740 is not set                                                                                       
# CONFIG_SCSI_AACRAID is not set                                                                                       
CONFIG_SCSI_AIC7XXX=y                                                                                                  
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253                                                                                     
CONFIG_AIC7XXX_RESET_DELAY_MS=15000                                                                                    
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set                                                                              
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
...


What is it? Can your help me?


-- 
bye.
Andrey Nekrasov, SpyLOG.
