Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbRBPQol>; Fri, 16 Feb 2001 11:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbRBPQob>; Fri, 16 Feb 2001 11:44:31 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:10247 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129159AbRBPQo0>; Fri, 16 Feb 2001 11:44:26 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200102161644.RAA13697@green.mif.pg.gda.pl>
Subject: "make dep" problem
To: linux-kernel@vger.kernel.org (kernel list)
Date: Fri, 16 Feb 2001 17:44:27 +0100 (CET)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   While trying to compile 2.4.1-ac1[34] I noticed that the following error
message appears sometimes:

make[3]: *** No rule to make target 
/home29/ankry/kernel/2.4/linux/drivers/pci/devlist.h', needed by `names.o'.
Stop.
make[3]: Leaving directory /home29/ankry/kernel/2.4/linux/drivers/pci'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory /home29/ankry/kernel/2.4/linux/drivers/pci'
make[1]: *** [_subdir_pci] Error 2
...

Most ofteen while compiling kernel multiple times using
      make oldconfig;make dep;make clean; make "MAKE=make -j2" bzImage
(with different configurations)

I also noticed that sometimes mode files is incleded in "mkdep" command line
than usually:

 make[4]: Entering directory /home29/ankry/kernel/2.4/linux/drivers/char'
-/home29/ankry/kernel/2.4/linux/scripts/mkdep -D__KERNEL__ -I/home29/ankry/kernel/2.4/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i586  -- acquirewdt.c adbmouse.c amigamouse.c amikeyb.c amiserial.c applicom.c applicom.h atarimouse.c atixlmouse.c busmouse.c busmouse.h cd1865.h conmakehash.c console.c console_macros.h consolemap.c cyclades.c defkeymap.c digi.h digi1.h digiFep1.h digiPCI.h digi_bios.h digi_fep.h dn_keyb.c ds1620.c dsp56k.c dtlk.c dz.c dz.h efirtc.c epca.c epca.h epcaconfig.h esp.c fep.h generic_serial.c h8.c h8.h hp600_keyb.c i810-tco.c i810-tco.h i810_rng.c ip2.c ip2main.c isicom.c istallion.c keyboard.c logibusmouse.c lp.c mem.c misc.c mixcomwd.c moxa.c msbusmouse.c mxser.c n_hdlc.c n_r3964.c n_tty.c nvram.c nwbutton.c nwbutton.h nwflash.c pc110pad.c pc110pad.h pc_keyb.c pcwd.c pcxx.c pcxx.h ppdev.c pty.c q40_keyb.c qpmouse.c random.c raw.c riscom8.c riscom8.h riscom8_reg.h rocket.c rocket_int.h rsf16fmi.h!
 rtc.c sbc60xxwdt.c scan_keyb.c scan_keyb.h scc.h selection.c serial.c serial167.c serial_21285.c serial_amba.c sh-sci.c sh-sci.h softdog.c specialix.c specialix_io8.h stallion.c sx.c sx.h sxboards.h sxwindow.h synclink.c sysrq.c toshiba.c tpqic02.c tty_io.c tty_ioctl.c vc_screen.c vino.h vme_scc.c vt.c wd501p.h wdt.c wdt285.c wdt977.c wdt_pci.c > .depend
+/home29/ankry/kernel/2.4/linux/scripts/mkdep -D__KERNEL__ -I/home29/ankry/kernel/2.4/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i586  -- acquirewdt.c adbmouse.c amigamouse.c amikeyb.c amiserial.c applicom.c applicom.h atarimouse.c atixlmouse.c busmouse.c busmouse.h cd1865.h conmakehash.c console.c console_macros.h consolemap.c consolemap_deftbl.c cyclades.c defkeymap.c digi.h digi1.h digiFep1.h digiPCI.h digi_bios.h digi_fep.h dn_keyb.c ds1620.c dsp56k.c dtlk.c dz.c dz.h efirtc.c epca.c epca.h epcaconfig.h esp.c fep.h generic_serial.c h8.c h8.h hp600_keyb.c i810-tco.c i810-tco.h i810_rng.c ip2.c ip2main.c isicom.c istallion.c keyboard.c logibusmouse.c lp.c mem.c misc.c mixcomwd.c moxa.c msbusmouse.c mxser.c n_hdlc.c n_r3964.c n_tty.c nvram.c nwbutton.c nwbutton.h nwflash.c pc110pad.c pc110pad.h pc_keyb.c pcwd.c pcxx.c pcxx.h ppdev.c pty.c q40_keyb.c qpmouse.c random.c raw.c riscom8.c riscom8.h riscom8_reg.h rocket.c roc!
ket_int.h rsf16fmi.h rtc.c sbc60xxwdt.c scan_keyb.c scan_keyb.h scc.h selection.c serial.c serial167.c serial_21285.c serial_amba.c sh-sci.c sh-sci.h softdog.c specialix.c specialix_io8.h stallion.c sx.c sx.h sxboards.h sxwindow.h synclink.c sysrq.c toshiba.c tpqic02.c tty_io.c tty_ioctl.c vc_screen.c vino.h vme_scc.c vt.c wd501p.h wdt.c wdt285.c wdt977.c wdt_pci.c > .depend

 make[4]: Entering directory /home29/ankry/kernel/2.4/linux/drivers/pci'
-/home29/ankry/kernel/2.4/linux/scripts/mkdep -D__KERNEL__ -I/home29/ankry/kernel/2.4/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i586  -- compat.c gen-devlist.c names.c pci.c proc.c quirks.c setup-bus.c setup-irq.c setup-res.c syscall.c > .depend
+/home29/ankry/kernel/2.4/linux/scripts/mkdep -D__KERNEL__ -I/home29/ankry/kernel/2.4/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i586  -- classlist.h compat.c devlist.h gen-devlist.c names.c pci.c proc.c quirks.c setup-bus.c setup-irq.c setup-res.c syscall.c > .depend
 make[4]: Leaving directory /home29/ankry/kernel/2.4/linux/drivers/pci'

(Note  consolemap_deftbl.c     in drivers/char and 
       classlist.h devlist.h   in drivers/pci )

Could any Makefile expert check whether it is not a Makefile problem ?

Is it now necessary to do  "make mrproper"  before each make dep ???

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
