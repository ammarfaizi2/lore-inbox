Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRKRPBz>; Sun, 18 Nov 2001 10:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279783AbRKRPBp>; Sun, 18 Nov 2001 10:01:45 -0500
Received: from t2.redhat.com ([199.183.24.243]:29936 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S279778AbRKRPBk>; Sun, 18 Nov 2001 10:01:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011115023337.A1724@thyrsus.com> 
In-Reply-To: <20011115023337.A1724@thyrsus.com> 
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Symbols missing help 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 18 Nov 2001 15:01:22 +0000
Message-ID: <27382.1006095682@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



esr@thyrsus.com said:
> The following configuration symbols are missing help entries.  If you
> can supply a help entry for one or more of these, please send it to me
> for incorporation in the master Configure.help file. 

CONFIG_MTD_ARM_INTEGRATOR left for rmk.


i82092 compatible bridge support
CONFIG_I82092
  This provides support for the Intel I82092AA PCI-to-PCMCIA bridge device,
  found in some older laptops and more commonly in evaluation boards for the
  chip.

CONFIG_JFFS_PROC_FS
  Enabling this option will cause statistics from mounted JFFS file systems
  to be made available to the user in the /proc/fs/jffs/ directory.

Support for absent chips in bus mapping
CONFIG_MTD_ABSENT
  This option enables support for a dummy probing driver used to 
  allocated placeholder MTD devices on systems that have socketed
  or removable media.  Use of this driver as a fallback chip probe 
  preserves the expected registration order of MTD device nodes on
  the system regardless of media presence.  Device nodes created
  with this driver will return -ENODEV upon access.
 
MTD Emulation using block device
CONFIG_MTD_BLKMTD
  This driver allows a block device to appear as an MTD. It would
  generally be used in the following cases:

    Using Compact Flash as an MTD, these usually present themselves to
    the system as an ATA drive.
    Testing MTD users (eg JFFS2) on large media and media that might
    be removed during a write (using the floppy drive).

Cirrus CDB89712 evaluation board mappings
CONFIG_MTD_CDB89712
  This enables access to the flash or ROM chips on the CDB89712 board.
  If you have such a board, say 'Y'.

Detect non-CFI AMD/JEDEC-compatible flash chips
CONFIG_MTD_JEDECPROBE
  This option enables JEDEC-style probing of flash chips which are not
  compatible with the Common Flash Interface, but will use the common
  CFI-targetted flash drivers for any chips which are identified which
  are in fact compatible in all but the probe method. This actually 
  covers most AMD/Fujitsu-compatible chips, and will shortly cover also
  non-CFI Intel chips (that code is in MTD CVS and should shortly be sent
  for inclusion in Linus' tree)

BIOS flash chip on Intel L440GX boards
CONFIG_MTD_L440GX
  Support for treating the BIOS flash chip on Intel L440GX motherboards
  as an MTD device - with this you can reprogram your BIOS.

  BE VERY CAREFUL.

28F160xx flash driver for LART
CONFIG_MTD_LART
  This enables the flash driver for LART. Please note that you do
  not need any mapping/chip driver for LART. This one does it all
  for you, so go disable all of those if you enabled some of them (:

Older (theoretically obsoleted now) drivers for non-CFI chips
CONFIG_MTD_OBSOLETE_CHIPS
  This option does not enable any code directly, but will allow you to 
  select some other chip drivers which are now considered obsolete,
  because the generic CONFIG_JEDEC_PROBE code above should now detect
  the chips which are supported by these drivers, and allow the generic
  CFI-compatible drivers to drive the chips. Say 'N' here unless you have
  already tried the CONFIG_JEDEC_PROBE method and reported its failure
  to the MTD mailing list at <linux-mtd@lists.infradead.org>

CFI Flash device mapped on Hitachi SolutionEngine
CONFIG_MTD_SOLUTIONENGINE
  This enables access to the flash chips on the Hitachi SolutionEngine and
  similar boards. Say 'Y' if you are building a kernel for such a board.

Flash chip mapping on TQM8xxL PPC board
CONFIG_MTD_TQM8XXL
  The TQM8xxL PowerPC board has up to two banks of CFI-compliant 
  chips, currently uses AMD one. This 'mapping' driver supports
  that arrangement, allowing the CFI probe and command set driver
  code to communicate with the chips on the TQM8xxL board. More at
  (http://www.denx.de/embedded-ppc-en.html).

Darkness
CONFIG_MEMORY_SET
  This is an option about which you will never be asked a question. 
  Therefore, I conclude that you do not exist - go away.

  Are you still here? Piss off, I tell you.

  There is a grue here.

Physical memory size
CONFIG_MEMORY_SIZE
  This sets the default memory size assumed by your SH kernel. It can 
  be overridden as normal by the 'mem=' argument on the kernel command
  line. If unsure, consult your board specifications or just leave it
  as 0x00400000 which was the default value before this became
  configurable.

CONFIG_SH_PCIDMA_NONCOHERENT
  Enable this option if your platform does not have a CPU cache which
  remains coherent with PCI DMA. It is safest to say 'Y', although you
  will see better performance if you can say 'N', because the PCI DMA 
  code will not have to flush the CPU's caches. If you have a PCI host
  bridge integrated with your SH CPU, refer carefully to the chip specs
  to see if you can say 'N' here. Otherwise, leave it as 'Y'.

--
dwmw2


