Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317374AbSFRKKC>; Tue, 18 Jun 2002 06:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317375AbSFRKKB>; Tue, 18 Jun 2002 06:10:01 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:64989 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S317374AbSFRKKB>; Tue, 18 Jun 2002 06:10:01 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 18 Jun 2002 11:10:41 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre build failure
Message-ID: <20020618111041.A3317@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Current 2.4 BK tree failes to link the vmlinux image:

[ ... ]
        -o vmlinux
init/do_mounts.o: In function `rd_load_image':
init/do_mounts.o(.text.init+0xa20): undefined reference to `change_floppy'
init/do_mounts.o: In function `rd_load_disk':
init/do_mounts.o(.text.init+0xb08): undefined reference to `change_floppy'
make: *** [vmlinux] Error 1
bogomips kraxel /work/bk/2.4/build# grep FD .config
CONFIG_BLK_DEV_FD=m
# CONFIG_FDDI is not set
bogomips kraxel /work/bk/2.4/build# 

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
