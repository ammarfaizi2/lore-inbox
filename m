Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbTLISRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266040AbTLISRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:17:20 -0500
Received: from pop.gmx.de ([213.165.64.20]:13741 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265983AbTLISRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:17:19 -0500
X-Authenticated: #13632028
From: Matthias Krebs <mat.krebs@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11:ide-disk partitions not mountable
Date: Tue, 9 Dec 2003 19:17:03 +0100
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200312091917.03649.mat.krebs@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two ide-controllers, one onboard (VIA vt8233a) and one as pci-card 
(Promise ultra100 tx2). The following drives are attached:

Controller1:
/dev/ide/host0/bus0/target0/lun0/disc ibm harddisk (hda)
/dev/ide/host0/bus1/target0/lun0/cd ide cd-writer
/dev/ide/host0/bus1/target1/lun0/cd ide dvd-rom

Controller2:
/dev/ide/host2/bus1/target0/lun0/disc maxtor harddisk (hde)
/dev/ide/host2/bus1/target1/lun0/disc maxtor harddisk (hdg)

The system (debian unstable) boots from an raid0 on hde/hdg. hda can be 
accesed by parted,fdsik etc., partitions and filesystems can be created. But 
when i try to mount any partiton on hda i get:

mount: /dev/hda2 already mounted or /mnt/hda2/ busy

which it isn`t (cat /proc/mounts). All partitions can be mounted under 2.4 
kernels.

Is it now necessary to use kernel option "Boot off-board chipsets first 
support" for this kind of setup?

Bye, Matthias
