Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTEWHKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 03:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTEWHKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 03:10:11 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:58108 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261182AbTEWHKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 03:10:02 -0400
Date: Fri, 23 May 2003 09:23:03 +0200 (CEST)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.s-tec.de
To: linux-kernel@vger.kernel.org
Subject: Defective Disk not reported as Dead
Message-ID: <Pine.LNX.4.55.0305230911560.18618@omega.s-tec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.9; AVE: 6.19.0.3; VDF: 6.19.0.20; host: email)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

We do have some strange problem here.
A Server with some qlogic qla2002f-Adapter (2-channel)is connected to 2
external Raid-Arrays via multipathing and raid1 on top of it. But the
multipathing and raid should not be the problem here.

The Raid-Arrays itself are Fibre-to-Ide and present themselfs as 1 disks
each. Now for the problem: Due to a firmware bug the raid-boxes sometimes
seems to loose the ability to write (and read i think) to their internal
disks. The effect is, that the cache fills up but does not get flushed to
disks. When full, the box is in a strange state. It gets detected when
reloading the kernel-modules but linux can no longer access the disks.
when accessing the partition all processes on that disk hang (like ls or
ps -efa etc.)

The disk is never recognized as defective and never thrown out of raid.
So the processes do not continue to work.

Is this fault simply not detectable, or could this be a problem with the
qlogic-driver ?

The Kernel used is some 2.4.18 Version by SuSE.

Thanks for help

Oktay Akbal

