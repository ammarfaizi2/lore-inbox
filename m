Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318266AbSHDXTx>; Sun, 4 Aug 2002 19:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318268AbSHDXTv>; Sun, 4 Aug 2002 19:19:51 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:32921 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318266AbSHDXTp>; Sun, 4 Aug 2002 19:19:45 -0400
Message-Id: <20020804231945Z318266-686+4139@vger.kernel.org>
From: <m.c.p@gmx.net>
To: unlisted-recipients:; (no To-header on input)
Date: Sun, 4 Aug 2002 19:19:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
	for <codeman@codeman.dyn.ee>; Sun, 4 Aug 2002 15:21:50 +0200
	from codeman.dyn.ee with ESMTP id g74DLmkT021108; Sun, 4 Aug 2002 15:21:50 +0200
Received: from fps.linux-systeme.org (fps [10.0.0.2])
	by extern.linux-systeme.org (8.12.5/8.12.5/Debian-1) with ESMTP id g74DLisN020610
	for <codeman@codeman.dyn.ee>; Sun, 4 Aug 2002 15:21:44 +0200
Received: from localhost (extern.linux-systeme.org [10.0.90.1])
	by fps.linux-systeme.org (8.10.0/8.10.0) with ESMTP id g74DLij05164
	for <mcp@fps>; Sun, 4 Aug 2002 15:21:44 +0200
X-Flags: 0000
Delivered-To: GMX delivery to m.c.p@gmx.net
Received: from pop.gmx.de [213.165.64.20]
	by localhost with POP3 (fetchmail-5.9.11)
	for mcp@fps (single-drop); Sun, 04 Aug 2002 15:21:44 +0200 (CEST)
Received: (qmail 25364 invoked by uid 0); 4 Aug 2002 13:17:40 -0000
Date: Mon, 5 Aug 2002 00:38:05 +0200
From: Marc-Christian Petersen <m.c.p@gmx.net>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Booting 2.4.19xx with initrd
X-PRIORITY: 2 (High)
X-Authenticated-Sender: #0000401921@gmx.net
X-Authenticated-IP: [80.144.49.208]
Message-ID: <20984.1028467060@www58.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Modified-Forwards: 2L.Remote address mcp@linux-systeme.de
X-UIDL: Y4R"!(]E"!;7]"!e,X"!
X-UID: 39
Priority: urgent
X-Sender: 520053043127-0001@t-dialin.net

Hi Marc (same name as me :)

> Normally, I am always making an initial ramdisk for better portability
> to other computers. The initird is causing problems with these kernels.
> When Lilo has loaded the initrd it prints out that it can't mount root
> fs on 302 or 03:02..... Booting without an initrd is running smoothly.
> There are no such problems with older kernels like 2.4.18 and earlier.
Sure, that's one of the many issues for 2.4.19. I did send Marcello a pat=
ch
also for this issue, but ... Decide yourself what is "but" ;)

> Well... is there any solution?
Sure. Try this one and it will work!

--- a/drivers/block/ll_rw_blk.c       Sun Jul  7 23:55:59 2002
+++ b/drivers/block/ll_rw_blk.c    Tue Jul  9 01:54:57 2002
@@ -1411,6 +1411,9 @@
 #ifdef CONFIG_STRAM_SWAP
 =09stram_device_init();
 #endif
+#ifdef CONFIG_BLK_DEV_RAM
+=09rd_init();
+#endif
 #ifdef CONFIG_ISP16_CDI
 =09isp16_init();
 #endif

--
Kind regards
        Marc-Christian Petersen
=20
http://sourceforge.net/projects/wolk
PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at http://www.keyserver.net. Encrypted e-mail preferred.

--=20
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net


