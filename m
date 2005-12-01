Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVLAEez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVLAEez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 23:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVLAEez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 23:34:55 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:14509 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1751395AbVLAEey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 23:34:54 -0500
X-ORBL: [68.79.81.172]
Date: Wed, 30 Nov 2005 23:34:51 -0500 (EST)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: linux-kernel@vger.kernel.org
Subject: Megaraid problems
Message-ID: <Pine.LNX.4.62.0511302325230.13110@node2.an-vo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all :)

    I am wondering whether someone can shed some light on issues I am 
having with LSI Megaraid cards ? The problem described below is with
SATA card, but I am also having difficulties with LSI HBA Scsi adaptor, 
ableit I have not yet eliminated all the obvious things to try.

    Please CC your replies as I am not on the list..

    My setup: dual Opteron 252 with 8 GB RAM, Tyan Thunder K8W. SUSE 9.3 -
I tried both the native SUSE kernel and 2.6.14.3 from kernel.org, 4 400GB 
Western Digital drivers in RAID5 configuration connected to LSI MegaRAID 
SATA 150-6

    The are also 3 250 GB drives connected to on-board SIL3114 where Linux 
is installed.

    Problem: card recognizes the disks fine, initialization goes ok.
I can create partition with no problem. However when copying files I get
filesystem corruption (holds both with ext3 and XFS). For ext3 I see the 
following message:

EXT3-fs error (device sdd1): ext3_new_block: Allocating block in system zone - 
block = 100663296
Aborting journal on device sdd1.
EXT3-fs error (device sdd1) in ext3_prepare_write: Journal has aborted
ext3_abort called.
EXT3-fs error (device sdd1): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only

    The hardware is otherwise stable - this box also has 3 disks in software 
RAID5 connected to SIL3114 and a similar box has 3ware card with 8 drives, 
which function fine.

    I would appreciate any suggestions on what to try/tweak/patch.

                 thank you very much !

                       Vladimir Dergachev

PS One more thing - none of LSI binary configuration tools work - they report 
they cannot find the adaptor even though /dev/megadev0 is pointing to correct 
adaptor (I tried both 253 and 254 for major numbers and 0,1,2,3,4 for 
minor numbers). I was not successful in finding an open-source management 
tool..

