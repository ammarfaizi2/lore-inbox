Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311255AbSCSOKx>; Tue, 19 Mar 2002 09:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311258AbSCSOKo>; Tue, 19 Mar 2002 09:10:44 -0500
Received: from rammstein.mweb.co.za ([196.2.53.175]:20889 "EHLO
	rammstein.mweb.co.za") by vger.kernel.org with ESMTP
	id <S311255AbSCSOKa>; Tue, 19 Mar 2002 09:10:30 -0500
To: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>,
        linux-kernel@vger.kernel.org
From: bonganilinux@mweb.co.za
Subject: Re: 2.5.7 make modules_install error (oss)
Date: Tue, 19 Mar 2002 14:10:03 GMT
X-Mailer: Endymion MailMan Standard Edition v3.0.33
Message-Id: <E16nKGG-0004qs-00@rammstein.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> make -C  arch/i386/lib modules_install
> make[1]: Entering directory `/usr/src/linux/arch/i386/lib'
> make[1]: Nothing to be done for `modules_install'.
> make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
> cd /lib/modules/2.5.7; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.7; fi
> depmod: *** Unresolved symbols in /lib/modules/2.5.7/kernel/sound/oss/sound.o
> depmod:         virt_to_bus_not_defined_use_pci_map

The OSS driver that you selected has not been converted to use the new pci API
I'm not sure if it will ever be updated though, since alsa is now part of 2.5
try to use the alsa drivers instead. If you read this
virt_to_bus_not_defined_use_pci_map carefully yo will see that it says
virt_to_bus not defined use pci_map nice way to get people to fix the old drivers
;)

---------------------------------------------
This message was sent using M-Web Airmail.
JUST LIKE THAT
http://airmail.mweb.co.za/


