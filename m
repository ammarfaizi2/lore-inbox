Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUGIBQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUGIBQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 21:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUGIBQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 21:16:55 -0400
Received: from modemcable053.53-202-24.mc.videotron.ca ([24.202.53.53]:57987
	"EHLO omega3.sco.ath.cx") by vger.kernel.org with ESMTP
	id S262062AbUGIBQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 21:16:52 -0400
Message-ID: <40EDF209.70707@yahoo.ca>
Date: Thu, 08 Jul 2004 21:16:57 -0400
From: Jonathan Filiatrault <lintuxicated@yahoo.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040528
X-Accept-Language: en-ca, fr-ca
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net
Subject: [2.6.7] Ehci controller interrupts like crazy on nforce2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here it is: another nforce2 hardware bug. The ehci controller seems to
send a massive number of interrupts to the kernel (264379 per second).
This uses about 5 to 10% of the cpu. This shows up in top in the
"hi"(hard interrupts) indicator. Nothing unusual shows up in the kernel
log. My system has an Asus A7N8X Nforce2 Board with an Athlon XP 2800+
mounted on it.

[joe@omega3:~]$ cat /proc/interrupts ; sleep 1; cat /proc/interrupts
           CPU0
  0:     583513          XT-PIC  timer
  1:       1279    IO-APIC-edge  i8042
  7:     137293    IO-APIC-edge  parport0
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
14:      41463    IO-APIC-edge  ide0
15:         23    IO-APIC-edge  ide1
17:          9   IO-APIC-level  EMU10K1
18:      18584   IO-APIC-level  eth0
20:  121541873   IO-APIC-level  ehci_hcd
21:          0   IO-APIC-level  ohci_hcd
22:          0   IO-APIC-level  ohci_hcd
NMI:          0
LOC:     583348
ERR:          0
MIS:          0
           CPU0
  0:     584760          XT-PIC  timer
  1:       1280    IO-APIC-edge  i8042
  7:     137578    IO-APIC-edge  parport0
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
14:      41505    IO-APIC-edge  ide0
15:         23    IO-APIC-edge  ide1
17:          9   IO-APIC-level  EMU10K1
18:      18641   IO-APIC-level  eth0
20:  121806252   IO-APIC-level  ehci_hcd
21:          0   IO-APIC-level  ohci_hcd
22:          0   IO-APIC-level  ohci_hcd
NMI:          0
LOC:     584595
ERR:          0
MIS:          0
[joe@omega3:~]$

Any help or random thougths are welcome.

Happy Hacking,
Joe

