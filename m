Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbVHZQx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbVHZQx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 12:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbVHZQx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 12:53:57 -0400
Received: from gromit.tds.de ([193.28.97.130]:3288 "EHLO gromit.tds.de")
	by vger.kernel.org with ESMTP id S965110AbVHZQx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 12:53:56 -0400
Date: Fri, 26 Aug 2005 18:53:43 +0200
From: Tim Weippert <weiti@security.tds.de>
To: linux-kernel@vger.kernel.org
Subject: Bad page state on AMD Opteron Dual System with kernel 2.6.13-rc6-git13
Message-ID: <20050826165342.GA11796@pbkg4>
Reply-To: Tim Weippert <weiti@security.tds.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: TDS Informationstechnologie AG
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there, 

i have read some postings concerning the following Kernel Messages:

Aug 26 18:04:01 montdsnsu3 kernel: grep[11619] general protection
rip:2aaaaaaaed43 rsp:7fffff9c0740 error:0
Aug 26 18:08:02 montdsnsu3 kernel: ping[14867] general protection
rip:2aaaaaaaed43 rsp:7fffffdbf300 error:0
Aug 26 18:08:03 montdsnsu3 kernel: grep[14987] general protection
rip:2aaaaaaaed43 rsp:7fffffdbfce0 error:0
Aug 26 18:08:03 montdsnsu3 kernel: grep[15041] general protection
rip:2aaaaaaaed43 rsp:7fffff9bf550 error:0

And the Bad Page State Messages:

Bad page state at prep_new_page (in process 'sh', page ffff8100011a69c8)
flags:0x0100000000000014 mapping:0000000000000000 mapcount:-3 count:0
Backtrace:

Call Trace:<ffffffff8015a653>{bad_page+99}
<ffffffff8015aa31>{prep_new_page+65}
       <ffffffff8015b1e2>{buffered_rmqueue+306}
<ffffffff8015b425>{__alloc_pages+261}
       <ffffffff8015b7c5>{get_zeroed_page+37}
<ffffffff801691b7>{__pmd_alloc+55}
       <ffffffff8016614e>{copy_page_range+462}
<ffffffff80131da4>{copy_mm+820}
       <ffffffff80132cba>{copy_process+2282}
<ffffffff80133407>{do_fork+215}
       <ffffffff8010db7a>{system_call+126}
<ffffffff8010deeb>{ptregscall_common+103}
       
Trying to fix it up, but a reboot is needed

I have the same issues on an SUN V20z with an dual opteron 248.

montdsnsu3:~# lspci
0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev
07)
0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev
05)
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE
(rev 03)
0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X
Bridge (rev 12)
0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev
01)
0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X
Bridge (rev 12)
0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev
01)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB
(rev 0b)
0000:01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB
(rev 0b)
0000:01:05.0 VGA compatible controller: Trident Microsystems Blade 3D
PCI/AGP (rev 3a)
0000:02:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 03)
0000:02:02.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 03)
0000:02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030
PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 08)


With the running kernel i get 2 kernel panics within the last week and
the machine crash totally.

I would like to offer my help if i can do anything in debugging this or
deal with more informations to fix this issue.

HTH, 

    weiti

-- 

Interpunktion und Orthographie dieser Email ist frei erfunden.
Eine Übereinstimmung mit aktuellen oder ehemaligen Regeln
wäre rein zufällig und ist nicht beabsichtigt.

Tim Weippert <weiti@topf-sicret.org>
http://www.topf-sicret.org/
