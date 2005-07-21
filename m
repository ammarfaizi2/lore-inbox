Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVGUSE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVGUSE6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 14:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVGUSE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 14:04:58 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:47055 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261826AbVGUSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 14:04:54 -0400
Date: Thu, 21 Jul 2005 20:04:48 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-Id: <20050721200448.5c4a2ea0.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd gladly (ehum..) redo this mind-numbingly boring test if someone can
point me to a magic software which unleashes some untapped powersaving
feature of the CPU.

_Kernel 2.6.13-rc3 Boot to Death_:

2h48m at 100 HZ
2h48m at 250 HZ
2h47m at 1000 HZ

_"Load"_:

#!/bin/sh
touch time-hz-start
while (true) do
    touch time-hz-end
    sleep 1m
done

_Environment_:

No distro (LFS-ish pure 64 bit), no X, no network, no cronjobs, no
peripherals attached. Screen off by hardware switch, but disk obviously
spinning all the time. powernow_k8 + cpufreq_userspace + powernowd-0.96
= 800 MHz at "idle". Fan(s?) always on unless room temperature falls to
a slightly chilly level.

_Machine_:

Acer Aspire 1520 (1524) WLMi, AMD Athlon 64 3400+ (socket 754 according
to dmidecode-2.6). L1 64K/64K, L2 1024K, 512MB DDR RAM. Manufacturing
date 18 March 2005. Bought 20 May 2005. Battery used to full drain ca 5
times prior to this test (after the initial 3 charge/drains to reach its
full potential). "cat /proc/acpi/battery/BAT0/info":

present:                 yes
design capacity:         4000 mAh
last full capacity:      4000 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 400 mAh
design capacity low:     120 mAh
capacity granularity 1:  280 mAh
capacity granularity 2:  3880 mAh
model number:            Bat 8Cell
serial number:           236
battery type:            Lion
OEM info:                Acer

Mvh
Mats Johannesson
--
