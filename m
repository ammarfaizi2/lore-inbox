Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272528AbRIKRSW>; Tue, 11 Sep 2001 13:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272527AbRIKRSL>; Tue, 11 Sep 2001 13:18:11 -0400
Received: from 132-ZARA-X28.libre.retevision.es ([62.82.239.132]:27399 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S272521AbRIKRSA>;
	Tue, 11 Sep 2001 13:18:00 -0400
Message-ID: <3B914C31.3080804@zaralinux.com>
Date: Sat, 01 Sep 2001 22:59:29 +0200
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.3) Gecko/20010803
X-Accept-Language: es-es, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP, APIC and networking issues...
In-Reply-To: <E15cxsH-0004F6-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>The supposed trick is to boot with a  "noapic" 
>>option, since this is believed to be a APIC issue, 
>>not a driver issue (as mentioned, this problem 
>>has been seen for both 3com and intel cards).
>>
>>Is "noapic" still the recommended approach for SMP
>>kernels or is it advisable to use 2.4.9 to solve 
>>this specific issue ?
>>
> 
> If you are still seeing the problem then yes try noapic, but also let
> me know if its happening with current kernels. The apic has multiple effects
> and not all of them are necessarily hardware issues at all
> 
> The big one is that interrupts can get delayed and become much more 
> asynchronous which can obviously have impacts on driver races

I'm having nic hangs with recent kernels, the last one in wich I saw 
this is with 2.4.9-ac3, and I'm currently running 2.4.9-ac5, the nic is 
a 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 64) linked with a 
twisted cable to another computer.

I have a dual 200mmx, motherboard is a gigabyte 586dx, lots of apic 
errors, but so far not a lot of hangs, is home machine, no server.

Aug 27 15:50:26 quartz kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 27 15:50:26 quartz kernel: eth0: transmit timed out, tx_status 00 
status e601.
Aug 27 15:50:26 quartz kernel:   diagnostics: net 0cf2 media 8880 dma 
0000003a.
Aug 27 15:50:26 quartz kernel: eth0: Interrupt posted but not delivered 
-- IRQ blocked by another device?
Aug 27 15:50:26 quartz kernel:   Flags; bus-master 1, dirty 149028(4) 
current 149028(4)
Aug 27 15:50:26 quartz kernel:   Transmit list 00000000 vs. c51cf300.
Aug 27 15:50:26 quartz kernel:   0: @c51cf200  length 80000062 status 
00010062
Aug 27 15:50:26 quartz kernel:   1: @c51cf240  length 80000062 status 
00010062
Aug 27 15:50:26 quartz kernel:   2: @c51cf280  length 80000062 status 
80010062
Aug 27 15:50:26 quartz kernel:   3: @c51cf2c0  length 80000062 status 
80010062
Aug 27 15:50:26 quartz kernel:   4: @c51cf300  length 8000006e status 
0001006e
Aug 27 15:50:26 quartz kernel:   5: @c51cf340  length 8000006e status 
0001006e
Aug 27 15:50:26 quartz kernel:   6: @c51cf380  length 8000006e status 
0001006e
Aug 27 15:50:26 quartz kernel:   7: @c51cf3c0  length 80000062 status 
00010062
Aug 27 15:50:26 quartz kernel:   8: @c51cf400  length 80000062 status 
00010062
Aug 27 15:50:26 quartz kernel:   9: @c51cf440  length 80000062 status 
00010062
Aug 27 15:50:26 quartz kernel:   10: @c51cf480  length 80000062 status 
00010062
Aug 27 15:50:26 quartz kernel:   11: @c51cf4c0  length 80000062 status 
00010062
Aug 27 15:50:26 quartz kernel:   12: @c51cf500  length 80000062 status 
00010062
Aug 27 15:50:26 quartz kernel:   13: @c51cf540  length 80000062 status 
00010062
Aug 27 15:50:26 quartz kernel:   14: @c51cf580  length 80000062 status 
00010062
Aug 27 15:50:26 quartz kernel:   15: @c51cf5c0  length 80000062 status 
00010062

BTW I switched to a rtl8139 from a rtl8029 for speed upgrade, but it was 
slow as a dog in my system, due to (as someone said) bad motherboard 
chipset for busmaster transfer, and nic hangs, so switched to a 3com 
905, with the same results, speed is somewhat better, but it also hangs.

-- 
Jorge Nerin
<comandante@zaralinux.com>

