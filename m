Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVIDMbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVIDMbm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 08:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVIDMbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 08:31:42 -0400
Received: from imap.gmx.net ([213.165.64.20]:22958 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750792AbVIDMbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 08:31:41 -0400
X-Authenticated: #945972
Message-ID: <431AE865.5070106@gmx.de>
Date: Sun, 04 Sep 2005 14:28:21 +0200
From: Niko Nitsche <fal16con@gmx.de>
Organization: http://www.brainopoly.de
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dragoran <dragoran@feuerpokemon.de>
CC: James Courtier-Dutton <James@superbug.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: snd-emu10k1 broken in 2.6.13
References: <4IY3f-61u-13@gated-at.bofh.it> <431ABB63.5020608@gmx.de> <431AC5C6.7030103@feuerpokemon.de> <431ACDDE.9090002@superbug.demon.co.uk> <431ACE61.3070704@feuerpokemon.de>
In-Reply-To: <431ACE61.3070704@feuerpokemon.de>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Well, those options lines are just wrong so I am not at all surprised
>> that it failed.
>>
>> It should be:
>> options snd-card-0 snd-intel8x0
>> options snd-intel8x0 index=0
>>
>> So, dragoran, what options lines do you have?
>>
>> James
>>
>>
Thanks James!

but I think those are the correct ones:

alias snd-card-0 snd-intel8x0
options snd-intel8x0 "index=0"
options snd-card-0 "index=0"

> this is my modprobe.conf:
> alias eth0 forcedeth
> alias eth1 r8169
> alias scsi_hostadapter sata_nv
> alias snd-card-0 snd-emu10k1
> options snd-card-0 index=0
> options snd-emu10k1 index=0
> remove snd-emu10k1 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ;
> }; /sbin/modprobe -r --ignore-remove snd-emu10k1
> alias usb-controller ehci-hcd
> alias usb-controller1 ohci-hcd
> alias ieee1394-controller ohci1394
> alias char-major-81 saa7134
> options nvidia NVreg_EnableAGPFW=1
>

so at least for me, using double quotes for options works out

Niko


