Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTKETZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTKETZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:25:32 -0500
Received: from gprs29.vodafone.hu ([80.244.97.79]:31099 "EHLO kian.localdomain")
	by vger.kernel.org with ESMTP id S263051AbTKETZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:25:30 -0500
Subject: Problem in 2.6.0-test9-mm1 with siimage+hdparm
From: Krisztian VASAS <iron@ironiq.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1068060376.757.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Nov 2003 20:26:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all...

I've got an Abit NF7-S v2.0 mainboard with an Athlon XP 2000+ CPU.

Yesterday I've compiled the 2.6.0-test9 kernel with -mm1 patch. My
system is on the first sata device (/dev/hde).

After reboot I've noticed an Oops after setting dma and other settings
with hdparm. Without -mm1 patch the machine works well. 

After the oops I've tried to find what the problem was. 

hdparm -c1 /dev/hde -> nothing was happened, switched off...
hdparm -d1 /dev/hde -> Oops...

I've got this messages:

hde: DMA timeout retry status error: status=0x58 { DriveReady
SeekComplete DataRequest }

ide2: reset phy, status=0x00000113 siimage_reset

.
.
.

Buffer I/O error on device hde2, logical block 97865
lost page write due to I/O error on hde2

.
.
.

EXT3-fs error (device hde2) in start_transaction: Journal has aborted



The rootfs is /dev/hde2.

Please cc the answers to my address, because I'm not lkml member...

Thanks:


IroNiQ
-- 
Web: http://ironiq.hu
E-mail: iron@ironiq.hu

