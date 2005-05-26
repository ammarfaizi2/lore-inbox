Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVEZEEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVEZEEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 00:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVEZEEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 00:04:46 -0400
Received: from lakermmtao12.cox.net ([68.230.240.27]:64676 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261177AbVEZEEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 00:04:44 -0400
Subject: IDE DMA with SATA, 2.6 kernels
From: Tyler Eaves <tyler@cg2.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 26 May 2005 00:05:13 -0400
Message-Id: <1117080313.4446.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system is an Athlon64 3000+ running on a Via KT800 board. Distro is
Ubuntu 5.04, running the Ubuntu AMD64-k8 2.6.11 kernel. However, I've
seen this problem with several other distros and various kernels, so it
seems to be a kernel issue. 

Disk Setup:

/dev/sda is a 200GB Maxtor SATA drive containing /boot,/, and swap
/dev/hda is a DVD-ROM/CD-RW driver (IDE)
/dev/hdc is a 160GB Maxtor IDE drive containing ThatOtherOS(TM)

The SATA drive works superbly, in UDMA133 mode. No complaints there.
However, it appears that the generic IDE driver grabs the IDE drives
before the Via driver can get them. This prevents me from using DMA on
those drivers, so, for instance, ripping CDs is really painful. I can
rip at about 2x on a good day, versus 40x+ ripping in Exact Audio Copy
under XP.

You can find the relevant portion of my dmesg (and hdparm) at
http://cg2.org/dmesg.txt

Any assistance would be very much appreciated.

