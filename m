Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVLNVKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVLNVKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVLNVKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:10:07 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:59546 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932316AbVLNVKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:10:06 -0500
Message-ID: <024501c600f2$24e8ccc0$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: irq balancing question
Date: Wed, 14 Dec 2005 22:05:41 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list,

I try to tune my system with manually irq assigning, but this simple not
works, and i don't know why. :(
I have already read all the documentation in the kernel tree, and search in
google, but i can not find any valuable reason.

[root@dy-xeon-1 proc]# cat irq/217/smp_affinity
f
[root@dy-xeon-1 proc]# echo 1 > irq/217/smp_affinity
[root@dy-xeon-1 proc]# cat irq/217/smp_affinity
f
[root@dy-xeon-1 proc]# /bin/echo 1 > irq/217/smp_affinity
[root@dy-xeon-1 proc]# cat irq/217/smp_affinity
f
[root@dy-xeon-1 proc]# cat interrupts
           CPU0       CPU1       CPU2       CPU3
  0:        117          0          0   50302311    IO-APIC-edge  timer
  1:          0          0          0        560    IO-APIC-edge  i8042
  8:          0          0          0       8369    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 14:          0          0          0    9707311    IO-APIC-edge  ide0
169:          0          0          0          1   IO-APIC-level
uhci_hcd:usb2
177:          0          0          0          0   IO-APIC-level
uhci_hcd:usb3
185:          0          0          0          0   IO-APIC-level
uhci_hcd:usb4
193:          0          0          0    4335777   IO-APIC-level
ehci_hcd:usb1
209:          0          0          0 1777636996   IO-APIC-level  eth0
217:          0          0          0 2669520977   IO-APIC-level  eth1
NMI:          0          0          0          0
LOC:   50307523   50307625   50307006   50302885
ERR:          0
MIS:          0
[root@dy-xeon-1 proc]#

Can somebody help me?

Cheers,
Janos

