Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131719AbQLVNbw>; Fri, 22 Dec 2000 08:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131740AbQLVNbm>; Fri, 22 Dec 2000 08:31:42 -0500
Received: from [203.54.251.183] ([203.54.251.183]:54022 "EHLO eyal.emu.id.au")
	by vger.kernel.org with ESMTP id <S131719AbQLVNb3>;
	Fri, 22 Dec 2000 08:31:29 -0500
Message-ID: <3A43506B.6CEF84BB@eyal.emu.id.au>
Date: Sat, 23 Dec 2000 00:00:27 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre4
In-Reply-To: <Pine.LNX.4.10.10012211726060.968-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>  - pre4:
>    - Andrea Arkangeli: update to LVM-0.9

gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE
-DMODVERSIONS -include
/usr/local/src/linux/include/linux/modversions.h   -c -o lvm.o lvm.c
lvm.c: In function `lvm_do_vg_extend':
lvm.c:2024: warning: implicit declaration of function
`lvm_do_create_proc_entry_of_pv'
lvm.c: In function `lvm_do_create_proc_entry_of_lv':
lvm.c:3016: `pde' undeclared (first use in this function)
lvm.c:3016: (Each undeclared identifier is reported only once
lvm.c:3016: for each function it appears in.)
lvm.c: At top level:
lvm.c:3044: warning: type mismatch with previous implicit declaration
lvm.c:2024: warning: previous implicit declaration of
`lvm_do_create_proc_entry_of_pv'
lvm.c:3044: warning: `lvm_do_create_proc_entry_of_pv' was previously
implicitly declared to return `int'
lvm.c: In function `lvm_do_create_proc_entry_of_pv':
lvm.c:3050: `pde' undeclared (first use in this function)
lvm.c: At top level:
lvm.c:147: warning: `lvm_short_version' defined but not used
make[2]: *** [lvm.o] Error 1
make[2]: Leaving directory `/data2/usr/local/src/linux-2.4/drivers/md'

  --------------- .config
#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_BLK_DEV_LVM=m
  -----------------
--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
