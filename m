Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQLPF7A>; Sat, 16 Dec 2000 00:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQLPF6k>; Sat, 16 Dec 2000 00:58:40 -0500
Received: from admin-serv.ufbi.ufl.edu ([128.227.82.166]:32525 "EHLO
	admin-serv.ufbi.ufl.edu") by vger.kernel.org with ESMTP
	id <S129718AbQLPF63>; Sat, 16 Dec 2000 00:58:29 -0500
Message-ID: <4504FB4A84EFD31196070050DA7E89D003BD15@admin-serv.ufbi.ufl.edu>
From: Jon Akers <jka@ufbi.ufl.edu>
To: "'Kernel Mailing List '" <linux-kernel@vger.kernel.org>
Subject: Problems compiling test13-pre2
Date: Sat, 16 Dec 2000 00:24:01 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to be a problem with the Makefile changes and NFS/NFSD/lockd
and module compilation.


Using egcs-2.91.66, modutils version 2.3.18, GNU Make version 3.77, GNU ld
version 2.10.91 (with BFD 2.10.0.33)

make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
cd /lib/modules/2.4.0-test13-pre2; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map
2.4.0-test13-pre2; fidepmod: *** Unresolved symbols in
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o
depmod: 	nlmclnt_proc
depmod: 	lockd_down
depmod: 	lockd_up
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o
depmod: 	nlmsvc_ops
depmod: 	lockd_down
depmod: 	nlmsvc_invalidate_client
depmod: 	lockd_up

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
