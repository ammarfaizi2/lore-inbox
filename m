Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292657AbSCRTqY>; Mon, 18 Mar 2002 14:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292617AbSCRTqI>; Mon, 18 Mar 2002 14:46:08 -0500
Received: from vocord.rt.mipt.ru ([194.85.82.184]:517 "HELO gleam.rt.mipt.ru")
	by vger.kernel.org with SMTP id <S292555AbSCRTpQ>;
	Mon, 18 Mar 2002 14:45:16 -0500
Date: Mon, 18 Mar 2002 22:45:02 +0300
From: Andrey Ulanov <drey@au.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] UFS bugfix, blocksize=16384
Message-ID: <20020318194502.GA18238@gleam.rt.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux/fs/ufs/super.c.old    Mon Feb 25 22:38:09 2002
+++ linux/fs/ufs/super.c        Mon Mar 18 22:42:52 2002
@@ -654,8 +654,8 @@
        uspi->s_fshift = fs32_to_cpu(sb, usb1->fs_fshift);

        if (uspi->s_bsize != 4096 && uspi->s_bsize != 8192
-         && uspi->s_bsize != 32768) {
-               printk("ufs_read_super: fs_bsize %u != {4096, 8192, 32768}\n", uspi->s_bsize);
+         && uspi->s_bsize != 16384 && uspi->s_bsize != 32768) {
+               printk("ufs_read_super: fs_bsize %u != {4096, 8192, 16384, 32768}\n", uspi->s_bsize)                goto failed;
        }
        if (uspi->s_fsize != 512 && uspi->s_fsize != 1024

-- 
with best regards, Andrey Ulanov.
drey<at>au.ru
