Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131316AbRC3Lss>; Fri, 30 Mar 2001 06:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbRC3Lsj>; Fri, 30 Mar 2001 06:48:39 -0500
Received: from ns.viventus.no ([195.18.200.139]:1292 "EHLO viventus.no")
	by vger.kernel.org with ESMTP id <S131316AbRC3Lsb>;
	Fri, 30 Mar 2001 06:48:31 -0500
From: Rafael Martinez <rafael@viewpoint.no>
To: linux-kernel@vger.kernel.org
Reply-To: rafael@viewpoint.no
Subject: 2.4.3 aic7xxx wont compile without a patch
Date: Fri, 30 Mar 2001 12:49:37 +0100 (CEST)
X-Mailer: XCmail 1.2 - with PGP support, PGP engine version 0.5 (Linux)
X-Mailerorigin: http://www.fsai.fh-trier.de/~schmitzj/Xclasses/XCmail/
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <auto-000000161184@viventus.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hei

I have tried to compile 2.4.3 and got a error in aic7xxx:

----------------------------------------------------------------------
make -C scsi
make[2]: Entering directory `/usr/src/linux-2.4.3/drivers/scsi'
make -C aic7xxx
make[3]: Entering directory `/usr/src/linux-2.4.3/drivers/scsi/aic7xxx'
make all_targets
make[4]: Entering directory `/usr/src/linux-2.4.3/drivers/scsi/aic7xxx'
make -C aicasm
make[5]: Entering directory
`/usr/src/linux-2.4.3/drivers/scsi/aic7xxx/aicasm'
gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm
aicasm_symbol.c:39:20: db1/db.h: No such file or directory
make[5]: *** [aicasm] Error 1
make[5]: Leaving directory
`/usr/src/linux-2.4.3/drivers/scsi/aic7xxx/aicasm'
make[4]: *** [aicasm/aicasm] Error 2
make[4]: Leaving directory `/usr/src/linux-2.4.3/drivers/scsi/aic7xxx'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.3/drivers/scsi/aic7xxx'
make[2]: *** [_subdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.3/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.3/drivers'
make: *** [_dir_drivers] Error 2
--------------------------------------------------------------------

If I patch the kernel source with the last version of the driver 6.1.8
from http://people.freebsd.org/~gibbs/linux/ , it works OK and I can
compile the kernel (I get some warnings, but it looks like it works, I can
start the machine with the new kernel, etc)

Didn't 2.4.3 supose to include this patch so we don't get this error?

Cheers
Rafael Martinez


