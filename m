Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUDRSRS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 14:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbUDRSRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 14:17:18 -0400
Received: from ethlife-b.ethz.ch ([129.132.202.8]:52438 "HELO ethlife.ethz.ch")
	by vger.kernel.org with SMTP id S262215AbUDRSRN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 14:17:13 -0400
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: Sun, 18 Apr 2004 20:17 +0200
Subject: (2.6.5 compile warnings on ppc)
To: linux-kernel@vger.kernel.org
From: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Content-Transfer-Encoding: 7BIT
Message-Id: <S262215AbUDRSRN/20040418181713Z+3122@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case anybody cares, these are the compile warnings when compiling
kernel.org's 2.6.5 on woody with 2.6.5-rc3-ben0-pmdisk.diff (which is
a rather small patch) and
http://linux.bkbits.net:8080/linux-2.5/patch@1.1757?nav=index.html|src/.|src/drivers|src/drivers/macintosh|related/drivers/macintosh/macserial.c|cset@1.1757
(very small) applied.

(So far the kernel works w/o problems apart from a pmdisk related
sound freezing.)

Cheers
Christian.


<warnings>

arch/ppc/platforms/pmac_setup.c: In function `pmac_pm_enter':
arch/ppc/platforms/pmac_setup.c:456: warning: implicit declaration of function `enable_kernel_altivec'

arch/ppc/platforms/pmac_feature.c: In function `heathrow_modem_enable':
arch/ppc/platforms/pmac_feature.c:348: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:359: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:365: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:368: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:371: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c: In function `core99_modem_enable':
arch/ppc/platforms/pmac_feature.c:752: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:759: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:768: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:771: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:774: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c: In function `pangea_modem_enable':
arch/ppc/platforms/pmac_feature.c:805: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:813: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:823: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:826: warning: integer overflow in expression
arch/ppc/platforms/pmac_feature.c:829: warning: integer overflow in expression

arch/ppc/platforms/pmac_nvram.c: In function `core99_nvram_sync':
arch/ppc/platforms/pmac_nvram.c:466: warning: integer overflow in expression

kernel/panic.c: In function `panic':
kernel/panic.c:87: warning: integer overflow in expression

kernel/power/disk.c: In function `power_down':
kernel/power/disk.c:58: warning: implicit declaration of function `device_shutdown'

fs/smbfs/file.c: In function `smb_file_sendfile':
fs/smbfs/file.c:272: warning: unknown conversion type character `z' in format
fs/smbfs/file.c:272: warning: too many arguments for format

drivers/macintosh/via-pmu.c: In function `powerbook_sleep_grackle':
drivers/macintosh/via-pmu.c:2488: warning: integer overflow in expression
drivers/macintosh/via-pmu.c: In function `powerbook_sleep_Core99':
drivers/macintosh/via-pmu.c:2580: warning: integer overflow in expression

drivers/macintosh/macserial.c: In function `rs_tiocmset':
drivers/macintosh/macserial.c:1819: warning: unused variable `bits'
drivers/macintosh/macserial.c:1819: warning: unused variable `arg'

drivers/scsi/aic7xxx_old.c: In function `aic7xxx_reset_current_bus':
drivers/scsi/aic7xxx_old.c:3508: warning: integer overflow in expression

drivers/scsi/sym53c8xx_2/sym_fw.c: In function `sym_fw_bind_script':
drivers/scsi/sym53c8xx_2/sym_fw.c:414: warning: integer overflow in expression
drivers/scsi/sym53c8xx_2/sym_fw.c:458: warning: integer overflow in expression

drivers/usb/media/pwc-if.c: In function `pwc_video_release':
drivers/usb/media/pwc-if.c:1124: warning: control reaches end of non-void function
drivers/usb/media/pwc-if.c: In function `usb_pwc_probe':
drivers/usb/media/pwc-if.c:1855: warning: assignment from incompatible pointer type

drivers/usb/media/w9968cf.c: In function `w9968cf_urb_complete':
drivers/usb/media/w9968cf.c:823: warning: unknown conversion type character `z' in format
drivers/usb/media/w9968cf.c:823: warning: too many arguments for format
...
drivers/usb/media/w9968cf.c: In function `w9968cf_pop_frame':
drivers/usb/media/w9968cf.c:2078: warning: unknown conversion type character `z' in format
drivers/usb/media/w9968cf.c:2078: warning: too many arguments for format
...
drivers/usb/media/w9968cf.c: In function `w9968cf_read':
drivers/usb/media/w9968cf.c:2833: warning: unknown conversion type character `z' in format
drivers/usb/media/w9968cf.c:2833: warning: too many arguments for format
...
...

drivers/usb/storage/freecom.c: In function `freecom_init':
drivers/usb/storage/freecom.c:410: warning: integer overflow in expression
drivers/usb/storage/freecom.c:418: warning: integer overflow in expression

drivers/usb/storage/dpcm.c: In function `dpcm_transport':
drivers/usb/storage/dpcm.c:46: warning: unused variable `ret'

drivers/video/aty/atyfb_base.c: In function `aty_power_mgmt_LT':
drivers/video/aty/atyfb_base.c:1318: warning: integer overflow in expression

drivers/video/aty/radeon_pm.c: In function `radeon_set_suspend':
drivers/video/aty/radeon_pm.c:818: warning: integer overflow in expression
drivers/video/aty/radeon_pm.c:824: warning: integer overflow in expression
drivers/video/aty/radeon_pm.c:824: warning: integer overflow in expression
drivers/video/aty/radeon_pm.c:826: warning: integer overflow in expression

drivers/video/matrox/matroxfb_base.c:120: warning: `default_vmode' defined but not used
drivers/video/matrox/matroxfb_base.c:121: warning: `default_cmode' defined but not used
drivers/video/matrox/matroxfb_base.c:1250: warning: `inverse' defined but not used

sound/oss/dmasound/tas3001c.c:162: warning: `tas3001c_read_register' defined but not used

sound/oss/dmasound/tas3004.c:330: warning: `tas3004_read_register' defined but not used

In file included from include/linux/elf.h:5,
                 from arch/ppc/boot/simple/misc.c:20:
include/asm/elf.h:102: warning: `struct task_struct' declared inside parameter list
include/asm/elf.h:102: warning: its scope is only this definition or declaration, which is probably not what you want.

</warnings>

