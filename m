Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261314AbSJLRif>; Sat, 12 Oct 2002 13:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbSJLRif>; Sat, 12 Oct 2002 13:38:35 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:40676 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261314AbSJLRie>;
	Sat, 12 Oct 2002 13:38:34 -0400
Date: Sat, 12 Oct 2002 19:44:23 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210121744.TAA05263@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.5.42 spins down disks on reboot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5.42 kernel spins down IDE disks during a reboot.
This causes a delay during the following bootup as the
BIOS waits for the disks to spin up. I imagine it also
adds unnecessary wear to the drive mechanics.

2.5.41 and older kernels did not do this.
