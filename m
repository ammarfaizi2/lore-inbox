Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSGHX2R>; Mon, 8 Jul 2002 19:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317260AbSGHX2Q>; Mon, 8 Jul 2002 19:28:16 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:61120 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317258AbSGHX2Q>; Mon, 8 Jul 2002 19:28:16 -0400
Date: Mon, 8 Jul 2002 17:30:55 -0600
Message-Id: <200207082330.g68NUtH01899@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: 2.4.19-rc1 doesn't link
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Looks like initrd handling has been broken again:
init/do_mounts.o: In function `rd_load_image':
init/do_mounts.o(.text.init+0x941): undefined reference to `change_floppy'
init/do_mounts.o: In function `rd_load_disk':
init/do_mounts.o(.text.init+0xa9b): undefined reference to `change_floppy'
make: *** [vmlinux] Error 1

This is the config option combination that exposed the bug:
CONFIG_BLK_DEV_RAM=y
# CONFIG_BLK_DEV_INITRD is not set

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
