Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131763AbQLZRlr>; Tue, 26 Dec 2000 12:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131795AbQLZRlh>; Tue, 26 Dec 2000 12:41:37 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:42500 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S131763AbQLZRlX>; Tue, 26 Dec 2000 12:41:23 -0500
Message-Id: <200012261709.eBQH99D02130@pincoya.inf.utfsm.cl>
To: "David S. Miller" <davem@redhat.com>, Alan.Cox@linux.org
cc: linux-kernel@vger.kernel.org
Subject: 2.2.19pre3 on sparc64: Hangs on boot, "no cont in shutdown!"??
X-Mailer: MH [Version 6.8.4]
Date: Tue, 26 Dec 2000 14:09:09 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Red Hat 6.2 + updates (plus local hacks, like binutils-2.10.0.33) on
sparc64 (Ultra 1).

When booting, it detects the floppy drive (I left a floppy in by mistake,
the floppy is OK, and the same boots fine with 2.2.18):

  [snip snap]
  Floppy drive(s): fd0 is 1.44M

after this, it just gives the "no cont in shutdown!" message after a few
seconds, and stays stuck AFAICS (not much patience, I'm afraid). This
message is inside drivers/block/floppy.c:floppy_shutdown(), a file that
hasn't changed from 2.2.18 to 2.2.19pre3.

BTW, the floppy here (and also on sparc32) normally gives:

  $ mdir
  init: set default params
  Cannot initialize 'A:'

the first time around, the second time it works OK. A too short timeout in
mtools or in the kernel perhaps?
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
