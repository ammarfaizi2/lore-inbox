Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262421AbSJDQYP>; Fri, 4 Oct 2002 12:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262422AbSJDQYP>; Fri, 4 Oct 2002 12:24:15 -0400
Received: from fep01.tuttopmi.it ([212.131.248.100]:21724 "EHLO
	fep01-svc.flexmail.it") by vger.kernel.org with ESMTP
	id <S262421AbSJDQYN> convert rfc822-to-8bit; Fri, 4 Oct 2002 12:24:13 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Frederik Nosi <fredi@e-salute.it>
Reply-To: fredi@e-salute.it
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre9: kbuild strangeness
Date: Fri, 4 Oct 2002 18:39:45 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041839.45319.fredi@e-salute.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I followed the usual steps:

patched the kernel to 2.4.20-p9
make mrproper, make oldconfig, make dep, make bzImage, make modules

During kernel/modules building I get no errors, only this warnings:

agpgart_be.c: In function `agp_generic_create_gatt_table':
agpgart_be.c:591: warning: assignment from incompatible pointer type
Loading defkeymap.map
base.c: In function `devfsd_ioctl':
base.c:3433: warning: unused variable `lock'
{standard input}: Assembler messages:
{standard input}:1018: Warning: indirect lcall without `*'
{standard input}:1102: Warning: indirect lcall without `*'
{standard input}:1186: Warning: indirect lcall without `*'
{standard input}:1255: Warning: indirect lcall without `*'
{standard input}:1266: Warning: indirect lcall without `*'
{standard input}:1277: Warning: indirect lcall without `*'
{standard input}:1350: Warning: indirect lcall without `*'
{standard input}:1361: Warning: indirect lcall without `*'
{standard input}:1372: Warning: indirect lcall without `*'
{standard input}:1853: Warning: indirect lcall without `*'
{standard input}:1953: Warning: indirect lcall without `*'
{standard input}: Assembler messages:
{standard input}:245: Warning: indirect lcall without `*'
{standard input}:339: Warning: indirect lcall without `*'
bbootsect.s: Assembler messages:
bbootsect.s:256: Warning: indirect lcall without `*'
bsetup.s: Assembler messages:
bsetup.s:1512: Warning: indirect lcall without `*'
Root device is (3, 6)
Boot sector 512 bytes.
Setup is 4772 bytes.
System is 822 kB
make: *** No rule to make target `make'.  Stop.

During make modules_install I get this:

make -C  kernel modules_install
make[1]: Entering directory `/home/fredi/src/linux-2.4.20-pre9/kernel'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/home/fredi/src/linux-2.4.20-pre9/kernel'
make -C  drivers modules_install
make[1]: Entering directory `/home/fredi/src/linux-2.4.20-pre9/drivers'
make -C block modules_install
make[2]: Entering directory `/home/fredi/src/linux-2.4.20-pre9/drivers/block'
mkdir -p /lib/modules/2.4.20-pre9/kernel/drivers/block/
cp loop.o nbd.o /lib/modules/2.4.20-pre9/kernel/drivers/block/
cp: impossibile fare stat di `loop.o': No such file or directory
cp: impossibile fare stat di `nbd.o': No such file or directory
make[2]: *** [_modinst__] Error 1
make[2]: Leaving directory `/home/fredi/src/linux-2.4.20-pre9/drivers/block'
make[1]: *** [_modinst_block] Error 2
make[1]: Leaving directory `/home/fredi/src/linux-2.4.20-pre9/drivers'
make: *** [_modinst_drivers] Error 2

Hope this is useful.
For more info please CC me, I'm not subscribed in the list


cheers,
Frederik Nosi
