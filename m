Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVAKSxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVAKSxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 13:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVAKSxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 13:53:37 -0500
Received: from mail.tyan.com ([66.122.195.4]:48132 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261721AbVAKSxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 13:53:34 -0500
Message-ID: <3174569B9743D511922F00A0C943142307291405@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: YhLu <YhLu@tyan.com>, Andi Kleen <ak@muc.de>
Cc: "'Mikael Pettersson'" <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Tue, 11 Jan 2005 11:04:56 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.10 32 bit, it only crash core1/node0, still can go on but lost one
cpu.

~ # cat /proc/interrupts 
           CPU0       CPU1       CPU2       
  0:      47612          5       7643    IO-APIC-edge  timer
  2:          0          0          0          XT-PIC  cascade
  4:        365          0          1    IO-APIC-edge  serial
  8:          0          0          0    IO-APIC-edge  rtc
 17:          0          0          0   IO-APIC-level  libata
 18:          0          0          0   IO-APIC-level  libata
 19:          2          0          1   IO-APIC-level  ohci1394
 22:          0          0          0   IO-APIC-level  ohci_hcd
 23:          0          0          0   IO-APIC-level  ehci_hcd
NMI:          0          0          0 
LOC:      49259      49254      49253 
ERR:       5729
MIS:          0
~ #

-----Original Message-----
From: Yinghai Lu [mailto:yhlu@tyan.com] 
Sent: Tuesday, January 11, 2005 10:50 AM
To: 'Andi Kleen'
Cc: 'Mikael Pettersson'; 'jamesclv@us.ibm.com'; 'Matt_Domsch@dell.com';
'discuss@x86-64.org'; 'linux-kernel@vger.kernel.org';
'suresh.b.siddha@intel.com'
Subject: RE: 256 apic id for amd64

> It looks like the timer interrupt goes to the second CPU.
Even I don't lift the apic id for bsp, the MB with Nvidia chipset still can
not start core1/node0, from core0/node0 in kernel 2.6. But the 2.4.28 (32
bit, 64 bit) works well. 

How come?

YH
