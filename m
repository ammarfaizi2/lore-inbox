Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422691AbWJ3WHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWJ3WHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422680AbWJ3WHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:07:33 -0500
Received: from maximus.itgardendrift.se ([193.138.74.3]:1402 "EHLO
	DR2EX01.hosting.itg") by vger.kernel.org with ESMTP
	id S1422679AbWJ3WHd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:07:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: SV: PROBLEM: raid5 just dies
Date: Mon, 30 Oct 2006 23:07:44 +0100
Message-ID: <6FDE26082D451C41BE1A3742966200B3B51C67@DR2EX01.hosting.itg>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: raid5 just dies
Thread-Index: Acb8bwB9MfapsA1BRAitQKHNoziZ1AAAFJ8g
From: "Andreas Paulsson" <andreas.paulsson@itgarden.se>
To: "Neil Brown" <neilb@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Exactly how are aes-loop and raid5 connected together?

We use 5x300gb drives in a raid5 array, which is then used as a physical
disk in an lvm volume, with one logical volume. This logical volume is
then encrypted with "losetup -e aes /dev/loop1 /dev/vg0/lv0", and then
formatted with ReiserFS.

>Is the loop above the raid5 or below?

It's below the raid5, since the raid5 is created straight onto the
drives.

>A precise description of how things are arranged would help.

Does the above look good enough?

>A copy of /proc/mdstat would be good to.

Personalities : [raid1] [raid6] [raid5] [raid4]
md1 : active raid1 hdn1[1] hdf1[0]
      195358336 blocks [2/2] [UU]

md0 : active raid5 hdd1[1] hdc1[0] hdh1[4] hdg1[3] hde1[2]
      1250274304 blocks level 5, 64k chunk, algorithm 2 [5/5] [UUUUU]

unused devices: <none>

>Thanks,
>NeilBrown


/Andreas
