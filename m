Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUJOR5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUJOR5c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUJOR5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:57:32 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:62147 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S268251AbUJOR5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:57:20 -0400
Message-Id: <200410151757.i9FHv6PP011165@rumms.uni-mannheim.de>
Date: Fri, 15 Oct 2004 19:55:15 +0200
From: Matthias Bernges <mbernges@rumms.uni-mannheim.de>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.x maybe r8169 (maybe disk related as well)
In-Reply-To: <20041005105918.GA31831@electric-eye.fr.zoreil.com>
References: <200410050836.i958atFM000889@rumms.uni-mannheim.de>
	<20041005105918.GA31831@electric-eye.fr.zoreil.com>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry that the answer took so long but I had some exams.

Am Di 05.10.04 um 12:59 CEST schrieb Francois Romieu
<romieu@fr.zoreil.com>:

> Matthias Bernges <mbernges@rumms.uni-mannheim.de> :
> [...]
> > since I use the Realtek 8169 Network card I get a kernel Oops
> > after which the kernel hangs completly.
> > I tried Kernel 2.6.6, 2.6.7 and 2.6.8.1. It appears randomly but
> > only if the machine has high load and high network traffic.
> 
> Can you give 2.6.9-rc3 a try ?

I tried 2.6.9-rc4 and had the same problem.

> 
> [...]
> > >>EIP; c0271498 <SELECT_DRIVE+18/50>   <=====
> > 
> > >>edi; c15eb220 <pg0+113d220/3fb50000>
> > >>esp; c0497f80 <per_cpu__tvec_bases+ec0/1008>
> > 
> > Code;  c0271498 <SELECT_DRIVE+18/50>
> > 00000000 <_EIP>:
> > Code;  c0271498 <SELECT_DRIVE+18/50>   <=====
> >    0:   8b 46 60                  mov    0x60(%esi),%eax   <=====
> > Code;  c027149b <SELECT_DRIVE+1b/50>
> >    3:   ba 3c 00 00 00            mov    $0x3c,%edx
> 
> Your ata subsytem does not seem happy.
> 
> Can you provide:
> - a short description of the system;

Gentoo Linux, Duron 900Mhz, 3 Nics (3com, Via-Rhine On Board and r8169),
Via Chipset, 2x2GB HardDisk, DVD, Something more?

> - the revision of your compiler;

lise root # gcc --version
gcc (GCC) 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)

> - lspci -vx output;

http://www.matthiasbernges.de/linux/lspci

> - /sbin/lsmod output;

Module                  Size  Used by
rtc                    10296  0 

> - complete dmesg after boot;

http://www.matthiasbernges.de/linux/dmesg

> - vmstat 1 for a few seconds during network load;
http://www.matthiasbernges.de/linux/vmstat

> - the content of /proc/interrupts adter a few seconds of network load.

           CPU0       
  0:     795867          XT-PIC  timer
  1:          8          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:          0          XT-PIC  ehci_hcd, CMI8738-MC6
  5:     866353          XT-PIC  uhci_hcd, eth2
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:      10964          XT-PIC  uhci_hcd, eth0
 11:     215952          XT-PIC  uhci_hcd, eth1
 12:         58          XT-PIC  i8042
 14:      11944          XT-PIC  ide0
 15:         64          XT-PIC  ide1
NMI:          0 
ERR:          0



matthias
