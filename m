Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTCEUEr>; Wed, 5 Mar 2003 15:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTCEUEr>; Wed, 5 Mar 2003 15:04:47 -0500
Received: from ma-northadams1a-382.bur.adelphia.net ([24.52.175.126]:50585
	"EHLO ma-northadams1a-382.bur.adelphia.net") by vger.kernel.org
	with ESMTP id <S261353AbTCEUEp>; Wed, 5 Mar 2003 15:04:45 -0500
Date: Wed, 5 Mar 2003 15:15:12 -0500
From: Eric Buddington <eric@ma-northadams1a-382.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: *.ko modules not made in recent kernels
Message-ID: <20030305151512.I30672@ma-northadams1a-382.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.5.64
module-init-tools 0.9.9
gcc 3.2.2

(bzImage compiles fine)

I have been unable to build modules in recent kernels (2.5.6[2-4], I
think). My approach is to configure everything I can as modules, and
use 'make -k modules' to make as much as possible (since I don't want
to spend an afternoon turning off the broken ones manually). In the
past, this created all but the broken modules, and 'make -k install'
would install the working ones.

Most directories compile with no warnings or errors, but I am not
getting a single *.ko file produced, and make modules_install
complains about this and fails.

Are the 72 failing modules keeping the good modules from finishing?  I
do not know at what stage the \*.ko files should be created.  I append
the list of failed modules (that had explicit compile errors).

-Eric

-------------------------
Failed modules:

drivers/block/ps2esdi.o
drivers/char/riscom8.o
drivers/char/isicom.o
drivers/char/esp.o
drivers/char/specialix.o
drivers/cpufreq/userspace.o
drivers/hotplug/acpiphp_glue.o
drivers/isdn/hisax/hisax_fcpcipnp.o
drivers/isdn/i4l/isdn_net_lib.o
drivers/isdn/i4l/isdn_common.o
drivers/isdn/i4l/isdn_concap.o
drivers/media/video/zr36120.o
drivers/media/video/zr36120_i2c.o
drivers/media/video/zr36120_mem.o
drivers/media/video/zr36067.o
drivers/mtd/devices/blkmtd.o
drivers/net/fc/iph5526.o
drivers/net/hamradio/dmascc.o
drivers/net/wan/sdlamain.o
drivers/net/wan/sdla_x25.o
drivers/net/wan/sdla_fr.o
drivers/net/rcpci45.o
drivers/net/defxx.o
drivers/scsi/pci2000.o
drivers/scsi/pci2220i.o
drivers/scsi/psi240i.o
drivers/scsi/dpt_i2o.o
drivers/scsi/tmscsim.o
drivers/scsi/AM53C974.o
drivers/scsi/gdth.o
drivers/scsi/inia100.o
drivers/scsi/cpqfcTSinit.o
drivers/scsi/cpqfcTSworker.o
drivers/scsi/ini9100u.o
drivers/scsi/i91uscsi.o
drivers/video/matrox/matroxfb_base.o
drivers/video/matrox/matroxfb_accel.o
drivers/video/matrox/matroxfb_DAC1064.o
drivers/video/matrox/matroxfb_Ti3026.o
drivers/video/matrox/matroxfb_misc.o
drivers/video/matrox/g450_pll.o
drivers/video/matrox/matroxfb_g450.o
drivers/video/matrox/matroxfb_crtc2.o
drivers/video/matrox/i2c-matroxfb.o
drivers/video/matrox/matroxfb_maven.o
drivers/video/sis/sis_main.o
drivers/video/sis/sis_accel.o
drivers/video/pm2fb.o
drivers/video/pm3fb.o
drivers/video/cyber2000fb.o
drivers/video/clgenfb.o
sound/isa/als100.o
sound/isa/azt2320.o
sound/isa/cmi8330.o
sound/isa/dt019x.o
sound/isa/es18xx.o
sound/isa/opl3sa2.o
sound/isa/ad1816a/ad1816a.o
sound/isa/cs423x/cs4232.o
sound/isa/cs423x/cs4236.o
sound/isa/gus/interwave-stb.o
sound/isa/gus/interwave.o
sound/isa/opti9xx/opti92x-ad1848.o
sound/isa/opti9xx/opti92x-cs4231.o
sound/isa/opti9xx/opti93x.o
sound/isa/sb/es968.o
sound/isa/sb/sb16.o
sound/isa/sb/sbawe.o
sound/isa/wavefront/wavefront.o
sound/oss/opl3sa2.o
sound/oss/ad1816.o
sound/oss/awe_wave.o



