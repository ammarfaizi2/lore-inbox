Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284186AbRLRQf0>; Tue, 18 Dec 2001 11:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284195AbRLRQfQ>; Tue, 18 Dec 2001 11:35:16 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:23812 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S284186AbRLRQfH>; Tue, 18 Dec 2001 11:35:07 -0500
Message-Id: <4.3.2.7.2.20011218113324.00e657e0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 18 Dec 2001 11:35:03 -0500
To: lkml <linux-kernel@vger.kernel.org>
From: David Relson <relson@osagesoftware.com>
Subject: 2.5.1 - undefined symbols building NFS as a module
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here're the relevant settings (AFAIK):

CONFIG_NFS_FS=m
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V3 is not set

and here's the complaint from "make modules_install"

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.1; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.1/kernel/fs/nfs/nfs.o
depmod: 	seq_escape
depmod: 	seq_printf
make: *** [_modinst_post] Error 1

