Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbSKWEFn>; Fri, 22 Nov 2002 23:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbSKWEFn>; Fri, 22 Nov 2002 23:05:43 -0500
Received: from cmailm1.svr.pol.co.uk ([195.92.193.18]:31506 "EHLO
	cmailm1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266939AbSKWEFm>; Fri, 22 Nov 2002 23:05:42 -0500
Date: Sat, 23 Nov 2002 04:12:50 +0000
From: Loic Jaquemet <jal@les3stagiaires.freeserve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.49 - bttv module not compiling
Message-Id: <20021123041250.10af38e3.jal@les3stagiaires.freeserve.co.uk>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2 errors in drivers/media/video/bttv-cards.c

One #define is missing for AUDC_CONFIG_PINNACLE, used line 1742 ?

struct pci_dev has no name member ? line 2993.

        struct pci_dev *dev = NULL;
	[...]
                printk(KERN_INFO "bttv: Host bridge is %s\n",dev->name);


  gcc -Wp,-MD,drivers/media/video/.bttv-cards.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=bttv_cards -DKBUILD_MODNAME=bttv   -c -o drivers/media/video/bttv-cards.o drivers/media/video/bttv-cards.c
drivers/media/video/bttv-cards.c: Dans la fonction « miro_pinnacle_gpio »:
drivers/media/video/bttv-cards.c:1742: « AUDC_CONFIG_PINNACLE » non déclaré (première utilisation dans cette fonction)
drivers/media/video/bttv-cards.c:1742: (Chaque identificateur non déclaré est rapporté une seule fois
drivers/media/video/bttv-cards.c:1742: pour chaque fonction dans laquelle il apparaît.)
drivers/media/video/bttv-cards.c: Dans la fonction « bttv_check_chipset »:
drivers/media/video/bttv-cards.c:2993: structure n'a pas de membre nommé « name »
make[3]: *** [drivers/media/video/bttv-cards.o] Erreur 1
make[2]: *** [drivers/media/video] Erreur 2
make[1]: *** [drivers/media] Erreur 2
make: *** [drivers] Erreur 2

linux-2.5.49$ grep -rn AUDC_CONFIG_PINNACLE *
drivers/media/video/bttv-cards.c:1742:          bttv_call_i2c_clients(btv,AUDC_CONFIG_PINNACLE,&id);
linux-2.5.49$


+----------------------------------------------+
|Jaquemet Loic                                 |
|Eleve ingenieur en informatique FIIFO, ORSAY  |
+----------------------------------------------+
http://sourceforge.net/projects/ffss/
#wirelessfr @ irc.freenode.net


