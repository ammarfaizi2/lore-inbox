Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265814AbTF3D7G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 23:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbTF3D7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 23:59:03 -0400
Received: from adsl-202-72-179-2.std.westnet.com.au ([202.72.179.2]:27665 "EHLO
	gw.computerdatasafe.com.au") by vger.kernel.org with ESMTP
	id S265758AbTF3D5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 23:57:01 -0400
Date: Mon, 30 Jun 2003 11:01:35 +0800 (WST)
From: summer@computerdatasafe.com.au
To: linux-fbdev-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Problem building kernel 2.4.20
Message-ID: <Pine.LNX.4.44.0306301056490.17002-100000@gw.computerdatasafe.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this error trying to build this kernel. I'm showing the entire
output so you can see the commandline used to build.


summer@Numbat:/tmp/linux-2.4.20$ time make -s  clean dep bzImage
md5sum: can't open hfc_pci.
md5sum: can't open hfc_pci
init/do_mounts.c: In function `rd_load_image':
init/do_mounts.c:597: warning: int format, long int arg (arg 3)
init/do_mounts.c:624: warning: int format, long int arg (arg 3)
init/do_mounts.c:627: warning: int format, long int arg (arg 2)
init/do_mounts.c:639: warning: int format, long int arg (arg 2)
evevent.c: In function `acpi_ev_gpe_dispatch':
evevent.c:803: warning: cast to pointer from integer of different size
sm_osl.c: In function `sm_osl_suspend':
sm_osl.c:671: warning: unused variable `wakeup_address'
tz.c: In function `tz_add_device':
tz.c:336: warning: unused variable `tmp_handle'
tz_osl.c: In function `tz_osl_proc_read_info':
tz_osl.c:76: warning: unused variable `t'
tz_osl.c:70: warning: unused variable `buffer'
tz_osl.c:68: warning: unused variable `status'
tz_osl.c: In function `tz_osl_proc_write_info':
tz_osl.c:152: warning: unused variable `state'
tzpolicy.c: In function `tz_policy_add_device':
tzpolicy.c:489: warning: unused variable `j'
tzpolicy.c:488: warning: unused variable `thresholds'
agpgart_be.c: In function `agp_generic_create_gatt_table':
agpgart_be.c:591: warning: assignment from incompatible pointer type
dmi_scan.c: In function `dmi_decode':
dmi_scan.c:845: warning: unused variable `data'
{standard input}: Assembler messages:
{standard input}:1058: Warning: indirect lcall without `*'
{standard input}:1145: Warning: indirect lcall without `*'
{standard input}:1236: Warning: indirect lcall without `*'
{standard input}:1308: Warning: indirect lcall without `*'
{standard input}:1319: Warning: indirect lcall without `*'
{standard input}:1330: Warning: indirect lcall without `*'
{standard input}:1407: Warning: indirect lcall without `*'
{standard input}:1419: Warning: indirect lcall without `*'
{standard input}:1431: Warning: indirect lcall without `*'
{standard input}:1941: Warning: indirect lcall without `*'
{standard input}:2037: Warning: indirect lcall without `*'
{standard input}: Assembler messages:
{standard input}:237: Warning: indirect lcall without `*'
{standard input}:332: Warning: indirect lcall without `*'
drivers/char/drm/drm.o(.text+0x65f5): In function `sis_fb_alloc':
: undefined reference to `sis_malloc'
drivers/char/drm/drm.o(.text+0x663c): In function `sis_fb_alloc':
: undefined reference to `sis_free'
drivers/char/drm/drm.o(.text+0x6732): In function `sis_fb_free':
: undefined reference to `sis_free'
drivers/char/drm/drm.o(.text+0x6b96): In function `sis_final_context':
: undefined reference to `sis_free'
make: *** [vmlinux] Error 1

real    2m51.015s
user    2m33.030s
sys     0m13.870s
summer@Numbat:/tmp/linux-2.4.20$ 


Here is the configuration:
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_M586TSC=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_CMBATT=y
CONFIG_ACPI_THERMAL=y
CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP=y
CONFIG_AGP_SIS=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_SIS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y




-- 


Cheers
John.

Join the "Linux Support by Small Businesses" list at 
http://mail.computerdatasafe.com.au/mailman/listinfo/lssb


