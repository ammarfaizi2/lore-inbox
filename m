Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129283AbQKVOTS>; Wed, 22 Nov 2000 09:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129412AbQKVOTI>; Wed, 22 Nov 2000 09:19:08 -0500
Received: from north.net.CSUChico.EDU ([132.241.66.18]:19460 "EHLO
        north.net.csuchico.edu") by vger.kernel.org with ESMTP
        id <S129283AbQKVOTB>; Wed, 22 Nov 2000 09:19:01 -0500
Date: Wed, 22 Nov 2000 05:48:48 -0800
From: John Kennedy <jk@csuchico.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.18pre22
Message-ID: <20001122054848.A29453@north.csuchico.edu>
In-Reply-To: <E13xJ14-0002Do-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E13xJ14-0002Do-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Nov 19, 2000 at 01:11:33AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 01:11:33AM +0000, Alan Cox wrote:
> Anything which isnt a strict bug fix or previously agreed is now 2.2.19
> material.

  I needed to add this to get my kernel to compile.  I was trying to
get pci_resource_start to be defined.  It was only an issue with this
one object file, so this may or may not be the right place.

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
--- ./drivers/scsi/megaraid.c.OLD	Tue Nov 21 07:04:57 2000
+++ ./drivers/scsi/megaraid.c	Tue Nov 21 20:16:08 2000
@@ -248,6 +248,8 @@
 #include <asm/uaccess.h>
 #endif
 
+#include <linux/kcomp.h>
+
 #include "sd.h"
 #include "scsi.h"
 #include "hosts.h"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
