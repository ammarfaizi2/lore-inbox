Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263783AbTI2RC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTI2RC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:02:26 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.250]:46815 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id S263783AbTI2RCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:02:19 -0400
Message-ID: <002401c386ab$8447bf50$8501a8c0@munich.secaron.de>
From: "Christian Koch" <linkernel@ckoch.net>
To: <linux-kernel@vger.kernel.org>
Subject: date, time problem on ulrasparc III processors
Date: Mon, 29 Sep 2003 19:02:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a strange problem on Ultrasparc III Cu processor system. There are 2
CPUs in this SUN 280R. I have tried different kernels (2.4.21, 2.4.22)

The problem is, if I request date and time of the system I get different
answers. It seams, that there is a syncing problem between the hardware and
the system clock.

# hwclock --set --date="9/24/03 10:56:00"
# hwclock
Wed Sep 24 10:56:03 2003 -0.232462 seconds
# hwclock
Wed Sep 24 10:56:06 2003 -17180.423522 seconds
# hwclock
Wed Sep 24 10:56:09 2003 -0.637757 seconds

# date
Thu Sep 25 06:05:13 CEST 2003
# date
Thu Sep 25 01:18:53 CEST 2003
# hwclock
Wed Sep 24 10:57:52 2003 -17180.702994 seconds

In the system there are two equal cpu's. cpuinfo shows two different
CpuBogo's.

# cat /proc/cpuinfo
cpu : TI UltraSparc III+ (Cheetah+)
fpu : UltraSparc III+ integrated FPU
promlib : Version 3 Revision 5
prom : 4.5.21
type : sun4u
ncpus probed : 2
ncpus active : 2
Cpu0Bogo : 1599.07
Cpu0ClkTck : 0000000047868c00
Cpu1Bogo : 1.63
Cpu1ClkTck : 0000000047868c00
MMU Type : Cheetah+
State:
CPU0: online
CPU1: online

I think the date, time problem can be a bug in the RTC-module.

Christian

