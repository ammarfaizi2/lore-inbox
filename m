Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311415AbSCSQth>; Tue, 19 Mar 2002 11:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311435AbSCSQt1>; Tue, 19 Mar 2002 11:49:27 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:40204 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S311415AbSCSQtL>; Tue, 19 Mar 2002 11:49:11 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256B81.005C508A.00@smtpnotes.altec.com>
Date: Tue, 19 Mar 2002 10:48:26 -0600
Subject: Re: 2.5.7 make modules_install error (oss)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I really wish the OSS drivers would be fixed.  They worked perfectly with my
Crystal SoundFusion card, but the ALSA drivers are very unreliable with it.
Sometimes they work, sometimes they don't.  (One day a couple of weeks ago I
rebooted about ten times, and the sound worked consistently *on alternate boots*
(that is, it didn't work after the first boot, worked on the second boot, didn't
work on the third, worked on the fourth, etc.).  The next day it worked on every
boot.  Since then it works sometimes, and sometimes doesn't, with no discernible
pattern.  Even when it's working, it works sporadically -- some sound effects in
Gnome work, others don't, then a few minutes later they all work again;
RealPlayer works OK until I open a new window, then the sound cuts out and won't
start again until I restart RealPlayer; and so forth.  The OSS drivers don't
give me any of these problems.





bonganilinux@mweb.co.za on 03/19/2002 08:10:03 AM

To:   Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>,
      linux-kernel@vger.kernel.org
cc:    (bcc: Wayne Brown/Corporate/Altec)

Subject:  Re: 2.5.7 make modules_install error (oss)



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
virt_to_bus not defined use pci_map nice way to get people to fix the old
drivers
;)

---------------------------------------------
This message was sent using M-Web Airmail.
JUST LIKE THAT
http://airmail.mweb.co.za/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




