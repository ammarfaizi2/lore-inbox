Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267022AbTAUL2h>; Tue, 21 Jan 2003 06:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbTAUL2h>; Tue, 21 Jan 2003 06:28:37 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:3968 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267022AbTAUL2g>; Tue, 21 Jan 2003 06:28:36 -0500
Message-ID: <3E2D30F8.722D58C2@cinet.co.jp>
Date: Tue, 21 Jan 2003 20:37:28 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.59-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] PC-9800 sub-arch (3/29) alsa
References: <20030119051043.GA2662@yuzuki.cinet.co.jp>
		<20030119063422.GB2965@yuzuki.cinet.co.jp> <s5hof6a4vz3.wl@alsa2.suse.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> 
> Hi,
> 
> At Sun, 19 Jan 2003 15:34:22 +0900,
> Osamu Tomita wrote:
> >
> > This is patchset to support NEC PC-9800 subarchitecture
> > against 2.5.59 (3/29).
> >
> > ALSA sound drivers for PC98
> > Fix bug in 2.5.59 and additional driver.
> 
> are there any essential changes except for the replacement of
> CONFIG_PC9800 with CONFIG_X86_PC9800 ?
Only one change below.

diff -Nru linux/sound/drivers/mpu401/mpu401.c linux98/sound/drivers/mpu401/mpu40
1.c
--- linux/sound/drivers/mpu401/mpu401.c 2002-12-24 14:20:59.000000000 +0900
+++ linux98/sound/drivers/mpu401/mpu401.c       2003-01-04 14:05:38.000000000 +0
900
@@ -154,6 +154,9 @@
        (void)(get_option(&str,&enable[nr_dev]) == 2 &&
               get_option(&str,&index[nr_dev]) == 2 &&
               get_id(&str,&id[nr_dev]) == 2 &&
+#ifdef CONFIG_X86_PC9800
+              get_option(&str,&pc98ii[nr_dev]) == 2 &&
+#endif
               get_option(&str,(int *)&port[nr_dev]) == 2 &&
               get_option(&str,&irq[nr_dev]) == 2);
        nr_dev++;

Thanks,
Osamu Tomita
