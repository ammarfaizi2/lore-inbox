Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUEFXFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUEFXFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 19:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUEFXFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 19:05:11 -0400
Received: from outbound04.telus.net ([199.185.220.223]:28386 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S263166AbUEFXFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 19:05:02 -0400
Subject: Re: hdc: lost interrupt ide-cd: cmd 0x3 timed out with
	2.6.6-rc3-bk8
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1083884857.6033.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 06 May 2004 17:07:37 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>zero IDE changes in bk6 -> bk8 but a lot of ACPI / IRQ related

OK.  My APIC is a SiS961.  
I can't send data from 2.6.6-rc3-bk8, but from 2.6.6-rc3-bk6,
/proc/acpi gives:
(/proc/acpi/processor/CPU0)
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        no
throttling control:      no
limit interface:         no
<not supported>
active state:            C1
default state:           C1
bus master activity:     00000000
states:
   *C1:                  promotion[--] demotion[--] latency[000]
usage[00000000]
    C2:                  <not supported>
    C3:                  <not supported>
<not supported>

cat /proc/acpi/sleep shows:
S0 S1 S4 S5
cat /proc/ide/sis shows:
SiS 5513 Ultra 100 chipset
--------------- Primary Channel ---------------- Secondary Channel
-------------
Channel Status: On                               On
Operation Mode: Compatible                       Compatible
Cable Type:     80 pins                          80 pins
Prefetch Count: 512                              512
Drive 0:        Postwrite Enabled                Postwrite Disabled
                Prefetch  Enabled                Prefetch  Disabled
                UDMA Enabled                     UDMA Enabled
                UDMA Cycle Time    3 CLK         UDMA Cycle Time    6
CLK
                Data Active Time   3 PCICLK      Data Active Time   3
PCICLK
                Data Recovery Time 1 PCICLK      Data Recovery Time 1
PCICLK
Drive 1:        Postwrite Enabled                Postwrite Disabled
                Prefetch  Enabled                Prefetch  Disabled
                UDMA Enabled                     UDMA Disabled
                UDMA Cycle Time    2 CLK         UDMA Cycle Time   
Reserved
                Data Active Time   3 PCICLK      Data Active Time   3
PCICLK
                Data Recovery Time 1 PCICLK      Data Recovery Time 3
PCICLK


... I don't know if any of this is helpful.  The IRQ and IO address
assignments (sent with my first email) are from 2.6.6-rc3-bk6.  

Thanks,
Bob

