Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277369AbRJOKIs>; Mon, 15 Oct 2001 06:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277371AbRJOKIi>; Mon, 15 Oct 2001 06:08:38 -0400
Received: from ibb0197.ibb.uu.nl ([131.211.124.197]:17414 "HELO
	ibb0197.ibb.uu.nl") by vger.kernel.org with SMTP id <S277369AbRJOKIT>;
	Mon, 15 Oct 2001 06:08:19 -0400
Message-ID: <3BCB0A02.9DF231A@zonnet.nl>
Date: Mon, 15 Oct 2001 12:08:34 -0400
From: Sander van Geloven <svgeloven@zonnet.nl>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-26mdk i686)
X-Accept-Language: nl, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: vgeloven@zonnet.nl
Subject: Re: 2.4.13-pre1: sonypi.c compile error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I won't submit a patch to Linus for now, I'm pretty sure that Alan will take care of this for -pre2.
>
> Stelian.

Hi,

I did a build with the patch-2.4.13-pre2.pz applied but it didn't fixed
the problem. Your suggestion to add a line in sonypi.c however did work.

Now I also have the same problem as Eyal Lebedinskynew:

make -C i2o modules
make[2]: Entering directory `/home/src/linux-2.4.12/drivers/i2o'
gcc -D__KERNEL__ -I/home/src/linux-2.4.12/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -DMODULE -DMODVERSIONS -include
/home/src/linux-2.4.12/include/linux/modversions.h   -DEXPORT_SYMTAB -c
i2o_pci.c
i2o_pci.c: In function `i2o_pci_install':
i2o_pci.c:165: structure has no member named `pdev'
make[2]: *** [i2o_pci.o] Error 1
make[2]: Leaving directory `/home/src/linux-2.4.12/drivers/i2o'
make[1]: *** [_modsubdir_i2o] Error 2
make[1]: Leaving directory `/home/src/linux-2.4.12/drivers'
make: *** [_mod_drivers] Error 2

Has anyone a suggestion?

Thanks,

Sander
