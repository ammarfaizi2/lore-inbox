Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbSJBXXr>; Wed, 2 Oct 2002 19:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbSJBXXr>; Wed, 2 Oct 2002 19:23:47 -0400
Received: from cp44749-a.roemd1.lb.home.nl ([217.121.99.54]:4350 "EHLO
	garion.edsons.demon.nl") by vger.kernel.org with ESMTP
	id <S262686AbSJBXXp>; Wed, 2 Oct 2002 19:23:45 -0400
Message-ID: <3D9B8247.4040502@edsons.demon.nl>
Date: Thu, 03 Oct 2002 01:33:27 +0200
From: Rudy Zijlstra <rudy@edsons.demon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: some more 2.5.40 module compile errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those interested:

aha152x driver:

  gcc -Wp,-MD,./.aha152x.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE  -DAHA152X_STAT -DAUTOCONF -DKBUILD_BASENAME=aha152x   
-c -o aha152x.o aha152x.c
drivers/scsi/aha152x.c: In function `intr':
drivers/scsi/aha152x.c:1944: warning: implicit declaration of function 
`queue_task'
drivers/scsi/aha152x.c:1944: `tq_immediate' undeclared (first use in 
this function)
drivers/scsi/aha152x.c:1944: (Each undeclared identifier is reported 
only once
drivers/scsi/aha152x.c:1944: for each function it appears in.)
drivers/scsi/aha152x.c:1945: warning: implicit declaration of function 
`mark_bh'
drivers/scsi/aha152x.c:1945: `IMMEDIATE_BH' undeclared (first use in 
this function)

the adaptec i20 driver also complains it needs to be converted according 
to Documentation/DMA-xxx

Then the irda driver:

make[3]: Entering directory `/usr/src/linux-2.5.40/net/irda/ircomm'
  gcc -Wp,-MD,./.ircomm_tty.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=ircomm_tty   -c -o ircomm_tty.o 
ircomm_tty.c
net/irda/ircomm/ircomm_tty.c: In function `ircomm_tty_flush_buffer':
net/irda/ircomm/ircomm_tty.c:635: warning: implicit declaration of 
function `queue_task'
net/irda/ircomm/ircomm_tty.c:635: `tq_immediate' undeclared (first use 
in this function)
net/irda/ircomm/ircomm_tty.c:635: (Each undeclared identifier is 
reported only once
net/irda/ircomm/ircomm_tty.c:635: for each function it appears in.)
net/irda/ircomm/ircomm_tty.c:636: warning: implicit declaration of 
function `mark_bh'
net/irda/ircomm/ircomm_tty.c:636: `IMMEDIATE_BH' undeclared (first use 
in this function)
net/irda/ircomm/ircomm_tty.c: In function `ircomm_tty_write':
net/irda/ircomm/ircomm_tty.c:809: `tq_immediate' undeclared (first use 
in this function)
net/irda/ircomm/ircomm_tty.c:810: `IMMEDIATE_BH' undeclared (first use 
in this function)
net/irda/ircomm/ircomm_tty.c: In function `ircomm_tty_check_modem_status':
net/irda/ircomm/ircomm_tty.c:1135: `tq_immediate' undeclared (first use 
in this function)
net/irda/ircomm/ircomm_tty.c:1136: `IMMEDIATE_BH' undeclared (first use 
in this function)
net/irda/ircomm/ircomm_tty.c: In function `ircomm_tty_flow_indication':
net/irda/ircomm/ircomm_tty.c:1249: `tq_immediate' undeclared (first use 
in this function)
net/irda/ircomm/ircomm_tty.c:1250: `IMMEDIATE_BH' undeclared (first use 
in this function)
  gcc -Wp,-MD,./.ircomm_tty_attach.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=ircomm_tty_attach   -c -o 
ircomm_tty_attach.o ircomm_tty_attach.c
net/irda/ircomm/ircomm_tty_attach.c: In function 
`ircomm_tty_link_established':
net/irda/ircomm/ircomm_tty_attach.c:538: warning: implicit declaration 
of function `queue_task'
net/irda/ircomm/ircomm_tty_attach.c:538: `tq_immediate' undeclared 
(first use in this function)
net/irda/ircomm/ircomm_tty_attach.c:538: (Each undeclared identifier is 
reported only once
net/irda/ircomm/ircomm_tty_attach.c:538: for each function it appears in.)
net/irda/ircomm/ircomm_tty_attach.c:539: warning: implicit declaration 
of function `mark_bh'
net/irda/ircomm/ircomm_tty_attach.c:539: `IMMEDIATE_BH' undeclared 
(first use in this function)
  gcc -Wp,-MD,./.ircomm_param.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=ircomm_param   -c -o ircomm_param.o 
ircomm_param.c
net/irda/ircomm/ircomm_param.c: In function `ircomm_param_request':
net/irda/ircomm/ircomm_param.c:169: warning: implicit declaration of 
function `queue_task'
net/irda/ircomm/ircomm_param.c:169: `tq_immediate' undeclared (first use 
in this function)
net/irda/ircomm/ircomm_param.c:169: (Each undeclared identifier is 
reported only once
net/irda/ircomm/ircomm_param.c:169: for each function it appears in.)
net/irda/ircomm/ircomm_param.c:170: warning: implicit declaration of 
function `mark_bh'
net/irda/ircomm/ircomm_param.c:170: `IMMEDIATE_BH' undeclared (first use 
in this function)
  ld -m elf_i386  -r -o ircomm-tty.o ircomm_tty.o ircomm_tty_attach.o 
ircomm_tty_ioctl.o ircomm_param.o
ld: cannot open ircomm_tty.o: No such file or directory
make[3]: *** [ircomm-tty.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.40/net/irda/ircomm'
make[2]: *** [ircomm] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.40/net/irda'
make[1]: *** [irda] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.40/net'
make: *** [net] Error 2


OK, time for bed, I hope this helps somebody.

Cheers,

Rudy

