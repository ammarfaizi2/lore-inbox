Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbTJQWZo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 18:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTJQWZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 18:25:44 -0400
Received: from mail.g-housing.de ([62.75.136.201]:7635 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263616AbTJQWZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 18:25:42 -0400
Message-ID: <3F906C5F.8010401@g-house.de>
Date: Sat, 18 Oct 2003 00:25:35 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: de-de, de, en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 3c59x + 2.6.0-test7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this note will probably not fullfill the needs of a "bug filing", but at 
least i'd like to say there "is something with the 3c59x driver". since 
i've seen several other oddities with this driver on this list in the 
last time, here it comes:

i have a 3c905C-TX ("Vortex") in my ppc32 box, working fine under 
2.4.22. with 2.6.0-test7 the 3c59x.ko module get loaded, but then the 
machine just freezes. this is the behaviour during the standard booting 
process. upon booting with "init=/bin/bash" i am able to do "modprobe 
3c59x". the card gets loaded. i can assign an ip adress to the card, ok. 
but after a couple of minutes or at least upon unloading the driver, the 
machine just freezes. there is *no* oops shown, nothing in the logs, 
SYS-REQ is not working, the machine just halts.

yes, this is quite odd, reproducible perhaps only here@home, another 
3c59x card is working fine with 2.6.0-test7 under ia32 in the next room.
if this helps: gcc is 3.3.2, Debian/unstable, binutils 2.14.90.0.6, 
compiled under 2.4.22.

my .config is at http://nerdbynature.de/bits/.config

evil@sheep:~$ cat /proc/cpuinfo
cpu             : 604r
clock           : ???
revision        : 49.2 (pvr 0009 3102)
bogomips        : 299.00
machine         : PReP Utah (Powerstack II Pro4000)
l2 cache        : 512KiB, parity disabled SRAM:synchronous, pipelined, 
no parity
evil@sheep:~$

thanks,
Christian.
-- 
BOFH excuse #427:

network down, IP packets delivered via UPS

