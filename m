Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292318AbSBUHLv>; Thu, 21 Feb 2002 02:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292323AbSBUHLl>; Thu, 21 Feb 2002 02:11:41 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:30220 "EHLO
	jubjub.wizard.com") by vger.kernel.org with ESMTP
	id <S292318AbSBUHLZ>; Thu, 21 Feb 2002 02:11:25 -0500
Date: Wed, 20 Feb 2002 23:10:51 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: virt_to_bus_not_defined_use_pci_map: Missed a couple
Message-ID: <20020221071051.GA17927@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux/2.5.2 (i686)
X-uptime: 11:09pm  up 3 days, 22:52,  3 users,  load average: 2.18, 1.84, 0.96
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Just had these go bung while giving 2.5.5 a compile:

make[1]: Leaving directory `/usr/src/linux-2.5.5/arch/i386/mm'
make -C  arch/i386/lib modules_install
make[1]: Entering directory `/usr/src/linux-2.5.5/arch/i386/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.5.5/arch/i386/lib'
cd /lib/modules/2.5.5; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.5; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.5/kernel/drivers/net/de4x5.o
depmod:         virt_to_bus_not_defined_use_pci_map
depmod: *** Unresolved symbols in /lib/modules/2.5.5/kernel/sound/oss/sound.o
depmod:         virt_to_bus_not_defined_use_pci_map
make: *** [_modinst_post] Error 1

        Luckily I'm not going to be using these for the moment, so my kernel 
is good to go, but thought I'd give you a heads up.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

