Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131426AbRCPXoQ>; Fri, 16 Mar 2001 18:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131430AbRCPXoH>; Fri, 16 Mar 2001 18:44:07 -0500
Received: from smtp01.wxs.nl ([195.121.6.61]:21236 "EHLO smtp01.wxs.nl")
	by vger.kernel.org with ESMTP id <S131426AbRCPXn7>;
	Fri, 16 Mar 2001 18:43:59 -0500
Message-ID: <3AB2A52D.30FA151B@planet.nl>
Date: Sat, 17 Mar 2001 00:43:41 +0100
From: Erik van Asselt <e.van.asselt@planet.nl>
X-Mailer: Mozilla 4.7 [nl] (Win98; U)
X-Accept-Language: nl
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Fwd: problems compiling scsi_ioctl on kernels later 2.4.1]
Content-Type: multipart/mixed;
 boundary="------------AD7D1302FC61C54FB8DE54F9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dit is een multi-gedeelten-bericht in MIME-formaat.
--------------AD7D1302FC61C54FB8DE54F9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

make -C scsi
make[2]: Entering directory `/usr/src/linux/drivers/scsi'
make -C aic7xxx
make[3]: Entering directory `/usr/src/linux/drivers/scsi/aic7xxx'
make all_targets
make[4]: Entering directory `/usr/src/linux/drivers/scsi/aic7xxx'
ld -m elf_i386  -r -o aic7xxx_mod.o aic7xxx_linux.o aic7xxx_linux_pci.o
aic7xxx_proc.o aic7770_linux.o aic7xxx.o aic7xxx_pci.o aic7xxx_93cx6.o
aic7770.o
rm -f aic7xxx_drv.o
ld -m elf_i386  -r -o aic7xxx_drv.o aic7xxx_mod.o
make[4]: Leaving directory `/usr/src/linux/drivers/scsi/aic7xxx'
make[3]: Leaving directory `/usr/src/linux/drivers/scsi/aic7xxx'
make all_targets
make[3]: Entering directory `/usr/src/linux/drivers/scsi'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i586    -c -o
scsi_ioctl.o scsi_ioctl.c
scsi_ioctl.c:191: parse error before `Scsi_Ioctl_Command'
scsi_ioctl.c:192: warning: function declaration isn't a prototype
scsi_ioctl.c: In function `scsi_ioctl_send_command':
scsi_ioctl.c:204: `sic' undeclared (first use in this function)
scsi_ioctl.c:204: (Each undeclared identifier is reported only once
scsi_ioctl.c:204: for each function it appears in.)
scsi_ioctl.c:209: `Scsi_Ioctl_Command' undeclared (first use in this
function)
scsi_ioctl.c:212: warning: type defaults to `int' in declaration of
`type
name'
scsi_ioctl.c:213: warning: type defaults to `int' in declaration of
`type
name'
scsi_ioctl.c:271: `dev' undeclared (first use in this function)
scsi_ioctl.c: In function `scsi_ioctl':
scsi_ioctl.c:378: `Scsi_Idlun' undeclared (first use in this function)
scsi_ioctl.c:381: parse error before `)'
scsi_ioctl.c:382: parse error before `)'
scsi_ioctl.c:385: warning: type defaults to `int' in declaration of
`type
name'
scsi_ioctl.c:385: parse error before `)'
scsi_ioctl.c:385: parse error before `)'
scsi_ioctl.c:385: warning: type defaults to `int' in declaration of
`type
name'
scsi_ioctl.c:385: parse error before `)'
scsi_ioctl.c:385: parse error before `)'
scsi_ioctl.c:385: warning: type defaults to `int' in declaration of
`type
name'
scsi_ioctl.c:385: parse error before `)'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: warning: type defaults to `int' in declaration of
`type
name'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: warning: type defaults to `int' in declaration of
`type
name'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: warning: type defaults to `int' in declaration of
`type
name'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:412: `Scsi_Ioctl_Command' undeclared (first use in this
function)
scsi_ioctl.c:412: parse error before `)'
scsi_ioctl.c:419: `SCSI_REMOVAL_PREVENT' undeclared (first use in this
function)
scsi_ioctl.c:429: `SCSI_REMOVAL_ALLOW' undeclared (first use in this
function)
make[3]: *** [scsi_ioctl.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

i had it working fine in 2.4.1


Douglas Gilbert schreef:

> > i tried to compile linux-2.4.3-pre4  on a redhat and suse machine
with
> > different gcc's egcs 1.1.2 ,gcc 2.96 and gcc 2.95
> > but all get stuck on  compiling scsi_ioctl in kernel or as module
> > does anyone have an idea?
> > machine's :  -pentium 66 (with bug :=) running suse 7.0
> >                   -amd athlon 1000 with promise fasttrak running
redhat
> > 7.0
>
> Erik,
> Is there a compile error (if so what). There are no changes
> in scsi_ioctl.c between 2.4.2 (which builds ok for me) and
> 2.4.3-pre4 .
>
> Doug Gilbert



--------------AD7D1302FC61C54FB8DE54F9
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3AB2A2AF.1F782612@planet.nl>
Date: Sat, 17 Mar 2001 00:33:03 +0100
From: Erik van Asselt <e.van.asselt@planet.nl>
X-Mailer: Mozilla 4.7 [nl] (Win98; U)
X-Accept-Language: nl
MIME-Version: 1.0
To: Douglas Gilbert <dougg@torque.net>
Subject: Re: problems compiling scsi_ioctl on kernels later 2.4.1
In-Reply-To: <3AB26CA3.4115C1E@torque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

make -C scsi
make[2]: Entering directory `/usr/src/linux/drivers/scsi'
make -C aic7xxx
make[3]: Entering directory `/usr/src/linux/drivers/scsi/aic7xxx'
make all_targets
make[4]: Entering directory `/usr/src/linux/drivers/scsi/aic7xxx'
ld -m elf_i386  -r -o aic7xxx_mod.o aic7xxx_linux.o aic7xxx_linux_pci.o
aic7xxx_proc.o aic7770_linux.o aic7xxx.o aic7xxx_pci.o aic7xxx_93cx6.o
aic7770.o
rm -f aic7xxx_drv.o
ld -m elf_i386  -r -o aic7xxx_drv.o aic7xxx_mod.o
make[4]: Leaving directory `/usr/src/linux/drivers/scsi/aic7xxx'
make[3]: Leaving directory `/usr/src/linux/drivers/scsi/aic7xxx'
make all_targets
make[3]: Entering directory `/usr/src/linux/drivers/scsi'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i586    -c -o
scsi_ioctl.o scsi_ioctl.c
scsi_ioctl.c:191: parse error before `Scsi_Ioctl_Command'
scsi_ioctl.c:192: warning: function declaration isn't a prototype
scsi_ioctl.c: In function `scsi_ioctl_send_command':
scsi_ioctl.c:204: `sic' undeclared (first use in this function)
scsi_ioctl.c:204: (Each undeclared identifier is reported only once
scsi_ioctl.c:204: for each function it appears in.)
scsi_ioctl.c:209: `Scsi_Ioctl_Command' undeclared (first use in this
function)
scsi_ioctl.c:212: warning: type defaults to `int' in declaration of `type
name'
scsi_ioctl.c:213: warning: type defaults to `int' in declaration of `type
name'
scsi_ioctl.c:271: `dev' undeclared (first use in this function)
scsi_ioctl.c: In function `scsi_ioctl':
scsi_ioctl.c:378: `Scsi_Idlun' undeclared (first use in this function)
scsi_ioctl.c:381: parse error before `)'
scsi_ioctl.c:382: parse error before `)'
scsi_ioctl.c:385: warning: type defaults to `int' in declaration of `type
name'
scsi_ioctl.c:385: parse error before `)'
scsi_ioctl.c:385: parse error before `)'
scsi_ioctl.c:385: warning: type defaults to `int' in declaration of `type
name'
scsi_ioctl.c:385: parse error before `)'
scsi_ioctl.c:385: parse error before `)'
scsi_ioctl.c:385: warning: type defaults to `int' in declaration of `type
name'
scsi_ioctl.c:385: parse error before `)'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: warning: type defaults to `int' in declaration of `type
name'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: warning: type defaults to `int' in declaration of `type
name'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:386: warning: type defaults to `int' in declaration of `type
name'
scsi_ioctl.c:386: parse error before `)'
scsi_ioctl.c:412: `Scsi_Ioctl_Command' undeclared (first use in this
function)
scsi_ioctl.c:412: parse error before `)'
scsi_ioctl.c:419: `SCSI_REMOVAL_PREVENT' undeclared (first use in this
function)
scsi_ioctl.c:429: `SCSI_REMOVAL_ALLOW' undeclared (first use in this
function)
make[3]: *** [scsi_ioctl.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

i had it working fine in 2.4.1


Douglas Gilbert schreef:

> > i tried to compile linux-2.4.3-pre4  on a redhat and suse machine with
> > different gcc's egcs 1.1.2 ,gcc 2.96 and gcc 2.95
> > but all get stuck on  compiling scsi_ioctl in kernel or as module
> > does anyone have an idea?
> > machine's :  -pentium 66 (with bug :=) running suse 7.0
> >                   -amd athlon 1000 with promise fasttrak running redhat
> > 7.0
>
> Erik,
> Is there a compile error (if so what). There are no changes
> in scsi_ioctl.c between 2.4.2 (which builds ok for me) and
> 2.4.3-pre4 .
>
> Doug Gilbert


--------------AD7D1302FC61C54FB8DE54F9--

