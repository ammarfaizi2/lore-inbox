Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265802AbUF2Qc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbUF2Qc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 12:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbUF2Qc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 12:32:56 -0400
Received: from lucidpixels.com ([66.45.37.187]:7118 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S265802AbUF2Qcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 12:32:53 -0400
Date: Tue, 29 Jun 2004 12:32:49 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Linux Kernel 2.6.7 Shows Two i8042's in /proc/interrupts?
Message-ID: <Pine.LNX.4.60.0406291231040.10973@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have APIC+ACPI+/dev/rtc enabled.

Curious though, why two i8042's?

$ uname -a
Linux 2.6.7 #2 SMP Tue Jun 22 18:19:08 EDT 2004 i686 unknown unknown GNU/Linux

$ gcc -v
Reading specs from 
/a/app/gcc-3.4.0/bin/../lib/gcc/i686-pc-linux-gnu/3.4.0/specs
Configured with: ./configure --prefix=/app/gcc-3.4.0
Thread model: posix
gcc version 3.4.0

# cat /proc/interrupts
            CPU0       CPU1
   0:   30593638          0    IO-APIC-edge  timer
   1:       7228          0    IO-APIC-edge  i8042
   8:     130233          0    IO-APIC-edge  rtc
   9:          0          0   IO-APIC-level  acpi
  12:      87258          0    IO-APIC-edge  i8042
  14:         38          0    IO-APIC-edge  ide0
  15:         72          0    IO-APIC-edge  ide1
  16:    3967335          0   IO-APIC-level  nvidia
  18:    3431241          0   IO-APIC-level  eth0
  20:     401933          0   IO-APIC-level  ide2
  21:      23832          0   IO-APIC-level  EMU10K1
NMI:          0          0
LOC:   30594585   30594625
ERR:          0
MIS:          0

