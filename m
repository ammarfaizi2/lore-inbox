Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbRHAIki>; Wed, 1 Aug 2001 04:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265101AbRHAIkT>; Wed, 1 Aug 2001 04:40:19 -0400
Received: from [195.66.192.167] ([195.66.192.167]:4114 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264932AbRHAIkQ>; Wed, 1 Aug 2001 04:40:16 -0400
Date: Wed, 1 Aug 2001 11:42:48 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <711915834.20010801114248@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Compile-time warnings/errors (gcc 2.95.3 kernel 2.4.5)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Warnings from (almost) full kernel compilation
(most thing are compiled as modules)
There is one compile-time error in ixj.c

Please feel free to mail me whether this post to lkml
is useful at all.

gcc version: 2.95.3
gcc flags:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.5/include
    -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
    -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
    -march=i586
gcc flags for modules:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.5/include
    -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
    -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
    -march=i586
    -DMODULE -DMODVERSIONS
    -include /usr/src/linux-2.4.5/include/linux/modversions.h
    -c -o file.o file.c
These flags are removed from gcc lines below to unclutter things.
Sorry but I lost directory names for *.c files...
--------------------
gcc  -o ixj.o ixj.c
ixj.c: In function `ixj_probe_isa':
ixj.c:6422: `dspio' undeclared (first use in this function)
ixj.c:6422: (Each undeclared identifier is reported only once
ixj.c:6422: for each function it appears in.)
ixj.c:6440: `xio' undeclared (first use in this function)
make[2]: *** [ixj.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.5/drivers/telephony'
make[1]: *** [_modsubdir_telephony] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.5/drivers'
make: *** [_mod_drivers] Error 2

gcc  -o super.o super.c
super.c:385: warning: `move_vfsmnt' defined but not used

gcc  -o pci-pc.o pci-pc.c
{standard input}: Assembler messages:
{standard input}:763: Warning: indirect lcall without `*'
{standard input}:850: Warning: indirect lcall without `*'
{standard input}:941: Warning: indirect lcall without `*'
{standard input}:982: Warning: indirect lcall without `*'
{standard input}:1015: Warning: indirect lcall without `*'
{standard input}:1048: Warning: indirect lcall without `*'
{standard input}:1080: Warning: indirect lcall without `*'
{standard input}:1110: Warning: indirect lcall without `*'
{standard input}:1140: Warning: indirect lcall without `*'
{standard input}:1428: Warning: indirect lcall without `*'
{standard input}:1524: Warning: indirect lcall without `*'

gcc  -o reg_add_sub.o reg_add_sub.c
reg_add_sub.c: In function `FPU_sub':
reg_add_sub.c:143: warning: `tag' might be used uninitialized in this function

gcc  -o reg_compare.o reg_compare.c
reg_compare.c: In function `FPU_compare_st_data':
reg_compare.c:177: warning: `f' might be used uninitialized in this function
reg_compare.c: In function `compare_st_st':
reg_compare.c:219: warning: `f' might be used uninitialized in this function
reg_compare.c: In function `compare_u_st_st':
reg_compare.c:271: warning: `f' might be used uninitialized in this function

gcc  -o reg_ld_str.o reg_ld_str.c
reg_ld_str.c: In function `FPU_store_single':
reg_ld_str.c:635: warning: `templ' might be used uninitialized in this function

gcc  -o reg_divide.o reg_divide.c
reg_divide.c: In function `FPU_div':
reg_divide.c:206: warning: control reaches end of non-void function

gcc  -o reg_mul.o reg_mul.c
reg_mul.c: In function `FPU_mul':
reg_mul.c:131: warning: control reaches end of non-void function

gcc ..<nonstandard flags>..  bootsect.S -o bbootsect.s
as -o bbootsect.o bbootsect.s
bbootsect.s: Assembler messages:
bbootsect.s:253: Warning: indirect lcall without `*'

as -o bsetup.o bsetup.s
bsetup.s: Assembler messages:
bsetup.s:1782: Warning: indirect lcall without `*'

gcc  -o bpck6.o bpck6.c
In file included from bpck6.c:39:
ppc6lnx.c: In function `ppc6_rd_data_byte':
ppc6lnx.c:307: warning: `data' might be used uninitialized in this function
bpck6.c: At top level:
ppc6lnx.c:397: warning: `ppc6_rd_reg' defined but not used
ppc6lnx.c:406: warning: `ppc6_wr_reg' defined but not used
ppc6lnx.c:415: warning: `ppc6_version' defined but not used
ppc6lnx.c:712: warning: `ppc6_rd_port16' defined but not used
ppc6lnx.c:733: warning: `ppc6_wr_port16' defined but not used
ppc6lnx.c:788: warning: `ppc6_eeprom_start' defined but not used
ppc6lnx.c:795: warning: `ppc6_eeprom_end' defined but not used
ppc6lnx.c:828: warning: `ppc6_eeprom_ready_wait' defined but not used
ppc6lnx.c:863: warning: `ppc6_eeprom_read' defined but not used
ppc6lnx.c:894: warning: `ppc6_irq_test' defined but not used
ppc6lnx.c:903: warning: `ppc6_rd_extout' defined but not used
bpck6.c:295: warning: `init_module' defined but not used

gcc  -o rds-miropcm20.o rds-miropcm20.c
rds-miropcm20.c:39: warning: `print_matrix' defined but not used

gcc  -o mdacon.o mdacon.c
mdacon.c:133: warning: `test_mda_b' defined but not used

gcc  -o tdfxfb.o tdfxfb.c
tdfxfb.c: In function `tdfxfb_init':
tdfxfb.c:1895: warning: `name' might be used uninitialized in this function

gcc  -o inode.o inode.c
inode.c:198: warning: `ncp_symlink_inode_operations' defined but not used

gcc  -finline-functions -o ncplib_kernel.o ncplib_kernel.c
ncplib_kernel.c:61: warning: `ncp_add_mem_fromfs' defined but not used

gcc  -o af_econet.o af_econet.c
af_econet.c: In function `econet_sendmsg':
af_econet.c:243: warning: unused variable `eb'
af_econet.c:242: warning: unused variable `skb'
af_econet.c: At top level:
af_econet.c:193: warning: `tx_result' defined but not used
af_econet.c:732: warning: `ec_listening_socket' defined but not used
af_econet.c:756: warning: `ec_queue_packet' defined but not used

gcc  -o iriap.o iriap.c
iriap.c:44: warning: `ias_charset_types' defined but not used

gcc  -o irlmp_event.o irlmp_event.c
irlmp_event.c:51: warning: `irlmp_event' defined but not used

gcc  -o irlap.o irlap.c
irlap.c:57: warning: `lap_reasons' defined but not used

gcc  -o irlap_event.o irlap_event.c
irlap_event.c: In function `irlap_state_ndm':
irlap_event.c:332: warning: unused variable `i'
irlap_event.c: At top level:
irlap_event.c:79: warning: `irlap_event' defined but not used

gcc  -o irda_device.o irda_device.c
irda_device.c:81: warning: `task_state' defined but not used

gcc  -DEXPORT_SYMTAB -c irsyms.c
irsyms.c:222: warning: `irda_cleanup' defined but not used

gcc  -o irnet_irda.o irnet_irda.c
irnet_irda.c: In function `irnet_status_indication':
irnet_irda.c:1084: warning: unused variable `oldflow'


CC me. I'm not on the list.
-- 
Best regards,
 VDA                          mailto:VDA@port.imtp.ilyichevsk.odessa.ua


