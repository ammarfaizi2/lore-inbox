Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSGCPsr>; Wed, 3 Jul 2002 11:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSGCPsq>; Wed, 3 Jul 2002 11:48:46 -0400
Received: from mail.uni-kl.de ([131.246.137.52]:5561 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id <S317037AbSGCPsq>;
	Wed, 3 Jul 2002 11:48:46 -0400
Date: Wed, 3 Jul 2002 17:51:13 +0200
From: Eduard Bloch <edi@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
Message-ID: <20020703155113.GA26299@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not another way round? Just make the ide-scsi driver be prefered,
and hack ide-scsi a bit to simulate the cdrom and adv.floppy devices
that are expected as /dev/hd* by some user's configuration?

To be honest - why keep ide-[cd,floppy,tape] when they can be almost
completely replaced with ide-scsi? I know about only few cdrom devices
that are broken (== not ATAPI compliant) but can be used with
workarounds in the current ide-cd driver. OTOH many users do already
need ide-scsi to access cd recorders and similar hardware, so they would
benefit much more from having ide-scsi as default than few users of
broken "atapi" drives.

Other operating systems did switch to constitent (scsi-based) way of
accessing all kinds of removable media drivers. Why does Linux have to
keep a kludge, written years ago without having a good concept?

Gruss/Regards,
Eduard.
-- 
Ich glaube nicht, daß man dieses Stück in Software umgesetzte Scheiße über-
haupt mieser machen kann, als es sowieso schon ist. Das dürfte das einzige
Programm sein, das vom Verhalten und seinen Anwendern her schlimmer als XP
auf einem Amiga ist. - Manuel Richardt in ka.talk ueber Outlook Express

