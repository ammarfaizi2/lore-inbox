Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbTDVGXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 02:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTDVGXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 02:23:55 -0400
Received: from mx1.technologica.biz ([217.75.131.34]:60854 "EHLO
	mx1.technologica.biz") by vger.kernel.org with ESMTP
	id S261848AbTDVGXy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 02:23:54 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Help needed: unable to stop /dev/md1 where root is mounted on 2.4.19.SuSE-246
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Date: Tue, 22 Apr 2003 09:37:22 +0300
Message-ID: <15F26D0D9E18E24583D912511D668FF802722A@exchange.ad.tlogica.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-topic: Help needed: unable to stop /dev/md1 where root is mounted on 2.4.19.SuSE-246
Thread-Index: AcMImaFCvDVvnPfeSKeXJ4tglhPGcw==
From: "Michael Daskalov" <MDaskalov@technologica.biz>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have the following situation. I have my root partition on RAID1 (/dev/hda5 and /dev/sda5) - /dev/md1.

I have two partitions for boot, which are also in raid1 configuration.
/dev/md0 (/dev/hda1, /dev/sda1).

On system reboot or shutdown the md device is not stopped (a clean record is not written on it),
And after system reboot it always starts reconstructing.

Which is the correct way to setup the situation?


I'm activating the raid devices through initrd's linuxrc, where I'm loading a 
1) hpt302.o driver,
2) raid1.o, raid5.o - The raid personality modules, and then I run 
3)raidstart --all.


On shutdown I see messages that
/dev/md2, /dev/md3, /dev/md4 are also stopped.

I see a message saying /dev/md0 is put in read-only mode.

Only /dev/md1 where is my rootfs is not stopped.
I see the following message:
md: md1 is still active

Best regards and 10x for any help,
Mihail Daskalov
