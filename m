Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUJHGVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUJHGVc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 02:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUJHGVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 02:21:32 -0400
Received: from sicdec1.epfl.ch ([128.178.50.33]:30943 "EHLO sicdec1.epfl.ch")
	by vger.kernel.org with ESMTP id S267973AbUJHGVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 02:21:30 -0400
Message-ID: <1097216489.416631e91faf9@imapwww.epfl.ch>
X-Imap-User: michel.mengis@epfl.ch
Date: Fri,  8 Oct 2004 08:21:29 +0200
From: michel.mengis@epfl.ch
To: linux <linux-kernel@vger.kernel.org>
Subject: Kernel 2.6.8 and DELL's DOTHAN Processor B0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 128.178.9.34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all,

I have a lot of trouble to bring the kernel 2.6.8-1 to detect my dothan
processor.
It's a Pentium M Dothan B0 version, 1.7Ghz/600Mhz.
The BIOS is DELL's D800 Bios version 09.

I added 3 patches:
cpufreq-speedstep-dothan-3.patch :add correct frequency table in speedstep.c
dothan-speedstep-fix.patch : add correct Level2 cache
bk-cpufreq.patch : from http://linux-dj.bkbits.net/cpufreq

I added a lot of output in speedstep-centrino.c, acpi/processor.c to track the
problem.

I notice that my computer is running always in the lowest speed evenif I'm
stressing it... All ouputs I added show me that Speedstep isn't the cause,
neither CPUFreq but while CPUFreq calls all notifiers, acpi/processor.c's
CPUFREQ_INCOMPATIBLE change the max speed to the lowest evenif during
cpufreq_acpi_cpu_init the max speed is well detected.
Seems to be like it's coz at boot time the kernel doesn't detect correctly the
max speed.
dmesg shows me that a 600Mhz processor has been detected only and not 1.7Ghz.
(on my D600 pentium M not dothan, it detects correctly 1.6Ghz)

is there a fix for that ?
is it a known bug ?

thx for all help I can get,

best regards,

michel.
