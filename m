Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132760AbRDDHKh>; Wed, 4 Apr 2001 03:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132759AbRDDHK1>; Wed, 4 Apr 2001 03:10:27 -0400
Received: from dexter.allieddomecq.ro ([212.93.128.30]:19724 "HELO
	mail.allieddomecq.ro") by vger.kernel.org with SMTP
	id <S132758AbRDDHKX>; Wed, 4 Apr 2001 03:10:23 -0400
Date: Wed, 4 Apr 2001 09:11:03 +0300 (EEST)
From: Robert-Velisav MICIOVICI <roby@dexter.allieddomecq.ro>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 2.4.3 vanilla: errors building modules 
In-Reply-To: <27525795B28BD311B28D00500481B7601F113E@ftrs1.intranet.ftr.nl>
Message-ID: <Pine.LNX.4.21md.0104031328390.11343-100000@dexter.allieddomecq.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Errors building the following:

1)

gcc -D__KERNEL__ -I/usr/src/linux-2.4.3/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=athlon  -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.3/include/linux/modversions.h   -c -o buz.o
buz.c
buz.c: In function ^V4l_fbuffer_alloc':
buz.c:188: ^KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:188: (Each undeclared identifier is reported only once
buz.c:188: for each function it appears in.)
buz.c: In function
pg_fbuffer_alloc':
buz.c:262: ^KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:256: warning: ^Alloc_contig' might be used uninitialized in this
function
buz.c: In function
pg_fbuffer_free':
buz.c:322: ^KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:316: warning: ^Alloc_contig' might be used uninitialized in this
function
buz.c: In function ^Zoran_ioctl':
buz.c:2837: ^KMALLOC_MAXSIZE' undeclared (first use in this function)
make[3]: *** [buz.o] Error 1
make[3]: Leaving directory /usr/src/linux-2.4.3/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory /usr/src/linux-2.4.3/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory /usr/src/linux-2.4.3/drivers'
make: *** [_mod_drivers] Error 2
[root@t linux-2.4.3]#


2) 

gcc -D__KERNEL__ -I/usr/src/linux-2.4.3/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=athlon  -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.3/include/linux/modversions.h   -c -o dscc4.o
dscc4.c
dscc4.c:1745: `PCI_VENDOR_ID_SIEMENS' undeclared here (not in a function)
dscc4.c:1745: initializer element is not constant
dscc4.c:1745: (near initialization for `dscc4_pci_tbl[0].vendor')
dscc4.c:1745: `PCI_DEVICE_ID_SIEMENS_DSCC4' undeclared here (not in a
function)
dscc4.c:1745: initializer element is not constant
dscc4.c:1745: (near initialization for `dscc4_pci_tbl[0].device')
make[3]: *** [dscc4.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.3/drivers/net/wan'
make[2]: *** [_modsubdir_wan] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.3/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.3/drivers'
make: *** [_mod_drivers] Error 2
[root@t linux-2.4.3]#


3)


gcc -D__KERNEL__ -I/usr/src/linux-2.4.3/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=athlon  -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.3/include/linux/modversions.h   -c -o 6pack.o
6pack.c
6pack.c: In function `sixpack_init_driver':
6pack.c:714: `KMALLOC_MAXSIZE' undeclared (first use in this function)
6pack.c:714: (Each undeclared identifier is reported only once
6pack.c:714: for each function it appears in.)
make[2]: *** [6pack.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.3/drivers/net/hamradio'
make[1]: *** [_modsubdir_net/hamradio] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.3/drivers'
make: *** [_mod_drivers] Error 2
[root@t linux-2.4.3]#


4)


gcc -D__KERNEL__ -I/usr/src/linux-2.4.3/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=athlon  -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.3/include/linux/modversions.h   -c -o
aedsp16.o aedsp16.c
aedsp16.c:260:23: warning: extra tokens at end of #undef directive
aedsp16.c:261:28: warning: extra tokens at end of #undef directive
aedsp16.c:262:23: warning: extra tokens at end of #undef directive
make[2]: *** No rule to make target `/etc/sound/dsp001.ld', needed by
`pss_boot.h'.  Stop.
make[2]: Leaving directory `/usr/src/linux-2.4.3/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.3/drivers'
make: *** [_mod_drivers] Error 2
[root@t linux-2.4.3]#

5)

And this patch to enable compilation of IPX into the core

change
net/ipx/af_ipx.c line 126 from:
- static int sysctl_ipx_pprop_broadcasting = 1;
to:
+ int sysctl_ipx_pprop_broadcasting = 1;

