Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267502AbRGMQiO>; Fri, 13 Jul 2001 12:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267503AbRGMQiC>; Fri, 13 Jul 2001 12:38:02 -0400
Received: from lh10.opsion.fr ([212.73.208.236]:5391 "HELO lh10.opsion.fr")
	by vger.kernel.org with SMTP id <S267502AbRGMQh4>;
	Fri, 13 Jul 2001 12:37:56 -0400
Message-ID: <3B4F2415.559A12D9@ifrance.com>
Date: Fri, 13 Jul 2001 18:38:45 +0200
From: Brunet Eric <rickos@ifrance.com>
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: eric.brunet@voila.fr
Subject: compile and bootdisk problems
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i meet some problems in order to create a linux bootdisk:
therefore, i tries to make a polyvalent kernel (in one floppy) with:
-no module
-a lot of ethernet card drivers
This flopppy disk will be used to boot windows machine with partimage
program in order to backup entire FS to a backup server!!

The first, i couldn't compile the kernel with all ethernets card
drivers, specially i have an errors for the drivers
"CONFIG_ARM_AM79C961A" and "CONFIG_FEALNX" for kernels 2.4.3 and 2.4.6(i
think others version too), is it normal??

For "CONFIG_ARM_AM79C961A":
am79c961a.c: In function `am79c961_init':
am79c961a.c:638: `IRQ_EBSA110_ETHERNET' undeclared (first use in this
function)
am79c961a.c:638: (Each undeclared identifier is reported only once
am79c961a.c:638: for each function it appears in.)
make[3]: *** [am79c961a.o] Erreur 1
make[2]: *** [first_rule] Erreur 2
make[1]: *** [_subdir_net] Erreur 2
make: *** [_dir_drivers] Erreur 2
notice: the definition of IRQ_EBSA110_ETHERNET is in ./include/asm_arm
# define IRQ_EBSA110_ETHERNET   3
I understand that device is supported only by arm architecure, it don't
compile because it's a x86 machine?? and if yes,why aren't anywarning
message to indicate me that drivers is useless????

For "CONFIG_FEALNX":
gcc -D__KERNEL__ -I/usr/src/linux-2.4.6/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686
-c -o fealnx.o fealnx.c
fealnx.c:1817: parse error before `__attribute__'
make[3]: *** [fealnx.o] Erreur 1
make[3]: Quitte le répertoire `/usr/src/linux-2.4.6/drivers/net'
make[2]: *** [first_rule] Erreur 2
make[2]: Quitte le répertoire `/usr/src/linux-2.4.6/drivers/net'
make[1]: *** [_subdir_net] Erreur 2
make[1]: Quitte le répertoire `/usr/src/linux-2.4.6/drivers'
make: *** [_dir_drivers] Erreur 2


-the other problem is in boot sequence, i prapre the kernel image for
the rootdisk(it work with a Slackware bootdisk) like this:
>   rdev bzImage /dev/fd0
>   rdev -r bzImage 49152 (49152 = ask disk, and read from 0)
>   rdev -R bzImage 0 (to make the root RW and allow to login)
>  dd if=bzImage of=/dev/fd0 bs=1k

howener then i insert root disk, 10 second oafter, i see this message:
>wrong magic
>MSDOS: Harware sector size is 1024
>fatfs: bogus cluster size
>MSDOS: Harware sector size is 1024
>fatfs: bogus cluster size
>MSDOS: Harware sector size is 1024
>fatfs: bogus cluster size
>UMSDOS: msdos_read_super failed, mount aborted.
>kernel panic: VFS: Unable to mount fs on 01:00

I read many FAQ, ML and bootdisk HOWTO(of course) wtihout response

please help me :~(
:))I

thank in advance for your response


 
______________________________________________________________________________
ifrance.com, l'email gratuit le plus complet de l'Internet !
vos emails depuis un navigateur, en POP3, sur Minitel, sur le WAP...
http://www.ifrance.com/_reloc/email.emailif


