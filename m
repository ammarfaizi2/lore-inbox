Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130386AbRCTPOt>; Tue, 20 Mar 2001 10:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130384AbRCTPOk>; Tue, 20 Mar 2001 10:14:40 -0500
Received: from tiger.bioinf.cs.uni-potsdam.de ([141.89.194.22]:22152 "EHLO
	tiger.bioinf.cs.uni-potsdam.de") by vger.kernel.org with ESMTP
	id <S130383AbRCTPOU>; Tue, 20 Mar 2001 10:14:20 -0500
Message-ID: <3AB77397.6050902@rz.uni-potsdam.de>
Date: Tue, 20 Mar 2001 16:13:27 +0100
From: "Juergen Rose,K17,0331-9772437,030-2425483" <rose@rz.uni-potsdam.de>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: modules_install does not install acpi with linux-2.4.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

if I try 'make modules_install' with linux-2.4.2 I get:

...
make[1]: Entering directory `/usr/src_laptop450/linux-2.4.2/drivers'
make -C acpi modules_install
make[2]: Entering directory `/usr/src_laptop450/linux-2.4.2/drivers/acpi'
mkdir -p /lib/modules/2.4.2/kernel/drivers/acpi/
cp common.o dispatcher.o events.o hardware.o interpreter.o namespace.o 
parser.o resources.o tables.o os.o acpi_ksyms.o driver.o cmbatt.o cpu.o 
ec.o acpi_ksyms.o sys.o table.o power.o 
/lib/modules/2.4.2/kernel/drivers/acpi/
cp: common.o: No such file or directory
cp: dispatcher.o: No such file or directory
cp: events.o: No such file or directory
cp: hardware.o: No such file or directory
cp: interpreter.o: No such file or directory
cp: namespace.o: No such file or directory
cp: parser.o: No such file or directory
cp: resources.o: No such file or directory
cp: tables.o: No such file or directory
make[2]: *** [_modinst__] Error 1
make[2]: Leaving directory `/usr/src_laptop450/linux-2.4.2/drivers/acpi'

Indeed I don't have such files in the drivers/acpi-Directory.
laptop450:/usr/src/linux(114)#ls drivers/acpi/
Makefile      acpi_ksyms.o  cmbatt.o  cpu.c  dispatcher/  driver.h  
ec.c  ec.o     hardware/  interpreter/  os.c  parser/  power.o     
sys.c  table.c  tables/
acpi_ksyms.c  cmbatt.c      common/   cpu.o  driver.c     driver.o  
ec.h  events/  include/   namespace/    os.o  power.c  resources/  
sys.o  table.o

My tools should be new enough to work correctly:
laptop450:/usr/src/linux(133)#sh 
/data_tiger/SRC/linux-2.4.1/scripts/ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux laptop450 2.4.0-test7 #1 Fri Aug 18 23:29:02 CEST 2000 i686 unknown
Kernel modules         2.4.3
Gnu C                  2.95.2
Gnu Make               3.79
Binutils               2.10.0.33
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.2
Mount                  2.10k
Net-tools              1.52
Kbd                    0.99
Sh-utils               1.16
Modules Loaded         autofs serial_cb tulip_cb cb_enabler ds i82365 
pcmcia_core maestro soundcore apm ppp_generic slip input usb-uhci 
usbcore nls_cp437 vfat nls_iso8859-1 ntfs

In .config I find with respect to ACPI only
CONFIG_ACPI=m

Who can help me?

With best regards
       Juergen

