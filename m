Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVBAOel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVBAOel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 09:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVBAOel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 09:34:41 -0500
Received: from gwout.thalesgroup.com ([195.101.39.227]:5381 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S262027AbVBAOei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 09:34:38 -0500
Message-ID: <41FF9366.5030203@fr.thalesgroup.com>
Date: Tue, 01 Feb 2005 15:34:14 +0100
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] support of motherboards with ICH6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a P8SAA Super Micro motherboard that features an i925x chipset and need 
to use the motherboard's watchdog. Super Micro has told my PC vendor that the 
watchdog is functional on this motherboard so it should work.

To make it work,I have recompiled a 2.6.11rc2-bk9 kernel since it contains ICH6 
definitions for the i8xx-tco driver.

So, now I can modprobe i8xx-tco without an error (notably without the error that 
says that the watchdog is hardware disabled).

But when I open the watchdog and close it the system does not reboot as 
expected.I am surprised since I see a "not stopping watchdog in /var/log/messages :

Feb  1 16:07:07 think3 kernel: i8xx TCO timer: heartbeat value must be 
2<heartbeat<39, using 30
Feb  1 16:07:07 think3 kernel: i8xx TCO timer: initialized (0x0460). 
heartbeat=30 sec (nowayout=0)
Feb  1 16:07:15 think3 kernel: i8xx TCO timer: Unexpected close, not stopping 
watchdog!
<snip>
Feb  1 16:12:03 think3 kernel: i8xx TCO timer: Unexpected close, not stopping 
watchdog!

Here is what lpsci says :
[root@think3 ~]# lspci
00:00.0 Host bridge: Intel Corp. 925X/XE Memory Controller Hub (rev 05)
00:01.0 PCI bridge: Intel Corp. 925X/XE PCI Express Root Port (rev 05)
00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI 
#1 (rev 03)
00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI 
#2 (rev 03)
00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI 
#3 (rev 03)
00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI 
#4 (rev 03)
00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 
EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d3)
00:1e.2 Multimedia audio controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) AC'97 Audio Controller (rev 03)
00:1f.0 ISA bridge: Intel Corp. 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge 
(rev 03)
00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE 
Controller (rev 03)
00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller 
(rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 
(PCIE)]
01:00.1 Display controller: ATI Technologies Inc: Unknown device 5b70
02:00.0 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet Controller 
(rev 03)
02:00.1 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet Controller 
(rev 03)
02:03.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller


Has anybody a similar setup working ? I can buy another motherboard easily, so 
feel free to tell me about other motherboards that work.

	thank you for your help,

       P.O. Gaillard


