Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbRETTx2>; Sun, 20 May 2001 15:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262202AbRETTxS>; Sun, 20 May 2001 15:53:18 -0400
Received: from aeon.tvd.be ([195.162.196.20]:55473 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S262201AbRETTxB>;
	Sun, 20 May 2001 15:53:01 -0400
Date: Sun, 20 May 2001 21:51:04 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: const __init
Message-ID: <Pine.LNX.4.05.10105202145520.1667-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since a while include/linux/init.h contains the line

    * Also note, that this data cannot be "const".

Why is this? Because const data will be put in a different section?

However, quite some code defines const __init variables (see list below).

So what should be done now?
  1. Remove const from __initdata variables
  2. Make __inidata work with const variables

FWIW, many sources still use __init for data, while it should be __initdata.

Gr{oetje,eeting}s,

						Geert

Appendix: here's the list of affected source files:

    arch/arm/kernel/setup.c
    arch/m68k/amiga/config.c
    arch/ppc/amiga/config.c
    arch/ppc/kernel/residual.c
    drivers/acorn/net/ether1.c
    drivers/acorn/net/ether3.c
    drivers/acorn/net/etherh.c
    drivers/atm/ambassador.c
    drivers/cdrom/cdu31a.c
    drivers/char/dsp56k.c
    drivers/char/pc110pad.c
    drivers/char/qpmouse.c
    drivers/char/softdog.c
    drivers/ide/buddha.c
    drivers/ide/rapide.c
    drivers/net/ewrk3.c
    drivers/net/hamradio/6pack.c
    drivers/net/hamradio/bpqether.c
    drivers/net/hamradio/mkiss.c
    drivers/net/hamradio/scc.c
    drivers/net/hamradio/yam.c
    drivers/net/strip.c
    drivers/net/tokenring/ibmtr.c
    drivers/net/wan/lapbether.c
    drivers/net/wan/z85230.c
    drivers/pci/names.c
    drivers/scsi/seagate.c
    drivers/sound/sonicvibes.c
    drivers/video/amifb.c
    drivers/video/aty128fb.c
    drivers/video/atyfb.c
    drivers/video/mdacon.c
    drivers/video/modedb.c
    drivers/video/newport_con.c
    drivers/video/promcon.c
    drivers/video/riva/fbdev.c
    drivers/video/sticon-bmode.c
    drivers/video/sticon.c
    drivers/video/tdfxfb.c
    drivers/video/vgacon.c
    drivers/zorro/names.c
    net/ax25/af_ax25.c
    net/ipv4/ipip.c
    net/ipx/af_ipx.c
    net/ipx/af_spx.c
    net/lapb/lapb_iface.c
    net/netrom/af_netrom.c
    net/unix/af_unix.c

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

