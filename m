Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLEXBm>; Tue, 5 Dec 2000 18:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLEXBc>; Tue, 5 Dec 2000 18:01:32 -0500
Received: from postfix1.free.fr ([212.27.32.21]:47623 "HELO postfix1.free.fr")
	by vger.kernel.org with SMTP id <S129210AbQLEXBW>;
	Tue, 5 Dec 2000 18:01:22 -0500
Message-ID: <3A2D6C6E.5AC72B26@free.fr>
Date: Tue, 05 Dec 2000 23:30:06 +0100
From: Delaporte Frédéric 
	<fredericdelaporte@free.fr>
X-Mailer: Mozilla 4.7 [fr] (X11; I; Linux 2.2.14-15mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug Report : make modules_install seems to do a wrong call to depmod, 
 using an unknow option "-F".
Content-Type: multipart/mixed;
 boundary="------------17B051F536D3B5BD8B270CE6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il s'agit d'un message multivolet au format MIME.
--------------17B051F536D3B5BD8B270CE6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello.

make modules_install seems to do a wrong call to depmod, using an unknow
option "-F".

The line concerned in the Makefile is the 376th, colonne 47, character
44. Replacing "-F" by "-m" seems to solve the trouble (I've trust the
depmod's man page).

Here is this line :
    if [ -r System.map ]; then $(DEPMOD) -ae -F System.map
$(depmod_opts) $(KERNELRELEASE); fi

I've join the output of make (file makeModules_installOutput).

Since this problem is probably very simple, I've not followed the format
of normal bug reports...

I've hope this problem has not been report to you thousands of time !

Good bye.

--------------17B051F536D3B5BD8B270CE6
Content-Type: text/plain; charset=us-ascii;
 name="makeModules_installOutput"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="makeModules_installOutput"

 make modules_install
make -C  kernel modules_install
make[1]: Entering directory `/usr/src/linux-2.4.0-test11/kernel'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11/kernel'
make -C  drivers modules_install
make[1]: Entering directory `/usr/src/linux-2.4.0-test11/drivers'
make -C acpi modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/acpi'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/acpi'
make -C block modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/block'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/block'
make -C cdrom modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/cdrom'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/cdrom'
make -C char modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/char'
make -C agp modules_install
make[3]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/char/agp'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/char/agp'
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/char'
make -C ide modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/ide'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/ide'
make -C media modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/media'
make -C video modules_install
make[3]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/media/video'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/media/video'
make -C radio modules_install
make[3]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/media/radio'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/media/radio'
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/media'
make -C misc modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/misc'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/misc'
make -C net modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/net'
mkdir -p /lib/modules/2.4.0-test11/kernel/drivers/net/
cp  dummy.o /lib/modules/2.4.0-test11/kernel/drivers/net/
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/net'
make -C parport modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/parport'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/parport'
make -C pnp modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/pnp'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/pnp'
make -C sound modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/sound'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/sound'
make -C usb modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/usb'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/usb'
make -C video modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/drivers/video'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers/video'
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11/drivers'
make -C  mm modules_install
make[1]: Entering directory `/usr/src/linux-2.4.0-test11/mm'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11/mm'
make -C  fs modules_install
make[1]: Entering directory `/usr/src/linux-2.4.0-test11/fs'
make -C nls modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/fs/nls'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/fs/nls'
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11/fs'
make -C  net modules_install
make[1]: Entering directory `/usr/src/linux-2.4.0-test11/net'
make -C ipv4 modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/net/ipv4'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/net/ipv4'
make -C ipv6 modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/net/ipv6'
mkdir -p /lib/modules/2.4.0-test11/kernel/net/ipv6/
cp  ipv6.o /lib/modules/2.4.0-test11/kernel/net/ipv6/
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/net/ipv6'
make -C sched modules_install
make[2]: Entering directory `/usr/src/linux-2.4.0-test11/net/sched'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11/net/sched'
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11/net'
make -C  ipc modules_install
make[1]: Entering directory `/usr/src/linux-2.4.0-test11/ipc'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11/ipc'
make -C  lib modules_install
make[1]: Entering directory `/usr/src/linux-2.4.0-test11/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11/lib'
make -C  arch/i386/kernel modules_install
make[1]: Entering directory `/usr/src/linux-2.4.0-test11/arch/i386/kernel'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11/arch/i386/kernel'
make -C  arch/i386/mm modules_install
make[1]: Entering directory `/usr/src/linux-2.4.0-test11/arch/i386/mm'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11/arch/i386/mm'
make -C  arch/i386/lib modules_install
make[1]: Entering directory `/usr/src/linux-2.4.0-test11/arch/i386/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11/arch/i386/lib'
cd /lib/modules/2.4.0-test11; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.0-test11; fi
/sbin/depmod: option invalide -- F
Usage: depmod [-e -s -v ] -a [FORCED_KERNEL_VER]
       depmod [-e -s -v ] MODULE_1.o MODULE_2.o ...
Create module-dependency information for modprobe.

  -a, --all                  visit all modules
  -d, --debug                run in debug mode
  -e                         output unresolved symbols
  -i                         ignore symbol versions
  -m, --system-map <file>    use the symbols in <file>
  -s, --system-log           use the system log for error reporting
      --help                 display this help and exit
  -v, --verbose              run in verbose mode
  -V, --version              output version information and exit
make: *** [_modinst_post] Error 1
[root@localhost linux-2.4.0-test11]# 

--------------17B051F536D3B5BD8B270CE6
Content-Type: text/x-vcard; charset=us-ascii;
 name="fredericdelaporte.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Carte pour Delaporte Frédéric
Content-Disposition: attachment;
 filename="fredericdelaporte.vcf"

begin:vcard 
n:DELAPORTE;Frédéric
tel;home:02 41 81 01 18
x-mozilla-html:FALSE
org:ESEO;Génie Informatique, Réseau et Télécommunication (GIRT)
version:2.1
email;internet:fredericdelaporte@free.fr
title:Etudiant
adr;quoted-printable:;;25 RUE CELESTIN PORT,=0D=0AAppt 307;ANGERS;;49100;FRANCE
x-mozilla-cpt:;0
fn:Frédéric DELAPORTE
end:vcard

--------------17B051F536D3B5BD8B270CE6--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
