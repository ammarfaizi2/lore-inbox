Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272882AbRIGW2o>; Fri, 7 Sep 2001 18:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272881AbRIGW2e>; Fri, 7 Sep 2001 18:28:34 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:53256 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272879AbRIGW2U>; Fri, 7 Sep 2001 18:28:20 -0400
Message-ID: <3B994978.3AFA1862@t-online.de>
Date: Sat, 08 Sep 2001 00:26:00 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "SATHISH.J" <sathish.j@tatainfotech.com>
CC: kernelnewbies <kernelnewbies@nl.linux.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Reg lilo.conf changed and system doesn't boot
In-Reply-To: <Pine.LNX.4.10.10109072322550.30022-100000@blrmail>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"SATHISH.J" schrieb:
> 
> Hi,
> I know that this is not the place to ask this question.Please forgive me.
> I changed the lilo.conf on my machine(redhat 2.2.14-12 kernel) and it
> doesn't boot up. I don't have
> a boot floppy to boot. I have another disk which has an older version of
> linux(2.2.6). I can mount the disk if I boot from the other
> disk(2.2.6). Can I
> in some way alter the lilo.conf of my disk(2.2.14) and boot linux from
> that. Please tell me any ideas to do that.

Hello..

Seems you have installed a new kernel and not called lilo before
reboot...

I would suggest one of these two ways:

-Boot from your older hdd and mount the new one, e.g. under /mnt/test.
Call lilo, but give him the configfile from your new hdd, it should ly
under /mnt/test/etc/lilo.conf, if you have mounted your new, defective
linux under /mnt/test: "lilo -C /mnt/test/etc/lilo.conf
Before, check that your lilo.conf is correct!
(I have to admit that i' ve never tried this myself)

-Boot from your older hdd and use the distro-tools to produce an
"emergency repair disk", e.g. "mkbootdisk" under RedHat or "yast" under
SuSE. Use this repairdisk to boot the defective linux-installation,
check /etc/lilo.conf and call lilo.

And one hint:
It is always a good idea to have a bootdisk on hand...:-)

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
