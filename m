Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTJSTTa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTJSTTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:19:30 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:12165
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262118AbTJSTTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:19:07 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: test8: assorted compilation warnings (VAIO and PPC)
Message-Id: <E1ABJ59-0003uw-00@penngrove.fdns.net>
Date: Sun, 19 Oct 2003 12:19:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are my current compilation warnings for vanilla 2.6.0-test8 for a
Sony VAIO R505EL and a PowerMac 8500.  Here are some approximate .config
file which should produce this warnings:

    VAIO R505EL		http://bugzilla.kernel.org/attachment.cgi?id=1090
    PowerMac 8500:	http://bugzilla.kernel.org/attachment.cgi?id=1092

I hope someone finds these useful. 

				-- JM

P.S.  And MANY thanks to those involved in cleaning up the kernel compilation 
output!!


Attachments:  Extracts from Sony VAIO R505EL compilation (i386)
	      Extracts from PowerMac 8500 compilation (PPC)
-------------------------------------------------------------------------------
cd /usr2/src/i386/linux-2.6.0-test8/
make
	...

  CC [M]  fs/smbfs/sock.o
  CC [M]  fs/smbfs/inode.o
fs/smbfs/inode.c: In function `smb_fill_super':
fs/smbfs/inode.c:554: warning: comparison is always false due to limited range of data type
fs/smbfs/inode.c:555: warning: comparison is always false due to limited range of data type
  CC [M]  fs/smbfs/file.o
	...

  CC [M]  drivers/cpufreq/freq_table.o
  CC [M]  drivers/ide/legacy/ide-cs.o
drivers/ide/legacy/ide-cs.c: In function `ide_config':
drivers/ide/legacy/ide-cs.c:365: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:482)
drivers/ide/legacy/ide-cs.c: In function `ide_release':
drivers/ide/legacy/ide-cs.c:411: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:494)
  CC      drivers/ide/pci/piix.o
	...

  CC [M]  net/irda/wrapper.o
  CC [M]  net/irda/af_irda.o
net/irda/af_irda.c: In function `irda_setsockopt':
net/irda/af_irda.c:1890: warning: comparison is always false due to limited range of data type
  CC [M]  net/irda/discovery.o
	...

  LD      vmlinux
  AS      arch/i386/boot/setup.o
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff
  LD      arch/i386/boot/setup
	...

-------------------------------------------------------------------------------
cd /usr2/src/ppc/linux-2.6.0-test8/
make
	...

  CC [M]  fs/ntfs/sysctl.o
  CC [M]  fs/ntfs/time.o
fs/ntfs/time.c: In function `ntfs2utc':
fs/ntfs/time.c:79: warning: comparison of distinct pointer types lacks a cast
  CC [M]  fs/ntfs/unistr.o
	...

  CC      drivers/block/swim3.o		[LOCALLY PATCHED as noted in Bug #1370]
drivers/block/swim3.c: In function `swim3_add_device':
drivers/block/swim3.c:1086: warning: passing arg 2 of `request_irq' from incompatible pointer type
drivers/block/swim3.c: At top level:
drivers/block/swim3.c:964: warning: `floppy_off' defined but not used
  LD      drivers/block/built-in.o
	...

  LD      drivers/misc/built-in.o
  CC      drivers/net/mace.o
drivers/net/mace.c: In function `mace_probe1':
drivers/net/mace.c:153: warning: `init_etherdev' is deprecated (declared at include/linux/etherdevice.h:44)
  CC      drivers/net/Space.o
	...

  LD      drivers/scsi/scsi_mod.o
  CC      drivers/scsi/mesh.o
drivers/scsi/mesh.c: In function `data_goes_out':
drivers/scsi/mesh.c:1913: warning: enumeration value `DMA_BIDIRECTIONAL' not handled in switch
drivers/scsi/mesh.c:1913: warning: enumeration value `DMA_NONE' not handled in switch
  LD      drivers/scsi/sd_mod.o
  LD      drivers/scsi/built-in.o
  CC [M]  drivers/scsi/mac53c94.o
drivers/scsi/mac53c94.c: In function `mac53c94_detect':
drivers/scsi/mac53c94.c:126: warning: passing arg 1 of `iounmap' discards qualifiers from pointer target type
drivers/scsi/mac53c94.c:128: warning: passing arg 1 of `iounmap' discards qualifiers from pointer target type
drivers/scsi/mac53c94.c:164: warning: passing arg 1 of `iounmap' discards qualifiers from pointer target type
drivers/scsi/mac53c94.c:165: warning: passing arg 1 of `iounmap' discards qualifiers from pointer target type
drivers/scsi/mac53c94.c: In function `data_goes_out':
drivers/scsi/mac53c94.c:576: warning: enumeration value `DMA_BIDIRECTIONAL' not handled in switch
drivers/scsi/mac53c94.c:576: warning: enumeration value `DMA_NONE' not handled in switch
  CC [M]  drivers/scsi/st.o
	...

  LD      drivers/video/console/built-in.o
  CC      drivers/video/logo/logo.o
/usr2/src/ppc/linux-2.6.0-test8/scripts/pnmtologo -t vga16 -n logo_linux_vga16 -o drivers/video/logo/logo_linux_vga16.c drivers/video/logo/logo_linux_vga16.ppm
  CC      drivers/video/logo/logo_linux_vga16.o
	...

  CC [M]  sound/oss/dmasound/dmasound_core.o
  CC [M]  sound/oss/dmasound/dmasound_awacs.o
sound/oss/dmasound/dmasound_awacs.c:188: warning: `beep_wform' defined but not used
sound/oss/dmasound/dmasound_awacs.c:288: warning: `awacs_mksound' declared `static' but never defined
sound/oss/dmasound/dmasound_awacs.c:1283: warning: `beep_timer' defined but not used
  CC [M]  sound/oss/dmasound/trans_16.o
  CC [M]  sound/oss/dmasound/dac3550a.o
  CC [M]  sound/oss/dmasound/tas_common.o
  CC [M]  sound/oss/dmasound/tas3001c.o
sound/oss/dmasound/tas3001c.c:162: warning: `tas3001c_read_register' defined but not used
  CC [M]  sound/oss/dmasound/tas3001c_tables.o
  CC [M]  sound/oss/dmasound/tas3004.o
sound/oss/dmasound/tas3004.c:332: warning: `tas3004_read_register' defined but not used
  CC [M]  sound/oss/dmasound/tas3004_tables.o
	...

  LD      sound/ppc/built-in.o
  CC [M]  sound/ppc/powermac.o
sound/ppc/powermac.c:39: warning: `enable' defined but not used
  CC [M]  sound/ppc/pmac.o
	...

===============================================================================
