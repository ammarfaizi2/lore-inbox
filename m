Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284517AbRLERQR>; Wed, 5 Dec 2001 12:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284512AbRLERQG>; Wed, 5 Dec 2001 12:16:06 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:2031 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S283773AbRLERQB>;
	Wed, 5 Dec 2001 12:16:01 -0500
Date: Wed, 5 Dec 2001 18:15:59 +0100
From: David Weinehall <tao@acc.umu.se>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Todo] Remove usage of (f)suser in kernel
Message-ID: <20011205181558.R360@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a quick round of grep:ing, I came up with the following files
needing fixes to substitute usage of (f)suser for proper capabilities:

linux/include/linux/sched.h -- definitions of suser/fsuser
linux/include/linux/compatmac.h -- compability-macro for suser

linux/fs/ufs/balloc.c -- 1 occurence of fsuser

linux/drivers/net/wan/lmc/lmc_main.c -- 6 occurences of suser
linux/drivers/net/pcmcia/xircom_tulip_cb.c -- 1 occurence of suser
linux/drivers/net/fealnx.c -- 1 occurence of suser

linux/drivers/block/cciss.c -- 2 occurences of suser
linux/drivers/block/cpqarray.c -- 3 occurences of suser
linux/drivers/block/swim3.c -- 1 occurence of suser
linux/drivers/block/swim_iop.c -- 1 occurence of suser

linux/drivers/char/tty_io.c -- 4 occurences of suser
linux/drivers/char/vt.c -- 3 occurences of suser
linux/drivers/char/rocket.c -- 1 occurence of suser
linux/drivers/char/mxser.c -- 1 occurence of suser
linux/drivers/char/serial167.c -- 1 occurence of suser
linux/drivers/char/ip2main.c -- 1 occurence of suser
linux/drivers/char/rio/rio_linux.c -- 1 occurence of suser
linux/drivers/char/moxa.c -- 1 occurence of suser

linux/drivers/scsi/cpqfcTSinit.c -- 1 occurence of suser

linux/drivers/pcmcia/ds.c -- 1 occurence of suser

linux/drivers/s390/char/tubtty.c -- 1 occurence of suser

linux/drivers/media/video/zr36120.c -- 1 occurence of suser

linux/arch/i386/kernel/mtrr.c --  9 occurences of suser

linux/arch/sparc64/kernel/ioctl32.c -- 1 occurence of suser

Since I don't know what the maintainers of some of these files want
as capabilities, I've decided not to fix this myself. zr36120.c is
only a matter of removing an #ifdef/#else/#endif combo and doing some
reindenting, though.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
