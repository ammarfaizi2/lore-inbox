Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130740AbRCEWoB>; Mon, 5 Mar 2001 17:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130739AbRCEWnw>; Mon, 5 Mar 2001 17:43:52 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:45323 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S130058AbRCEWnj>; Mon, 5 Mar 2001 17:43:39 -0500
Date: Mon, 5 Mar 2001 14:43:33 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
In-Reply-To: <Pine.GSO.4.21.0103051605490.27373-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.31ksi3.0103051439250.12620-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Alexander Viro wrote:

New Adaptec driver does not build. It won't. People, can anyone enlighten me
why do we use a user space library for a kernel driver at all?

=== Cut ===
make -C aic7xxx modules
make[3]: Entering directory `/tmp/build-kernel/usr/src/linux-2.4.2ac12/drivers/scsi/aic7xxx'
make -C aicasm
make[4]: Entering directory `/tmp/build-kernel/usr/src/linux-2.4.2ac12/drivers/scsi/aic7xxx/aicasm'
gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c -o aicasm
aicasm_symbol.c:39: db1/db.h: No such file or directory
make[4]: *** [aicasm] Error 1
make[4]: Leaving directory `/tmp/build-kernel/usr/src/linux-2.4.2ac12/drivers/scsi/aic7xxx/aicasm'
make[3]: *** [aicasm/aicasm] Error 2
make[3]: Leaving directory `/tmp/build-kernel/usr/src/linux-2.4.2ac12/drivers/scsi/aic7xxx'
make[2]: *** [_modsubdir_aic7xxx] Error 2
make[2]: Leaving directory `/tmp/build-kernel/usr/src/linux-2.4.2ac12/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/tmp/build-kernel/usr/src/linux-2.4.2ac12/drivers'
make: *** [_mod_drivers] Error 2
=== Cut ===

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV, 89014

