Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268097AbTBWJcp>; Sun, 23 Feb 2003 04:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268098AbTBWJcp>; Sun, 23 Feb 2003 04:32:45 -0500
Received: from [144.139.35.78] ([144.139.35.78]:9350 "EHLO portal.frood.au")
	by vger.kernel.org with ESMTP id <S268097AbTBWJcm>;
	Sun, 23 Feb 2003 04:32:42 -0500
Message-ID: <3E589799.3000105@bigpond.com>
Date: Sun, 23 Feb 2003 20:42:49 +1100
From: James Harper <james.harper@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: SMP and CPU1 not showing interrupts in /proc/interrupts
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

somewhere between about 2.5.53 and 2.5.62 my /proc/interrupts has gone 
from an approximately even distribution of interrupts between CPU0 and 
CPU1 to grossly uneven:

           CPU0       CPU1       
  0:   13223321    2233217    IO-APIC-edge  timer
  1:      13442          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:     291874          0    IO-APIC-edge  serial
  8:          3          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 14:      18932          0    IO-APIC-edge  ide0
 15:         14          0    IO-APIC-edge  ide1
 16:     190607          1   IO-APIC-level  eth0, nvidia
 17:       3214          0   IO-APIC-level  bttv0
 18:      14249          1   IO-APIC-level  ide2
 19:     121942          0   IO-APIC-level  uhci-hcd, wlan0
NMI:          0          0
LOC:   15458218   15458423
ERR:          0
MIS:          0

if i really hit the system hard then CPU1 will start accruing interrupts 
but in a mostly idle state CPU1 just sits on its bum and lets CPU0 
handle them all, with the exception of irq #0, for some reason.

any ideas?

thanks

James


