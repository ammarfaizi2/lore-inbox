Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277618AbRJLLXU>; Fri, 12 Oct 2001 07:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277616AbRJLLXI>; Fri, 12 Oct 2001 07:23:08 -0400
Received: from CPE-61-9-149-34.vic.bigpond.net.au ([61.9.149.34]:32247 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S277622AbRJLLWz>; Fri, 12 Oct 2001 07:22:55 -0400
Message-ID: <3BC6CF3D.8450C591@eyal.emu.id.au>
Date: Fri, 12 Oct 2001 21:08:45 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13-pre1: sonypi.c compile error
In-Reply-To: <3BC62542.CDEAAE@eyal.emu.id.au> <20011012103433.A2137@come.alcove-fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> 
> On Fri, Oct 12, 2001 at 09:03:30AM +1000, Eyal Lebedinsky wrote:
> 
> > gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> > -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
> > /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h
> > -DEXPORT_SYMTAB -c sonypi.c
> > sonypi.c: In function `sonypi_init_module':
> > sonypi.c:702: `is_sony_vaio_laptop_R7462d5e4' undeclared (first use in
> > this function)
> 
> Just add a
>         extern int is_sony_vaio_laptop; /* set in DMI table parse routines */
> line somewhere at the beginning of the file drivers/char/sonypi.c

Good. I am now up to here, which I guess is very possitive relative to
the
recent 2.4 releases :-)

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h  
-DEXPORT_SYMTAB -c i2o_pci.c
i2o_pci.c: In function `i2o_pci_install':
i2o_pci.c:165: structure has no member named `pdev'
make[2]: *** [i2o_pci.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/i2o'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
