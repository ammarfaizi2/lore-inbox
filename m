Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbTC2X61>; Sat, 29 Mar 2003 18:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbTC2X61>; Sat, 29 Mar 2003 18:58:27 -0500
Received: from main.gmane.org ([80.91.224.249]:10387 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261276AbTC2X60>;
	Sat, 29 Mar 2003 18:58:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: John Goerzen <jgoerzen@complete.org>
Subject: Kernel compile error with 2.5.66
Date: Sat, 29 Mar 2003 18:08:45 -0600
Organization: Complete.Org
Message-ID: <87brztwwaa.fsf@complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@complete.org
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
Cancel-Lock: sha1:lAEKSBT828O0n4avbZaKjWpFPVQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is on PowerPC:

  gcc -Wp,-MD,mm/.fremap.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=fremap -DKBUILD_MODNAME=fremap -c -o mm/.tmp_fremap.o mm/fremap.c
In file included from mm/fremap.c:14:
include/linux/swapops.h: In function `pte_to_swp_entry':
include/linux/swapops.h:54: warning: implicit declaration of function `pte_file'
mm/fremap.c: In function `sys_remap_file_pages':
mm/fremap.c:139: `PTE_FILE_MAX_BITS' undeclared (first use in this function)
mm/fremap.c:139: (Each undeclared identifier is reported only once
mm/fremap.c:139: for each function it appears in.)
make[2]: *** [mm/fremap.o] Error 1
make[1]: *** [mm] Error 2
make[1]: Leaving directory `/home/jgoerzen/kernel/linux-2.5.66'
make: *** [stamp-build] Error 2

