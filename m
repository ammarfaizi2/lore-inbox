Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbUC1UDt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUC1UDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:03:49 -0500
Received: from p3EE062D5.dip0.t-ipconnect.de ([62.224.98.213]:11648 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S262415AbUC1UDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:03:41 -0500
Message-ID: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>
Date: Sun, 28 Mar 2004 22:02:01 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040212
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Very poor performance with 2.6.4
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I tested kernel 2.6.4. While compiling kdelibs and kdebase, I felt, that
kernel 2.6 seems to be slower than 2.4.25.

So I did some tests to compare the performance directly. Therefore I
rebooted for everey test in init 2 (no X).

I locally compiled 2.6.5rc2 3 times under 2.6.4 and under 2.4.25 on a
reiserfs LVM partition, which resides onto a IDE HD (using DMA) and got
the following result:

In the middle, compiling under kernel 2.6.4 tooks 9.3% more real time than
under 2.4.25.
The user-processortime is about the same, but the system-processortime is
under 2.6.4 32.9% higher than under 2.4.25.


Now, I switched off preemption. But the performance isn't much better:
8.8% (9.3% with preemption) more real-time compared to 2.4.25 and 28%
(32.9% with preepmtion) more system-time.



Does anybody know, how to get the same performance under 2.6.4 (or even
better) as under 2.4.25?


My hardware:
AMD Athlon(tm) XP 2000+

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:09.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 02)
00:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235
AC97 Audio Controller (rev 50)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO
AGP 4x TMDS


Regards,
Andreas Hartmann

