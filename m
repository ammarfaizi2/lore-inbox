Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSE1Wfl>; Tue, 28 May 2002 18:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSE1Wfk>; Tue, 28 May 2002 18:35:40 -0400
Received: from vsmtp1.tin.it ([212.216.176.221]:9442 "EHLO smtp1.cp.tin.it")
	by vger.kernel.org with ESMTP id <S293203AbSE1Wfj> convert rfc822-to-8bit;
	Tue, 28 May 2002 18:35:39 -0400
Message-ID: <3CDB32970001ECA0@ims1c.cp.tin.it>
Date: Tue, 28 May 2002 22:35:35 +0000
From: elvo@virgilio.it
Subject: =?iso-8859-1?Q?=5BPATCH=5D=20fs/ufs/super=2Ec=2C=20kernel=202=2E4=2E18=2Dpre8?=
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

there's a little compilation error concerning commas
in the fs/ufs/super.c code, a little patch follows.

elv


ufs_read_super.diff:

--- /root/super.c       Mon May 27 17:42:22 2002
+++ super.c     Mon May 27 17:43:09 2002
@@ -663,12 +663,12 @@
                goto failed;
        }
        if (uspi->s_bsize < 512) {
-               printk("ufs_read_super: fragment size %u is too small\n"
+               printk("ufs_read_super: fragment size %u is too small\n",
                        uspi->s_fsize);
                goto failed;
        }
        if (uspi->s_bsize > 4096) {
-               printk("ufs_read_super: fragment size %u is too large\n"
+               printk("ufs_read_super: fragment size %u is too large\n",
                        uspi->s_fsize);
                goto failed;
        }
@@ -678,12 +678,12 @@
                goto failed;
        }
        if (uspi->s_bsize < 4096) {
-               printk("ufs_read_super: block size %u is too small\n"
+               printk("ufs_read_super: block size %u is too small\n",
                        uspi->s_fsize);
                goto failed;
        }
        if (uspi->s_bsize / uspi->s_fsize > 8) {
-               printk("ufs_read_super: too many fragments per block (%u)\n"
+               printk("ufs_read_super: too many fragments per block (%u)\n",
                        uspi->s_bsize / uspi->s_fsize);
                goto failed;
        }

// EOF



