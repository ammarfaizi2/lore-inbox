Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263379AbUCSANd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbUCSAL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:11:57 -0500
Received: from alt.aurema.com ([203.217.18.57]:2223 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S263379AbUCSAH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 19:07:56 -0500
Message-ID: <405A39C7.2060700@aurema.com>
Date: Fri, 19 Mar 2004 11:07:35 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong
 thing
References: <1079593351.1830.12.camel@bonnie79> <40594ADE.2020804@aurema.com> <1079594175.1830.22.camel@bonnie79> <4059565E.4020007@aurema.com> <20040318091630.A2591@pc9391.uni-regensburg.de> <20040318210128.GB4430@ucw.cz>
In-Reply-To: <20040318210128.GB4430@ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------020104030300000004030807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020104030300000004030807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Vojtech Pavlik wrote:
> On Thu, Mar 18, 2004 at 09:16:30AM +0100, Christian Guggenberger wrote:
> 
> 
>>>>>I repeat.  These messages are appearing when XFree86 is NOT running so 
>>>>>there is no way that it can be the cause of them.
> 
> 
>>>>yeah, sorry. After reading your previous mail I realized it, too.
>>>>If you have some spare time, you could boot with init=/bin/bash and then
>>>>start every boot script step by step to see which one is causing these
>>>>kernel messages.
> 
> 
>>>OK.  As requested, I just did a boot with init=/bin/bash and the bad news 
>>>is that the messages appeared before bash started.  So I think that 
>>>confirms my suspicion that they occur before any of the start scripts are 
>>>invoked?
> 
> 
>>[cc'ed linux-kernel again]
>>Yeah, I do think so.
> 
> 
> Ok. If it appeats with init=/bin/bash and you're not running kbdrate in
> your bashrc or profile,

As far as I can see kbdrate is NOT being run from /etc/bashrc, 
/etc/profile or any script in /etc/profile.d

> then this is likely a kernel or hardware
> problem.

It may be of interest that I've had to use psmouse.proto=imps in order 
to stop problems I was experiencing whereby back scroll on the mouse 
wheel was being interpreted as a right click.  Both the mouse and the 
keyboard are cordless (Logitech Navigator Duo) and are being used via a 
KVM switch (1TEN CS-14).

> 
> Can you please #define DEBUG in drivers/input/serio/i8042.c, recompile,
> boot with init=/bin/bash, and then send me the resulting 'dmesg'?
> Thanks.
> 

dmesg output is attached as requested.  Unfortunately, there's a bit 
missing from the start.  I think this is because the typing I have to do 
to get a writable file system to save dmesg to causes lots of output 
from your debug code.  If the missing output is a problem I can try 
harder to get a complete version.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

--------------020104030300000004030807
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

 i8042 (interrupt, aux, 12) [610]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [610]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [610]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [618]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [618]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [618]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [626]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [626]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [626]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [638]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [638]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [638]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [646]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [646]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [646]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [654]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [654]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [654]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [666]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [666]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [666]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [674]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [674]
drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [674]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [683]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [686]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [690]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, aux, 12) [694]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [694]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [694]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [702]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [702]
drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [702]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [710]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [710]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [710]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [718]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [718]
drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [718]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [726]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [726]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [726]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [738]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [738]
drivers/input/serio/i8042.c: 50 -> i8042 (parameter) [738]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [746]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [746]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [746]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [754]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, aux, 12) [758]
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
drivers/input/serio/i8042.c: d4 -> i8042 (command) [758]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [758]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [766]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [766]
drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [766]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [778]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [778]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [778]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [786]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [786]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [786]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [794]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [794]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [794]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [806]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [806]
drivers/input/serio/i8042.c: ea -> i8042 (parameter) [806]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [814]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [814]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [814]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [818]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [818]
drivers/input/serio/i8042.c: 46 -> i8042 (parameter) [818]
serio: i8042 KBD port at 0x60,0x64 irq 1
drivers/input/serio/i8042.c: 60 -> i8042 (command) [819]
drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [819]
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [820]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [822]
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [826]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [830]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [830]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [837]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [837]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [844]
drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [844]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [850]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [850]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [857]
drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [857]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [863]
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05 15:41:49 2004 UTC).
ALSA device list:
  No soundcards found.
oprofile: using timer interrupt.
NET: Registered protocol family 2
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [866]
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [870]
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [874]
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [878]
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
IP: routing cache hash table of 8192 buckets, 64Kbytes
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [882]
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 296 bytes per conntrack
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [886]
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 144k freed
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, kbd, 1) [3394]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, kbd, 1) [3500]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, kbd, 1) [3713]
drivers/input/serio/i8042.c: 98 <- i8042 (interrupt, kbd, 1) [3805]
drivers/input/serio/i8042.c: 16 <- i8042 (interrupt, kbd, 1) [3993]
drivers/input/serio/i8042.c: 96 <- i8042 (interrupt, kbd, 1) [4093]
drivers/input/serio/i8042.c: 31 <- i8042 (interrupt, kbd, 1) [4260]
drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, kbd, 1) [4371]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, kbd, 1) [4707]
drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, kbd, 1) [4854]
drivers/input/serio/i8042.c: 39 <- i8042 (interrupt, kbd, 1) [5170]
drivers/input/serio/i8042.c: b9 <- i8042 (interrupt, kbd, 1) [5291]
drivers/input/serio/i8042.c: 35 <- i8042 (interrupt, kbd, 1) [6902]
drivers/input/serio/i8042.c: b5 <- i8042 (interrupt, kbd, 1) [7044]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, kbd, 1) [8740]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, kbd, 1) [8846]
drivers/input/serio/i8042.c: 31 <- i8042 (interrupt, kbd, 1) [8996]
drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, kbd, 1) [9103]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, kbd, 1) [9474]
drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, kbd, 1) [9572]
drivers/input/serio/i8042.c: 35 <- i8042 (interrupt, kbd, 1) [10453]
drivers/input/serio/i8042.c: b5 <- i8042 (interrupt, kbd, 1) [10551]
drivers/input/serio/i8042.c: 2c <- i8042 (interrupt, kbd, 1) [11048]
drivers/input/serio/i8042.c: ac <- i8042 (interrupt, kbd, 1) [11227]
drivers/input/serio/i8042.c: 17 <- i8042 (interrupt, kbd, 1) [11359]
drivers/input/serio/i8042.c: 97 <- i8042 (interrupt, kbd, 1) [11443]
drivers/input/serio/i8042.c: 19 <- i8042 (interrupt, kbd, 1) [11926]
drivers/input/serio/i8042.c: 99 <- i8042 (interrupt, kbd, 1) [12044]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, kbd, 1) [13278]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, kbd, 1) [13428]
drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, kbd, 1) [17283]
drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, kbd, 1) [17398]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, kbd, 1) [17539]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, kbd, 1) [17653]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, kbd, 1) [17730]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, kbd, 1) [17837]
drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, kbd, 1) [18098]
drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, kbd, 1) [18273]
drivers/input/serio/i8042.c: 22 <- i8042 (interrupt, kbd, 1) [18560]
drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, kbd, 1) [18693]
drivers/input/serio/i8042.c: 39 <- i8042 (interrupt, kbd, 1) [19279]
drivers/input/serio/i8042.c: b9 <- i8042 (interrupt, kbd, 1) [19387]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [19810]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20063]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20095]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20128]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20160]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20193]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20225]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20257]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20289]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20322]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20354]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20386]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20419]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20451]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20483]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20515]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20548]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20580]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [20612]
drivers/input/serio/i8042.c: 34 <- i8042 (interrupt, kbd, 1) [20634]
drivers/input/serio/i8042.c: b4 <- i8042 (interrupt, kbd, 1) [20726]
drivers/input/serio/i8042.c: aa <- i8042 (interrupt, kbd, 1) [20893]
drivers/input/serio/i8042.c: 39 <- i8042 (interrupt, kbd, 1) [22266]
drivers/input/serio/i8042.c: b9 <- i8042 (interrupt, kbd, 1) [22410]
drivers/input/serio/i8042.c: 35 <- i8042 (interrupt, kbd, 1) [23358]
drivers/input/serio/i8042.c: b5 <- i8042 (interrupt, kbd, 1) [23469]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, kbd, 1) [23835]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, kbd, 1) [23935]
drivers/input/serio/i8042.c: 31 <- i8042 (interrupt, kbd, 1) [24063]
drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, kbd, 1) [24169]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, kbd, 1) [24483]
drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, kbd, 1) [24579]
drivers/input/serio/i8042.c: 35 <- i8042 (interrupt, kbd, 1) [25509]
drivers/input/serio/i8042.c: b5 <- i8042 (interrupt, kbd, 1) [25618]
drivers/input/serio/i8042.c: 2c <- i8042 (interrupt, kbd, 1) [26047]
drivers/input/serio/i8042.c: ac <- i8042 (interrupt, kbd, 1) [26221]
drivers/input/serio/i8042.c: 17 <- i8042 (interrupt, kbd, 1) [26388]
drivers/input/serio/i8042.c: 97 <- i8042 (interrupt, kbd, 1) [26483]
drivers/input/serio/i8042.c: 19 <- i8042 (interrupt, kbd, 1) [26884]
drivers/input/serio/i8042.c: 99 <- i8042 (interrupt, kbd, 1) [27011]
drivers/input/serio/i8042.c: 35 <- i8042 (interrupt, kbd, 1) [27885]
drivers/input/serio/i8042.c: b5 <- i8042 (interrupt, kbd, 1) [27988]
drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, kbd, 1) [28525]
drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, kbd, 1) [28648]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, kbd, 1) [28842]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, kbd, 1) [28941]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, kbd, 1) [29003]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, kbd, 1) [29094]
drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, kbd, 1) [29258]
drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, kbd, 1) [29449]
drivers/input/serio/i8042.c: 22 <- i8042 (interrupt, kbd, 1) [29582]
drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, kbd, 1) [29670]
drivers/input/serio/i8042.c: 34 <- i8042 (interrupt, kbd, 1) [30268]
drivers/input/serio/i8042.c: b4 <- i8042 (interrupt, kbd, 1) [30371]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, kbd, 1) [30900]
drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, kbd, 1) [30995]
drivers/input/serio/i8042.c: 12 <- i8042 (interrupt, kbd, 1) [31167]
drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, kbd, 1) [31291]
drivers/input/serio/i8042.c: 2d <- i8042 (interrupt, kbd, 1) [31510]
drivers/input/serio/i8042.c: ad <- i8042 (interrupt, kbd, 1) [31719]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, kbd, 1) [31760]
drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, kbd, 1) [31823]
drivers/input/serio/i8042.c: 0e <- i8042 (interrupt, kbd, 1) [33690]
drivers/input/serio/i8042.c: 8e <- i8042 (interrupt, kbd, 1) [33795]
drivers/input/serio/i8042.c: 0e <- i8042 (interrupt, kbd, 1) [33887]
drivers/input/serio/i8042.c: 8e <- i8042 (interrupt, kbd, 1) [33952]
drivers/input/serio/i8042.c: 0e <- i8042 (interrupt, kbd, 1) [34042]
drivers/input/serio/i8042.c: 8e <- i8042 (interrupt, kbd, 1) [34086]
drivers/input/serio/i8042.c: 2d <- i8042 (interrupt, kbd, 1) [35022]
drivers/input/serio/i8042.c: ad <- i8042 (interrupt, kbd, 1) [35246]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, kbd, 1) [35286]
drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, kbd, 1) [35351]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, kbd, 1) [35995]

--------------020104030300000004030807--

