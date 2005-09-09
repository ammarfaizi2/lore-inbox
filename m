Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbVIITbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbVIITbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbVIITbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:31:08 -0400
Received: from magic.adaptec.com ([216.52.22.17]:36036 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030324AbVIITbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:31:05 -0400
Message-ID: <4321E2F3.7030401@adaptec.com>
Date: Fri, 09 Sep 2005 15:30:59 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [ANNOUNCE 2/2] Serial Attached SCSI (SAS) support for the Linux kernel
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:31:04.0212 (UTC) FILETIME=[048DA540:01C5B575]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the User Space Expander configuration utility
===================================================

The file "expander_conf.c" is a user space program
which uses the "smp_portal" SMP portal to communicate
with expanders in the domain.

It gives you complete control of the expander you're
talking to, so please be careful if you're changing
route tables, phy settings, etc.

The "expander_conf.c" file is located here:
drivers/scsi/sas-class/expander_conf.c

How it works can be found in
drivers/scsi/sas-class/README, and of course in the
source code.

Here we show complete information about the three
expanders we saw in the previous email.

Dumping configuration info for Expander A
-----------------------------------------

A) As you can see phys 11, 10, 9 and 8 of this expander
are connected to phys 4, 5, 7, and 6 of the Host Adapter,
thus forming a wide port.

This is also the subtractive boundary of this
edge expander device set and of this expander.

B) As you can see phys 7 and 6 of this expander are
connected to phys 8 and 9 of expander B, thus forming
a wide port.

They use table routing attributes.

C) The routing table is also printed for phys 7 and 6.
It is of course identical.

D) End devices attached are clearly identifiable.

#expander_conf /sys/devices/pci0000\:01/0000\:01\:04.0/host11/sas/ha/ports/1/domain/50001c1716010600/smp_portal 
                  Vendor:             VITESSE 
                 Product:     VSC7160 Eval Brd
                Revision:                    4
               Component:             VITESSE 
            Component ID:                29024
      Component revision:                    4
   Expander Change Count:                   12
  Expander Route Indexes:                  160
          Number of phys:                   13
             Configuring:                   No
Configurable route table:                  Yes
Enclosure Logical Identifier: 00000000000000000000

Phy00:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           3221225471
          RD error count:           4294958971
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy01:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           3706272315
          RD error count:           2079374150
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy02:D    attached: 50001c1716010603:00    chg count:05
 Attached device:     SATA device    Link rate:   G1 (1,5 Gb/s)
 Tproto:             STP    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           4216795329
          RD error count:           4277909111
      DW sync loss count:                    0
     Reset problem count:                    0

Phy03:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:            828522753
          RD error count:             27724688
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy04:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy05:D    attached: 5000c50000513329:01    chg count:01
 Attached device:      end device    Link rate:     G2 (3 GB/s)
 Tproto:             SSP    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           4292849663
          RD error count:           4261371839
      DW sync loss count:                    0
     Reset problem count:                    0

Phy06:T    attached: 50001c1071609c00:09    chg count:01
 Attached device:   edge expander    Link rate:     G2 (3 GB/s)
 Tproto:             SMP    Iproto:             SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           3585802240
          RD error count:           3870195680
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  00  enabled 5000c50000102a65
  01  enabled 50001c1071609c02
  02  enabled 5005076a000001e0
  03  enabled 5000c50000513385
  04  enabled 5c50000000409c11
  05  enabled 5005076a000001ed

Phy07:T    attached: 50001c1071609c00:08    chg count:01
 Attached device:   edge expander    Link rate:     G2 (3 GB/s)
 Tproto:             SMP    Iproto:             SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           3229920258
          RD error count:           1111358524
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  00  enabled 5000c50000102a65
  01  enabled 50001c1071609c02
  02  enabled 5005076a000001e0
  03  enabled 5000c50000513385
  04  enabled 5c50000000409c11
  05  enabled 5005076a000001ed

Phy08:S    attached: 50000d1000281260:06    chg count:01
 Attached device:      end device    Link rate:     G2 (3 GB/s)
 Tproto:                    Iproto:     SSP|STP|SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           4154908636
          RD error count:           2808853200
      DW sync loss count:                    0
     Reset problem count:                    0

Phy09:S    attached: 50000d1000281260:07    chg count:01
 Attached device:      end device    Link rate:     G2 (3 GB/s)
 Tproto:                    Iproto:     SSP|STP|SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:            371055385
          RD error count:           3645431138
      DW sync loss count:                    0
     Reset problem count:                    0

Phy10:S    attached: 50000d1000281260:05    chg count:01
 Attached device:      end device    Link rate:     G2 (3 GB/s)
 Tproto:                    Iproto:     SSP|STP|SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           3790805948
          RD error count:           2017124313
      DW sync loss count:                    0
     Reset problem count:                    0

Phy11:S    attached: 50000d1000281260:04    chg count:01
 Attached device:      end device    Link rate:     G2 (3 GB/s)
 Tproto:                    Iproto:     SSP|STP|SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0

Phy12:D    attached: 50001c171601060d:00    chg count:00
 Attached device:      end device    Link rate:     G2 (3 GB/s)
 Tproto:             SSP    Iproto:             SSP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Virtual phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0



Dumping configuration info for Expander B
-----------------------------------------

A) As you can see phys 9 and 8 of this expander are
connected to phys 6 and 7 of Expander A as we already
noted above.  This forms the subtractive boundary of this
expander.

B) As you can see phys 3 and 2 of this expander are
connected to phys 7 and 3 of Expander C, thus forming
a wide port.

They use the table routing attribute.

C) The routing table of phys 3 and 2 is also
printed.  It is of course identical.

D) End devices attached are clearly identifiable.

expander_conf /sys/devices/pci0000\:01/0000\:01\:04.0/host11/sas/ha/ports/1/domain/50001c1716010600/50001c1071609c00/smp_portal

                  Vendor:             VITESSE 
                 Product:     VSC7160 Eval Brd
                Revision:                    4
               Component:             VITESSE 
            Component ID:                29024
      Component revision:                    4
   Expander Change Count:                    6
  Expander Route Indexes:                  160
          Number of phys:                   12
             Configuring:                   No
Configurable route table:                  Yes
Enclosure Logical Identifier: 00000000000000000000

Phy00:D    attached: 5000c50000102a65:00    chg count:01
 Attached device:      end device    Link rate:     G2 (3 GB/s)
 Tproto:             SSP    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           2351827995
          RD error count:           3908042718
      DW sync loss count:                    0
     Reset problem count:                    0

Phy01:D    attached: 50001c1071609c02:00    chg count:01
 Attached device:     SATA device    Link rate:   G1 (1,5 Gb/s)
 Tproto:             STP    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0

Phy02:T    attached: 5005076a000001e0:03    chg count:01
 Attached device:   edge expander    Link rate:     G2 (3 GB/s)
 Tproto:             SMP    Iproto:             SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           1939984985
          RD error count:           2207511641
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  00  enabled 5000c50000513385
  01  enabled 5c50000000409c11
  02  enabled 5005076a000001ed

Phy03:T    attached: 5005076a000001e0:07    chg count:01
 Attached device:   edge expander    Link rate:     G2 (3 GB/s)
 Tproto:             SMP    Iproto:             SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           2343129041
          RD error count:           3405770672
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  00  enabled 5000c50000513385
  01  enabled 5c50000000409c11
  02  enabled 5005076a000001ed

Phy04:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy05:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy06:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           3216754055
          RD error count:           4159684279
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy07:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           3687816959
          RD error count:           4261377627
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy08:S    attached: 50001c1716010600:07    chg count:01
 Attached device:   edge expander    Link rate:     G2 (3 GB/s)
 Tproto:             SMP    Iproto:             SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:            790459193
          RD error count:           3202994802
      DW sync loss count:                    0
     Reset problem count:                    0

Phy09:S    attached: 50001c1716010600:06    chg count:01
 Attached device:   edge expander    Link rate:     G2 (3 GB/s)
 Tproto:             SMP    Iproto:             SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0

Phy10:S    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           3888053628
          RD error count:           3011959286
      DW sync loss count:                    0
     Reset problem count:                    0

Phy11:S    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:            222822400
          RD error count:            246415626
      DW sync loss count:                    0
     Reset problem count:                    0



Dumping configuration info for Expander C
-----------------------------------------

A) As you can see phys 7 and 3 of this expander are
connected to phys 3 and 2 of Expander B, thus forming
a wide port. This forms the subtractive boundary
of this expander.

B) End devices attached are clearly identifiable.

expander_conf /sys/devices/pci0000\:01/0000\:01\:04.0/host11/sas/ha/ports/1/domain/50001c1716010600/50001c1071609c00/5005076a000001e0/smp_portal

                  Vendor:             VITESSE 
                 Product:     VSC7160 Eval Brd
                Revision:                    4
               Component:             VITESSE 
            Component ID:                29024
      Component revision:                    3
   Expander Change Count:                    4
  Expander Route Indexes:                  160
          Number of phys:                   13
             Configuring:                   No
Configurable route table:                  Yes
Enclosure Logical Identifier: 00000000000000000000

Phy00:D    attached: 5000c50000513385:01    chg count:01
 Attached device:      end device    Link rate:     G2 (3 GB/s)
 Tproto:             SSP    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0

Phy01:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy02:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           2147352567
          RD error count:           4294964735
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy03:S    attached: 50001c1071609c00:02    chg count:01
 Attached device:   edge expander    Link rate:     G2 (3 GB/s)
 Tproto:             SMP    Iproto:             SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0

Phy04:S    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           1558851767
          RD error count:           2009595383
      DW sync loss count:                    0
     Reset problem count:                    0

Phy05:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           4277141467
          RD error count:           4223134719
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy06:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           2147483647
          RD error count:           4026499071
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy07:S    attached: 50001c1071609c00:03    chg count:01
 Attached device:   edge expander    Link rate:     G2 (3 GB/s)
 Tproto:             SMP    Iproto:             SMP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           3243694232
          RD error count:            749555105
      DW sync loss count:                    0
     Reset problem count:                    0

Phy08:S    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0

Phy09:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           4091248127
          RD error count:           2936004581
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy10:T    attached: 0000000000000000:00    chg count:00
 Attached device:            none    Link rate:         unknown
 Tproto:                    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:           3758030847
          RD error count:           4294963183
      DW sync loss count:                    0
     Reset problem count:                    0
 Routing Table
  Empty (all zero)

Phy11:D    attached: 5c50000000409c11:00    chg count:01
 Attached device:      end device    Link rate:     G2 (3 GB/s)
 Tproto:             SSP    Iproto:                
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Physical phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0

Phy12:D    attached: 5005076a000001ed:00    chg count:00
 Attached device:      end device    Link rate:     G2 (3 GB/s)
 Tproto:             SSP    Iproto:             SSP
 Programmed MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Hardware   MIN-MAX linkrate: G1 (1,5 Gb/s) - G2 (3 GB/s)
 Virtual phy
 Partial pathway timeout value: 7 microseconds
 Connector type: No information
 Connector element index: 0
 Connector physical link: 0
        Invalid DW count:                    0
          RD error count:                    0
      DW sync loss count:                    0
     Reset problem count:                    0



