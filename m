Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbTFAWoT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 18:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264753AbTFAWoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 18:44:18 -0400
Received: from bms.ne.client2.attbi.com ([24.62.163.168]:23432 "EHLO
	ns.briggsmedia.com") by vger.kernel.org with ESMTP id S264750AbTFAWoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 18:44:18 -0400
Subject: athlon guidance
From: Joe Briggs <jbriggs@briggsmedia.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Jun 2003 18:57:47 -0400
Message-Id: <1054508267.1840.18.camel@family>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to build a 16-camera surveillance system with 8
2-channel multiplexed frame-grabber channels each.. Each channel is read
at at about 5 frames per second, the image converted into JPEG and
saved, and an MPEG-1 clip made at the same time (lots of storage, yes). 
I typically use a small IDE drive for my OS, and a 2-drive RAID-0 built
with WD120JB 8-MB cache drives.  I have learned the hard way that
regular IDE RAID controllers of the Promise type loose interrupts and
result in disk corruption, whereas the 3-ware (with its SCSI-like
hardware) are reliable. There is a LOT of processing and storage going
on here, and I have had good luck on my 8-camera systems using a
GigaByte GA7VAXP with AMD2400XP processors, but average about 10% CPU
utilization for each active (detected motion, now capturing and
encoding) channel.  So when all 8 cameras are active, I sustain about
80% or more total CPU loading.  Typically never more than 5 are active
at the same time.  My question is how can I scale up to get 16 camera
channels?  I use Debian Woody 2.4.19 with Reiserfs (good job Hans!).

The fastest Athlon that I can get is a AMD3200 XP with 400 Mhz FSB. On
the other hand, I can use the Tyan 2466 Dual Athlon board, but MP
processors only have a 266 Mhz FSB and the fastest speed is the 2800
MP.  So, given the nature of the CPU and data intensive application,
which is the faster platform:  a slower 2800/266 MHZ FSB dual processor
or a single 3200/400 MHZ FSB processor? 

All suggestions and analysis welcomed.

Joe



