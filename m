Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319080AbSIDHAU>; Wed, 4 Sep 2002 03:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319081AbSIDHAU>; Wed, 4 Sep 2002 03:00:20 -0400
Received: from w-jens.oc.chemie.tu-darmstadt.de ([130.83.233.195]:13696 "HELO
	sonne.weltall") by vger.kernel.org with SMTP id <S319080AbSIDHAT>;
	Wed, 4 Sep 2002 03:00:19 -0400
Message-ID: <3D75B0A1.3070707@hrzpub.tu-darmstadt.de>
Date: Wed, 04 Sep 2002 09:05:05 +0200
From: Jens Wiesecke <j_wiese@hrzpub.tu-darmstadt.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: de, de-de, en-us
MIME-Version: 1.0
To: Justin Heesemann <jh@ionium.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       tspinillo@yahoo.com
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
References: <200209030153.47433.jh@ionium.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Heesemann wrote:
>>I tested:
>>2.4.19-pre6 -> boots with mem=512M parameter
>>2.4.19-pre7 -> didn't boot at all
>>2.4.19-pre7 with arch/i386/kernel/setup.c from 2.4.19-pre6 -> boots with
>>mem=512M parameter
> 
> 
> I have another update:
> some might know the memtest86 utility.
> 
> it has three ways of detecting the memory size "BIOS - Std", "BIOS - All" and 
> "Probe"
> 
> on my Athlon Mainboard (which has no Problems with 2.4.19 or later kernels) 
> all methods show the same (or nearly same) ammount of memory.
> 
> on my Epox 4G4A+ i845g Mainboard, which has all the Problems Jens Wiesecke 
> has, it's different:
> BIOS - Std : 640k (!!)
> BIOS - All : 4091M (!!!!)
> Probe: 511M (which seems correct as I have 512 MB Ram and 1 MB is shared 
> graphics ram)

ok. I tested my Chaintech 9EJL i845E mainboard the same way and I have 
exactly the same output with memtest86

BIOS - Std : 640k
BIOS - All : 4091M (memtest stops working afterwards)
Probe: 512M (since I have no shared graphics ram)

so the problem seems to be BIOS related. But what I don't understand is 
that since I tell the kernel to use 512 MByte of RAM (mem=512M) and 
kernels up to 2.4.19pre6 can handle this:

What changed and is there a workaround for kernels newer than 2.4.19pre6 
(for example telling the kernel not to rely on the memory information of 
the BIOS e820 procedure) ?

I tried to compile 2.4.20pre5-(ac) with the arch/i386/kernel/setup.c 
from 2.4.19pre6 but that didn't work.

Best regards
-- 
Jens Wiesecke
Institute for Macromolecular Chemistry
Darmstadt - Germany
e-mail: j_wiese@hrzpub.tu-darmstadt.de

