Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129653AbRBITlW>; Fri, 9 Feb 2001 14:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129791AbRBITlN>; Fri, 9 Feb 2001 14:41:13 -0500
Received: from jalon.able.es ([212.97.163.2]:34712 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129653AbRBITlD>;
	Fri, 9 Feb 2001 14:41:03 -0500
Date: Fri, 9 Feb 2001 20:40:53 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: harmless trigraph warning in ac8
Message-ID: <20010209204053.A3124@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Building latest 2.4.1-ac8, I got the following warning (it is harlmess, but
if you want to make the compiler cleanly silent...):

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-f
rame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686
    -c -o names.o names.c
In file included from names.c:38:
devlist.h:1279:33: warning: trigraph ??) ignored
devlist.h:6371:25: warning: trigraph ??) ignored
In file included from names.c:44:
devlist.h:1279:33: warning: trigraph ??) ignored
devlist.h:6371:25: warning: trigraph ??) ignored
In file included from names.c:50:
devlist.h:1279:33: warning: trigraph ??) ignored
devlist.h:6371:25: warning: trigraph ??) ignored

File is drivers/pci/devlist.h:
1279: DEVICE(109e,036c,"Bt879(??) Video Capture")
6371: VENDOR(2a15,"3D Vision(???)")

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac8 #2 SMP Fri Feb 9 01:53:46 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
