Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbULBSRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbULBSRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbULBSRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:17:38 -0500
Received: from pakastelohi.cypherpunks.to ([82.94.251.194]:32981 "EHLO
	mail.cypherpunks.to") by vger.kernel.org with ESMTP id S261685AbULBSRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:17:30 -0500
From: Anonymous via the Cypherpunks Tonga Remailer 
	<nobody@cypherpunks.to>
Comments: This message did not originate from the Sender address above.
	It was remailed automatically by anonymizing remailer software.
	Please report problems or inappropriate use to the
	remailer administrator at <abuse@cypherpunks.to>.
To: linux-kernel@vger.kernel.org
Subject: ext3 on encrypted device mapper
Message-Id: <20041202181727.5B50011643@mail.cypherpunks.to>
Date: Thu,  2 Dec 2004 19:17:27 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

i'm using a linux debian sarge on an encrypted root filesystem with linux 2.6.10-rc2 kernel.

Filesystem is encrypted using dmcrypt, the encryption framework working on top of the device mapper.

I deleted a file and immediatelly i attempted to recover it using debugfs.

Linux aaa 2.6.10-rc2 #1 Wed Dec 1 09:52:37 CET 2004 i686 GNU/Linux

aaa:~# df -k .
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/mapper/rootfs     8676440   5278584   2957108  65% /

aaa:~# debugfs /dev/mapper/rootfs
debugfs 1.35 (28-Feb-2004)
debugfs:  lsdel

aaa:~# strings /dev/mapper/rootfs
strings: Warning: '/dev/mapper/rootfs' is not an ordinary file

Unfortunatelly neither with debugfs neither with a rogue strings i can access data on the encrypted filesystem.

I think that device mapper should be modified to allow debugfs checking and to allow access on it like a tradional hard drive.

Regards

--aaa
