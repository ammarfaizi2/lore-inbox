Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317620AbSFMOVO>; Thu, 13 Jun 2002 10:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317621AbSFMOVN>; Thu, 13 Jun 2002 10:21:13 -0400
Received: from web14403.mail.yahoo.com ([216.136.174.60]:36381 "HELO
	web14403.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317620AbSFMOVG>; Thu, 13 Jun 2002 10:21:06 -0400
Message-ID: <20020613142107.79644.qmail@web14403.mail.yahoo.com>
Date: Thu, 13 Jun 2002 07:21:07 -0700 (PDT)
From: manjuanth n <manju_tt@yahoo.com>
Subject: Re: need help
To: Michael Clark <michael@metaparadigm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D04BA0E.7000702@metaparadigm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Micheal,
  Thanks for the solution again, it  seems  i dont
have  any luck.  I  have patched the kernel with 
BLIST_LARGELUN  support I have tried all the options  
given by  u
still  success is  far away from me. I have made 
these  changes in the scsi_scan.c 
{"IBM", "AuSaV1S2", "*", BLIST_LARGELUN |
BLIST_FORCELUN | BLIST_SPARSELUN},
	{"HITACHI", "OPEN E*4", "*", BLIST_LARGELUN |
BLIST_FORCELUN |  BLIST_SPARSELUN},
        {"HITACHI", "OPEN E*18", "*", BLIST_LARGELUN |
BLIST_FORCELUN | BLIST_SPARSELUN},
        {"HITACHI", "OPEN E*8", "*", BLIST_LARGELUN |
BLIST_FORCELUN | BLIST_SPARSELUN},
        {"HITACHI", "OPEN E*36", "*", BLIST_LARGELUN |
BLIST_FORCELUN | BLIST_SPARSELUN},





 I tried  all the  possible  combination of
BLIST_SPARCE, BLIST_FORCE, etc.

  I would like to know whether the LINUX works on SAN
envirnment.  I  am feeling it has its own limitation
in SAN. 
If any one can help to solve my problem it will be a
great help. 

To  my strange  experiance   RedHat 6.2  with  kernel 
2.2-14 without  SMP  options  works fine, withot LUNO
and  without luns  biengin  sequence but  we require
multiple cpu option
if RedHat  6.2  works fine  i dont know why  it is 
not implemented in  RedHat 7.X.  I  have tried  allthe
possible  Redhat vesions
Including the latest  RedHat  7.3. To  my suprise  the
 RedHat does not boot at all if the qlogic  driver is
enabled at  boot.
and  have the same  problem of LUN0 and sequence 
LUNs. Is really Linux  operating sytem is  matured 
enough  to work as  high end 
server????
 
Pl  can  any body help??? 
 The details of  machine 

uname  -a  Linux m1 2.4.19-pre10 #12 SMP Thu Jun 13
05:48:37 IST 2002 i686 unknown

cat /proc/scsi/scsi
Attached devices: 
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi2 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI
revision: 02
Host: scsi2 Channel: 01 Id: 08 Lun: 00
  Vendor: IBM      Model: AuSaV1S2         Rev: 0   
  Type:   Processor                        ANSI SCSI
revision: 02
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: HITACHI  Model: OPEN-E*4         Rev: 0116
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi3 Channel: 00 Id: 00 Lun: 01
  Vendor: HITACHI  Model: OPEN-E*4         Rev: 0116
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi3 Channel: 00 Id: 00 Lun: 02
  Vendor: HITACHI  Model: OPEN-E*36        Rev: 0116
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi3 Channel: 00 Id: 00 Lun: 03
  Vendor: HITACHI  Model: OPEN-E*18        Rev: 0116
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi3 Channel: 00 Id: 00 Lun: 04
  Vendor: HITACHI  Model: OPEN-E*2         Rev: 0116
  Type:   Direct-Access                    ANSI SCSI
revision: 02


 
cat  /proc/partition
major minor  #blocks  name     rio rmerge rsect ruse
wio wmerge wsect wuse running use aveq

   8     0   35548160 sda 4426 7059 90710 33350 4064
4259 66776 78920 0 36970 112310
   8     1    5168614 sda1 4135 6674 86466 30360 2569
3334 47464 57210 0 30850 87600
   8     2   23554944 sda2 268 299 3978 2880 1491 922
19280 21680 0 14080 24560
   8     3    2096262 sda3 3 0 24 30 0 0 0 0 0 30 30
   8     4          1 sda4 0 0 0 0 0 0 0 0 0 0 0
   8     5    4720558 sda5 18 80 226 60 4 3 32 40 0 90
100
   8    16   56905920 sdb 1 3 8 0 0 0 0 0 0 0 0
   8    17   56902198 sdb1 0 0 0 0 0 0 0 0 0 0 0
   8    32   56905920 sdc 1 3 8 0 0 0 0 0 0 0 0
   8    33    2097136 sdc1 0 0 0 0 0 0 0 0 0 0 0
   8    48  512153280 sdd 1 3 8 0 0 0 0 0 0 0 0
   8    49  512152168 sdd1 0 0 0 0 0 0 0 0 0 0 0
   8    64  256076640 sde 1 3 8 0 0 0 0 0 0 0 0
   8    65   51207156 sde1 0 0 0 0 0 0 0 0 0 0 0
   8    80   28452960 sdf 1 3 8 0 0 0 0 0 0 0 0
   8    81   28452848 sdf1 0 0 0 0 0 0 0 0 0 0 0
   3     0     653856 hda 1 3 16 30 0 0 0 0 -1145
643450 13929193

--- Michael Clark <michael@metaparadigm.com> wrote:
> Did you try BLIST_SPARSELUN on the Hitachi
> devices?
> 
> Also, your devices are reporting as SCSI level 2 so
> no scanning will be done past lun 7 (This is only
> done for SCSI-3 devices). There is a patch
> floating around that adds BLIST_LARGELUN
> to make the scanning code treat these devices
> as SCSI-3 (255 luns)
> 
> ~mc
> 
> On 06/10/02 22:21, manjuanth n wrote:
> 
> >Dear  Michael,
> >
> >Thanks  for the solution, but  my  problem still 
> >remains  unresolved.  I  added the following lines 
> to
> > scsi_scan.c  and recompiled
> >  {"IBM", "AvSaV1S2", "*", BLIST_FORCELUN |
> >BLIST_SPARSELUN},
> >        {"HITACHI", "OPEN E*4", "*",
> BLIST_FORCELUN},
> >        {"HITACHI", "OPEN E*18", "*",
> BLIST_FORCELUN},
> >        {"HITACHI", "OPEN E*8", "*",
> BLIST_FORCELUN},
> >        {"HITACHI", "OPEN E*36", "*",
> BLIST_FORCELUN},
> >        {"HITACHI", "DF400", "*", BLIST_FORCELUN},
> >        {"HITACHI", "DF500", "*", BLIST_FORCELUN},
> >        {"HITACHI", "DF600", "*", BLIST_FORCELUN},
> >
> > the  out put of the scsi venders  are  as follows
> > cat  /proc/scsi/scsi
> >Attached devices:
> >Host: scsi2 Channel: 00 Id: 00 Lun: 00
> >  Vendor:  IBM     Model:  SERVERAID       Rev: 
> 1.0
> >  Type:   Direct-Access                    ANSI
> SCSI
> >revision: 01
> >Host: scsi2 Channel: 00 Id: 15 Lun: 00
> >  Vendor:  IBM     Model:  SERVERAID       Rev: 
> 1.0
> >  Type:   Processor                        ANSI
> SCSI
> >revision: 01
> >Host: scsi2 Channel: 01 Id: 08 Lun: 00
> >  Vendor: IBM      Model: AuSaV1S2         Rev: 0
> >  Type:   Processor                        ANSI
> SCSI
> >revision: 02
> >Host: scsi3 Channel: 00 Id: 00 Lun: 00
> >  Vendor: HITACHI  Model: OPEN-E*4         Rev:
> 0116
> >  Type:   Processor                        ANSI
> SCSI
> >revision: 02
> >
> >If u can  help me out where i am doing the  mistake
> 
> >it will be  of great help. 
> >plfind the enclosed scsi_scan.c  file. Is there any
> >method  or commands  to find out  BLIST_FORCELUN is
> >enabled?
> >
> > Thanks and  regards
> >Manjunath
> >
> >
> >--- Michael Clark <michael@metaparadigm.com> wrote:
> >  
> >
> >>2.4.18 needs a hint added to
> >>drivers/scsi/scsi_scan.c
> >>to allow it to scan targets with sparse luns.
> >>
> >>Look in /proc/scsi/scsi for the vendor and model
> and
> >>add them into the device_list array in scsi_scan.c
> >>
> >>...
> >>{"<VENDOR>", "<MODEL>", "*", BLIST_SPARSELUN},
> >>
> >>If you don't configure lun 0, you may have to use
> >>BLIST_FORCELUN which if my understanding is
> correct
> >>will force scanning of all luns.
> >>
> >>I hear there is some REPORT_LUNS code that will
> >>eliminate the need to do this, although don't know
> >>which kernel has it.
> >>
> >>~mc
> >>
> >>On 06/08/02 19:27, manjuanth n wrote:
> >>
> >>    
> >>
> >>>Dear sir,
> >>>we have SAN environment  with hitachi  storage
> box
> >>>and  brocade  switch. we are trying to  install
> >>>      
> >>>
> >>Linux 
> >>    
> >>
> >>>with  qlogic  HBA card.  we  are facing strange 
> >>>problems 
> >>>1. If  we  disable LUN 0  we will not be able to
> >>>      
> >>>
> >>see
> >>    
> >>
> >>>any LUNs on liunx  machine
> >>>2. If we  enable  LUN 0  we can  see all the 
> LUNS 
> >>>but  it  should be in sequence  i.e LUN0 ,1,2 , 3
> 
> >>>      
> >>>
> >>etc
> >>    
> >>
> >>>if we disable  LUN 3  we will not be able  to see
> >>>      
> >>>
> >>LUNS
> >>    
> >>
> >>>4 and  the  rest
> >>>Is the  above things  are limitation of linux.
> >>>Linux  machine is  running with  2.4.18 kernel
> >>>
> >>>Is there any solutions for  these problems? 
> >>>
> >>>Thanks and Regards
> >>>Manjuanth
> >>>
> >>>
>
>>>__________________________________________________
> >>>Do You Yahoo!?
> >>>Yahoo! - Official partner of 2002 FIFA World Cup
> >>>http://fifaworldcup.yahoo.com
> >>>-
> >>>To unsubscribe from this list: send the line
> >>>      
> >>>
> >>"unsubscribe linux-kernel" in
> >>    
> >>
> >>>the body of a message to
> majordomo@vger.kernel.org
> >>>More majordomo info at 
> >>>      
> >>>
> >>http://vger.kernel.org/majordomo-info.html
> >>    
> >>
> >>>Please read the FAQ at  http://www.tux.org/lkml/
> >>> 
> >>>
> >>>      
> >>>
> >>    
> >>
> >
> >
> >__________________________________________________
> >Do You Yahoo!?
> >Yahoo! - Official partner of 2002 FIFA World Cup
> >http://fifaworldcup.yahoo.com
> >
>
>------------------------------------------------------------------------
> >
> >/*
> > *  scsi_scan.c Copyright (C) 2000 Eric Youngdale
> > *
> > *  Bus scan logic.
> > *
> > *  This used to live in scsi.c, but that file was
> just a laundry basket
> > *  full of misc stuff.  This got separated out in
> order to make things
> > *  clearer.
> > */
> >
> >#define __NO_VERSION__
> >#include <linux/config.h>
> >#include <linux/module.h>
> >#include <linux/init.h>
> >
> >#include <linux/blk.h>
> >
> >#include "scsi.h"
> >#include "hosts.h"
> >#include "constants.h"
> 
=== message truncated ===


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
