Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292770AbSBZUFZ>; Tue, 26 Feb 2002 15:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292773AbSBZUFU>; Tue, 26 Feb 2002 15:05:20 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:34001 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292768AbSBZUFB>;
	Tue, 26 Feb 2002 15:05:01 -0500
Date: Tue, 26 Feb 2002 12:04:59 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.5.5 ERROR] Can't compile without NFS
Message-ID: <20020226120459.A17913@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

system :
-------------------
PPro 150 SMP
Kernel 2.5.5
Debian 2.2
-------------------

.config :
---------------
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
---------------

make install :
----------------
make[2]: Entering directory `/usr/src/kernel-source-2.5/fs'
gcc -D__KERNEL__ -I/usr/src/kernel-source-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=filesystems  -DEXPORT_SYMTAB -c filesystems.c
filesystems.c: In function `sys_nfsservctl':
filesystems.c:30: dereferencing pointer to incomplete type
filesystems.c:30: dereferencing pointer to incomplete type
filesystems.c:30: warning: value computed is not used
filesystems.c:32: dereferencing pointer to incomplete type
filesystems.c:33: dereferencing pointer to incomplete type
filesystems.c:33: dereferencing pointer to incomplete type
filesystems.c:33: warning: value computed is not used
make[2]: *** [filesystems.o] Error 1
make[2]: Leaving directory `/usr/src/kernel-source-2.5/fs'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/kernel-source-2.5/fs'
make: *** [_dir_fs] Error 2
----------------

	Of course, enabling NFSD fix this problem...

	Jean
