Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315843AbSEEJFY>; Sun, 5 May 2002 05:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315844AbSEEJFX>; Sun, 5 May 2002 05:05:23 -0400
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:4577 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S315843AbSEEJFX>;
	Sun, 5 May 2002 05:05:23 -0400
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200205050904.g4594GV05355@meduna.org>
Subject: CRC32 - computed or table-driven?
To: linux-kernel@vger.kernel.org
Date: Sun, 5 May 2002 09:44:12 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I need to compute a crc32 in my small not-ready-for-the-prime-time
patch against 2.4.19-pre. I do not (yet) follow the 2.5 development.

There is <linux/crc32.h> that does what I want, but not quite
effectively and with comments that it is unsuitable for bulk data
and that it will migrate to net/core/crc.c.

There are table-driven /usr/src/linux-2.4.19/fs/jffs2/crc32.*, but
this code is hidden in a filesystem subtree.

Any plans to do it "the right way" in 2.4? Is net/core (mentioned
in the crc32.h) the right place? - as we see it is used also
in the filesystem code and lib would be probably a better place.

I can post a patch, but I cannot test whether it breaks jffs2
and as this adds 1 kB to the kernel that might not be needed
I would like to ask first. Who is hacking these parts?

Regards
-- 
                                   Stano


