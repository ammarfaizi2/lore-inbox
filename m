Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVANA2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVANA2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVANAYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:24:38 -0500
Received: from sloth.wcug.wwu.edu ([140.160.139.223]:40973 "HELO
	sloth.wcug.wwu.edu") by vger.kernel.org with SMTP id S261754AbVANAXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:23:48 -0500
Date: Thu, 13 Jan 2005 16:24:13 -0800 (PST)
From: Josh Logan <josh@wcug.wwu.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: timer problems on 2.6.x on IBM x306 servers
Message-ID: <Pine.LNX.4.58.0501131441130.4772@sloth.wcug.wwu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have had multiple IBM x306 servers loose interrupts.  Eventually the
timer will get a few interrupts, but it can stay at the same spot for a
long time.

If I reboot, and then add append=noapic in lilo and reboot again I never
get a problem in the future.

One of the boxes I have has a third NIC and if I use noapic the machine
cannot boot.  Is there something besides noapic I should try.

Is there any other information you would like?

jlogan@x306:~$ cat /proc/interrupts
           CPU0       CPU1
  0:    4604125          0    IO-APIC-edge  timer
  1:          9          0    IO-APIC-edge  i8042
  9:          0          0   IO-APIC-level  acpi
 14:          2          0    IO-APIC-edge  libata
 15:    1679925          0    IO-APIC-edge  libata
 16:          0          0   IO-APIC-level  uhci_hcd
 18:      12672          0   IO-APIC-level  eth0
 19:          0          0   IO-APIC-level  uhci_hcd
 23:          0          0   IO-APIC-level  ehci_hcd
NMI:          0          0
LOC:    4604073    4604079
ERR:          0
MIS:          0


							Later, JOSH
