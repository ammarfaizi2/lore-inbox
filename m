Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278063AbRJIXmv>; Tue, 9 Oct 2001 19:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278064AbRJIXmn>; Tue, 9 Oct 2001 19:42:43 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:33797 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S278063AbRJIXmh>; Tue, 9 Oct 2001 19:42:37 -0400
Subject: Re: 2.4.10-ac10 -- Unresolved symbol __io_virt_debug in sk98lin.o,
	skfp.o, aha152x_cs.o, fdomain_cs.o abd msnd_classic.o.
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1002663582.3218.7.camel@stomata.megapathdsl.net>
In-Reply-To: <1002663582.3218.7.camel@stomata.megapathdsl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99 (Preview Release)
Date: 09 Oct 2001 16:34:27 -0700
Message-Id: <1002670473.3217.102.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this appears to have been cleared up by doing a "make mrproper".

On Tue, 2001-10-09 at 14:39, Miles Lane wrote:
> I searched the LKML and didn't find this mentioned.
> 
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.10-ac10; fi
> depmod: *** Unresolved symbols in /lib/modules/2.4.10-ac10/kernel/drivers/net/sk98lin/sk98lin.o
> depmod: 	__io_virt_debug
> depmod: *** Unresolved symbols in /lib/modules/2.4.10-ac10/kernel/drivers/net/skfp/skfp.o
> depmod: 	__io_virt_debug
> depmod: *** Unresolved symbols in /lib/modules/2.4.10-ac10/kernel/drivers/scsi/pcmcia/aha152x_cs.o
> depmod: 	__io_virt_debug
> depmod: *** Unresolved symbols in /lib/modules/2.4.10-ac10/kernel/drivers/scsi/pcmcia/fdomain_cs.o
> depmod: 	__io_virt_debug
> depmod: *** Unresolved symbols in /lib/modules/2.4.10-ac10/kernel/drivers/sound/msnd_classic.o
> depmod: 	__io_virt_debug
> 
> Not sure if it is related, but I have #define DEBUG in my arch/i386/kernel/pci-i386.h.


