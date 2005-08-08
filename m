Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVHHMPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVHHMPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 08:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVHHMPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 08:15:07 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:14561 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1750772AbVHHMPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 08:15:07 -0400
From: dth@picard.cistron.nl (Danny ter Haar)
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes.  Also some X trouble.
Date: Mon, 8 Aug 2005 12:14:52 +0000 (UTC)
Organization: Cistron
Message-ID: <dd7ibs$8vm$1@news.cistron.nl>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <20050805150506.703e804f.akpm@osdl.org> <dd5f2j$fj7$1@news.cistron.nl> <42F7419E.3060905@aitel.hist.no>
X-Trace: ncc1701.cistron.net 1123503292 9206 62.216.30.70 (8 Aug 2005 12:14:52 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@picard.cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting  <helge.hafting@aitel.hist.no> wrote:
>Danny ter Haar wrote:
>>What i dont "get" is that ethernet also goes down when the scsi
>>controller goes bezerk.
>>I'm pretty sure it's not a hardware problem since 2.6.12-mm1 survives
>>and brings this usenet host in the worldwide top 1000.
>Interesting. 
>I have no idea what the core problem is, but one problem will often lead
>to others.  My scsi problem froze some apps that couldn't be paged in
>from the "failing" disk, for example.


I found out in the mean time that ethernet&scsi controller share the
same IRQ, so it's even sort op logical i guess

irq 25: aic79xx, eth3 (although ath0 was complaining)

>rc5 is no good for amd64, and it doesn't need power management to go wrong.

rc6 [KNOCK WOOD] seems to work just (so far)


dth@newsgate:~$ procinfo
Linux 2.6.13-rc6 (root@newsgate) (gcc [can't parse]) #???  1CPU [newsgate.(none)]
Memory:      Total        Used        Free      Shared     Buffers
Mem:       2058040     2040104       17936           0         476
Swap:            0           0           0
Bootup: Sun Aug  7 22:06:08 2005    Load average: 3.62 3.64 3.55 4/66 1277
user  :       1:44:42.21  10.8%  page in :        0
nice  :       0:11:21.95   1.2%  page out:        0
system:       4:56:19.28  30.7%  swap in :        0
idle  :       0:06:15.61   0.6%  swap out:        0
uptime:      16:06:08.94         context :169218538
irq  0:  14486202 timer                 irq 12:         3
irq  1:         8 i8042                 irq 24:  18536343 aic79xx
irq  2:         0 cascade [4]           irq 25: 175472322 aic79xx, eth3
irq  4:       350 serial                irq 28: 286219024 acenic

-------

Linux newsgate 2.6.13-rc6 #1 Sun Aug 7 21:27:42 CEST 2005 x86_64 GNU/Linux
Gnu C                  4.0.2
Gnu make               3.80
binutils               2.16.1
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.2
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         genrtc evdev hw_random i2c_amd8111 tg3 e100 mii w83627hf eeprom lm85 i2c_sensor i2c_isa i2c_amd756 i2c_core rawfs psmouse

Looks promissing.

Danny

