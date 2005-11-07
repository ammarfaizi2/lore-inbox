Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVKGVos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVKGVos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbVKGVos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:44:48 -0500
Received: from www.eclis.ch ([144.85.15.72]:958 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S964984AbVKGVoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:44:46 -0500
Message-ID: <436FCACC.7060104@eclis.ch>
Date: Mon, 07 Nov 2005 22:44:44 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: john stultz <johnstul@us.ibm.com>, Len Brown <len.brown@intel.com>,
       macro@linux-mips.org, linux-kernel@vger.kernel.org, dean@arctic.org,
       zippel@linux-m68k.org
Subject: Re: NTP broken with 2.6.14
References: <4369464B.6040707@eclis.ch> <1131064846.27168.619.camel@cog.beaverton.ibm.com> <436ACC89.2050900@eclis.ch> <200511062349.19257.hpj@urpla.net>
In-Reply-To: <200511062349.19257.hpj@urpla.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Peter Jansen a écrit :
> Am Freitag, 4. November 2005 03:50 schrieb Jean-Christian de Rivaz:
> 
>>After trying several time, I am unable to upgrade the BIOS of this
>>machine. The flash utility hang all the system at the very beginning
>>of the real access to programm the flash! This is maybe because I use
>>a freedos image over pxelinux. I will try with a floppy and a MSDOS
>>if I found such olds stuffs somehere.
> 
> 
> Could very well be the netboot stuff. I typically flash BIOS/firmware 
> via DOS network boot images, which provides at least two different ways 
> of disk emulation: a: and c:, but some flash tools just freeze the 
> system on load/image load in both ways. Most prominently is the Promise 
> TX2/100 firmware update, but also a couple of motherboards BIOS' 
> flashers behave that way (cannot remember which ones, though). 

As you can see in my two latest post, I finnaly found that this was not 
the good BIOS for the motherborad. When I understand my mistake, I take 
the good BIOS version and I was able to flash it with FreeDOS over PXE 
network boot. So the netboot stuff was not the problem in my case.

The funny part is that with my motherboard, if you try to flash the 
wrong BIOS version you don't get any clear message agains this 
opearation. But this ended randomly into one of the following posibility:
1) system simply hang.
2) "division by zero error".
3) "failed opcode "<put some hexadecimal bytes here>.
4) immediate reboot.

I think that the BIOS update is an area where the mainboard makers have 
a hug possibility to improve there product...

-- 
Jean-Christian de Rivaz
