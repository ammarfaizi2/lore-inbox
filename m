Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUALOHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUALOHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:07:42 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:30593
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S266174AbUALOHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:07:40 -0500
Date: Mon, 12 Jan 2004 09:06:52 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: 2.6.1 and irq balancing
In-Reply-To: <btt7pt$3m8$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.58.0401120905140.7344@montezuma.fsmlabs.com>
References: <7F740D512C7C1046AB53446D37200173618820@scsmsx402.sc.intel.com>
 <btt7pt$3m8$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jan 2004, Bill Davidsen wrote:

> I'm not sure this is a problem in any way, but some serious load is
> needed to trigger sharing, if indeed the NIC was the source of the ints
> on CPU2.
>
> 2x Xeon-2.4GHz, HT enabled. "CPU2" from memory, it was the other
> physical CPU, not another sibling. Worked fine, didn't break, don't
> regard it as a problem.

Seems to be ok here, 2x Xeon 2.0GHz w/ HT

           CPU0       CPU1       CPU2       CPU3
  0:  322303400          0          0          0    IO-APIC-edge  timer
  1:     255712          0          0          0    IO-APIC-edge  i8042
  2:          0          0          0          0          XT-PIC  cascade
  3:        828          0          0          0    IO-APIC-edge  serial
  4:      70682          0          0          0    IO-APIC-edge  serial
  8:          1          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 12:    1244334          0          0          0    IO-APIC-edge  i8042
 14:   21708437        129   18313205       1492    IO-APIC-edge  ide0
 15:   10859481         78    9907876         64    IO-APIC-edge  ide1
 16:        655          0          0          0   IO-APIC-level  uhci_hcd
 19:      34458          0          0          0   IO-APIC-level  uhci_hcd, serial
 20:    5762897          0    1009019          0   IO-APIC-level  eth0
 22:    4985838         60    4908642         42   IO-APIC-level  ide2, ide3
 23:    3667147          0          0          0   IO-APIC-level  eth1
 48:    8459639          0          0          0   IO-APIC-level  EMU10K1
NMI:          0          0          0          0
LOC:  322346360  322346360  322346359  322346358
ERR:          0
MIS:          0

