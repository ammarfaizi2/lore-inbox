Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTI1AGB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 20:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbTI1AGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 20:06:01 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:58382 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S262285AbTI1AF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 20:05:59 -0400
Date: Sun, 28 Sep 2003 02:05:51 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcom BCM5901 NIC
Message-ID: <20030928000550.GA24165@hardeman.nu>
References: <20030927231904.GA22769@hardeman.nu> <3F761D02.3050708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F761D02.3050708@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried unplugging/plugging the cable a few times along with ifup and 
ifdown a few times in different variations. It didnt seem to do much, 
one interesting thing that I noticed was that the Windows XP host that 
this laptop was connected to with a crossover cable during the testing 
reported the link as being down when the NIC was ifup'ed and vice versa.

After being bored with ifup/down and cable pulling I tried some 
modprobe/rmmod as well. This proptly hosed the system, the "ifconfig 
eth0 down" command is frozen, unkillable and consumes 100% CPU right 
now. ifconfig on another console to check if the card "is still there" 
also froze. Well, at least the network led woke up, its on constantly 
right now :-)

Ideas?

//David

PS
With the tg3 driver the card is reported as a 33Mhz PCI card, with the 
bcm5700 it's reported as a 66Mhz PCI card, could this make a 
difference?

On Sat, Sep 27, 2003 at 07:28:02PM -0400, Jeff Garzik wrote:
>David Härdeman wrote:
>>Hi,
>>
>>my new laptop (IBM Thinkpad G40) has an integrated NIC made by broadcom. 
>>It's a BCM5901 card for which support was added in the tg3 driver a few 
>>weeks ago (both in 2.4 and 2.6-test). However, the device doesn't work, 
>>it insmods just fine and claims the hardware, but the machine never 
>>responds to ping messages and the led indicating network activity is 
>>never activated.
>>
>>Broadcom has released a driver of their own (bcm5700) which works with 
>>kernel 2.4.21. When I try that combination it works fine, however, the 
>>bcm5700 driver wont work at all on recent 2.4 or 2.6 kernels.
>>
>>Does anyone know what is wrong with the tg3 driver? Has anyone tried 
>>using it on a 5901 card with success?
>
>
>Trying unplugging/plugging the cable, or ifdown+ifup cycle, and let me 
>know if that fixes things.
>
>	Jeff
>
>
