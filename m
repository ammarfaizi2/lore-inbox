Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTEFX7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 19:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTEFX7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 19:59:40 -0400
Received: from franka.aracnet.com ([216.99.193.44]:30893 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261950AbTEFX7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 19:59:39 -0400
Date: Tue, 06 May 2003 17:11:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 664] New: bcm4400 won't transmit
Message-ID: <3710000.1052266295@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=664

           Summary: bcm4400 won't transmit
    Kernel Version: Linux slappy 2.5.69 #1 Mon May 5 12:54:32 EDT 2003 i686
                    unknown
            Status: NEW
          Severity: normal
             Owner: jgarzik@pobox.com
         Submitter: lkml-bugs@sigkill.net


Distribution: debian unstable  
Hardware Environment: Dell Inspiron 8500  
Software Environment: single-user boot for testing  
Problem Description:   
bcm4400 receives packets, but will not transmit (behaves as if the hardware link  
detection is down).  Works with the external driver under 2.4.20.  
  
Steps to reproduce:  
Get one (I believe they are built into i810 motherboards, among others) and build  
2.5.69 with support for it (modular or in-kernel makes no difference).  I believe it  
worked under 2.5.68 but it was not heavily tested at the time (I can do so if it is  
needed.)  
  
Ifconfig (after multiple dhcp attempts, raising by hand and pinging, etc) shows:  
eth0      Link encap:Ethernet  HWaddr 00:0B:DB:1B:89:3C  
          inet addr:192.168.33.47  Bcast:192.168.33.255  Mask:255.255.255.0  
          BROADCAST MULTICAST  MTU:1500  Metric:1  
          RX packets:505 errors:0 dropped:10 overruns:0 frame:0  
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0  
          collisions:0 txqueuelen:100  
          RX bytes:198656 (194.0 KiB)  TX bytes:0 (0.0 b)  
          Interrupt:11  
  
(note 0 TX packets)  
  
Modinfo shows:  
author:         David S. Miller (davem@redhat.com)  
description:    Broadcom 4400 10/100 PCI ethernet driver  
license:        GPL  
parm:           b44_debug:B44 bitmapped debugging message enable value  
vermagic:       2.5.69 preempt PENTIUM4 gcc-3.3  
depends:  
alias:          pci:v000014E4d00004401sv*sd*bc*sc*i*  
  
The only thing relating in dmesg is:  
b44.c:v0.6 (Nov 11, 2002)  
eth0: Broadcom 4400 10/100BaseT Ethernet 00:0b:db:1b:89:3c  
  
config, dmesg, etc all available.  ACPI enabled, standard DSDT.  APIC disabled by  
blacklisting ("Dell Inspiron with broken BIOS detected.")


