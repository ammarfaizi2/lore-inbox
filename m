Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315133AbSEHUig>; Wed, 8 May 2002 16:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315154AbSEHUif>; Wed, 8 May 2002 16:38:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:15092 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315133AbSEHUie>; Wed, 8 May 2002 16:38:34 -0400
Date: Wed, 8 May 2002 22:33:37 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: seasons@falcon.sch.bme.hu, Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: kernel/swsusp.c doesn't compile with modular IDE
Message-ID: <Pine.NEB.4.44.0205082225030.19321-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel/swsusp.c in 2.4.19-pre8-ac1 includes:

<--  snip  -->

...
#ifdef CONFIG_BLK_DEV_IDE
        ide_disk_suspend();
#else
#error Are you sure your disk driver supports suspend?
#endif
...

<--  snip  -->


You hit the #error when you try to compile swsusp into a kernel with a
completely modular IDE.


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

