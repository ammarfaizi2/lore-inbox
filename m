Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSCSSvf>; Tue, 19 Mar 2002 13:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290796AbSCSSv0>; Tue, 19 Mar 2002 13:51:26 -0500
Received: from freeside.toyota.com ([63.87.74.7]:64269 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S290593AbSCSSvR>; Tue, 19 Mar 2002 13:51:17 -0500
Message-ID: <3C97889B.6060301@lexus.com>
Date: Tue, 19 Mar 2002 10:51:07 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020318
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wayne.Brown@altec.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 make modules_install error (oss)
In-Reply-To: <86256B81.005C508A.00@smtpnotes.altec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agreed, the oss drivers should _at least_
be maintained as an alternative, e.g. for
those of us who want reliable sound with
*low latency*

<explanation>
I haven't checked lately, but not too long
ago the alsa drivers were found to be one
of the worst sources of latency in the kernel.
</explanation>

Joe

Wayne.Brown@altec.com wrote:

>
>I really wish the OSS drivers would be fixed.  They worked perfectly with my
>Crystal SoundFusion card, but the ALSA drivers are very unreliable with it.
>Sometimes they work, sometimes they don't.  (One day a couple of weeks ago I
>rebooted about ten times, and the sound worked consistently *on alternate boots*
>(that is, it didn't work after the first boot, worked on the second boot, didn't
>work on the third, worked on the fourth, etc.).  The next day it worked on every
>boot.  Since then it works sometimes, and sometimes doesn't, with no discernible
>pattern.  Even when it's working, it works sporadically -- some sound effects in
>Gnome work, others don't, then a few minutes later they all work again;
>RealPlayer works OK until I open a new window, then the sound cuts out and won't
>start again until I restart RealPlayer; and so forth.  The OSS drivers don't
>give me any of these problems.
>
>
>
>
>
>bonganilinux@mweb.co.za on 03/19/2002 08:10:03 AM
>
>To:   Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>,
>      linux-kernel@vger.kernel.org
>cc:    (bcc: Wayne Brown/Corporate/Altec)
>
>Subject:  Re: 2.5.7 make modules_install error (oss)
>
>
>
>>Hi,
>>
>>make -C  arch/i386/lib modules_install
>>make[1]: Entering directory `/usr/src/linux/arch/i386/lib'
>>make[1]: Nothing to be done for `modules_install'.
>>make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
>>cd /lib/modules/2.5.7; \
>>mkdir -p pcmcia; \
>>find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
>>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.7; fi
>>depmod: *** Unresolved symbols in /lib/modules/2.5.7/kernel/sound/oss/sound.o
>>depmod:         virt_to_bus_not_defined_use_pci_map
>>
>
>The OSS driver that you selected has not been converted to use the new pci API
>I'm not sure if it will ever be updated though, since alsa is now part of 2.5
>try to use the alsa drivers instead. If you read this
>virt_to_bus_not_defined_use_pci_map carefully yo will see that it says
>virt_to_bus not defined use pci_map nice way to get people to fix the old
>drivers
>;)
>
>---------------------------------------------
>This message was sent using M-Web Airmail.
>JUST LIKE THAT
>http://airmail.mweb.co.za/
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


