Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319240AbSHNIGx>; Wed, 14 Aug 2002 04:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319241AbSHNIGx>; Wed, 14 Aug 2002 04:06:53 -0400
Received: from central.caverock.net.nz ([210.55.207.1]:17673 "EHLO
	central.caverock.net.nz") by vger.kernel.org with ESMTP
	id <S319240AbSHNIGw>; Wed, 14 Aug 2002 04:06:52 -0400
Date: Wed, 14 Aug 2002 20:09:05 +1200 (NZST)
From: Eric Gillespie <viking@flying-brick.caverock.net.nz>
To: linux-kernel@vger.kernel.org
cc: ecoffey@alphalink.com.au
Subject: devfs_find_and_unregister fix (was Re: Linux 2.5.31)
Message-ID: <Pine.LNX.4.21.0208141953470.3423-100000@brick.flying-brick.caverock.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In reply to:
ecoffey at alphalink dot com dot au
>devfs problem, make modules_install fails with
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map 2.5.31; fi
>depmod: *** Unresolved symbols in
>/lib/modules/2.5.31/kernel/sound/core/snd.o
>depmod: devfs_find_and_unregister

fs/devfs/base.c,  Line 2315, add this:

--- fs/devfs/base_orig.c	Wed Aug 14 20:02:09 2002
+++ fs/devfs/base.c	Tue Aug 13 18:51:23 2002
@@ -2312,6 +2312,7 @@
 EXPORT_SYMBOL(devfs_mk_symlink);
 EXPORT_SYMBOL(devfs_mk_dir);
 EXPORT_SYMBOL(devfs_get_handle);
+EXPORT_SYMBOL(devfs_find_and_unregister);
 EXPORT_SYMBOL(devfs_get_flags);
 EXPORT_SYMBOL(devfs_set_flags);
 EXPORT_SYMBOL(devfs_get_maj_min);



-- 
 /|   _,.:*^*:.,   |\           Cheers from the Viking family, 
| |_/'  viking@ `\_| |            including Pippin, our cat
|    flying-brick    | $FunnyMail  Bilbo   : Now far ahead the Road has gone,
 \_.caverock.net.nz_/     5.39    in LOTR  : Let others follow it who can!

