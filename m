Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315284AbSEABuH>; Tue, 30 Apr 2002 21:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSEABuG>; Tue, 30 Apr 2002 21:50:06 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:4619 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S315284AbSEABuF>; Tue, 30 Apr 2002 21:50:05 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: torvalds@transmeta.com, viro@math.psu.edu
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Export path_lookup()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Apr 2002 18:49:50 -0700
Message-Id: <E172jFe-0006YM-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


path_lookup() is no longer an inline function, and needs to be exported 
for jffs2, nfsd and af_unix to load as modules.

diff -aur linux-2.5.12/kernel/ksyms.c linux-2.5.12-export/kernel/ksyms.c
--- linux-2.5.12/kernel/ksyms.c	Tue Apr 30 17:08:45 2002
+++ linux-2.5.12-export/kernel/ksyms.c	Tue Apr 30 18:40:30 2002
@@ -144,6 +144,7 @@
 EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(lookup_mnt);
+EXPORT_SYMBOL(path_lookup);
 EXPORT_SYMBOL(path_init);
 EXPORT_SYMBOL(path_walk);
 EXPORT_SYMBOL(path_release);


