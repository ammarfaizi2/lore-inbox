Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263992AbTCWXUS>; Sun, 23 Mar 2003 18:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263994AbTCWXUS>; Sun, 23 Mar 2003 18:20:18 -0500
Received: from paris.xisl.com ([193.112.238.192]:12700 "EHLO paris.xisl.com")
	by vger.kernel.org with ESMTP id <S263992AbTCWXUR>;
	Sun, 23 Mar 2003 18:20:17 -0500
Message-ID: <3E7E43C3.2080605@xisl.com>
Date: Sun, 23 Mar 2003 23:31:15 +0000
From: John M Collins <jmc@xisl.com>
Organization: Xi Software Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Query about SIS963 Bridges
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me on jmc@spam.xisl.com without the spam as I'm not subscribed 
- thanks.

I've just got a new machine (2.5 GHz pentium lots of RAM and disk space) 
which has one of these SIS963 Southbridge creatures and I get the 
message on booting a 2.4.19ish sort of kernel.

Unknown bridge resource 0 - assuming transparent

Alas it's very clear that it isn't transparent and I can't get to half 
of the PCI stuff - worst of all the built-in Ethernet and any Ethernet 
card I plug in. It would seem that it isn't too transparent as the 
reported IRQ and IOMEM assignments for the devices are all scrambled.

I changed the message in drivers/pci/pci.c to report the base and limit 
values extracted and they are e000 and d000 respectively which explains 
why the code chokes on it.

I've followed a long thread about fixing this on transparent bridges - 
can some kind guru give me some runes to get this machine off the 
ground? A quick and dirty my-machine-only hack would be fine for me if 
not fully aesthetically pleasing to all and sundry.

I've looked at the SIS website and it wasn't a lot of help. They 
referred me to the motherboard mfr (ASUS). I emailed ASUS but still no joy.

I see the built-in Ethernet is an SIS900 no doubt that is more fun in 
store with that but I've got a small stack of alternative PCI cards on 
the windowsill which I'll stuff in if I can get past this problem.

-- 
John Collins Xi Software Ltd www.xisl.com


