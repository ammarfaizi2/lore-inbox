Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVD2LIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVD2LIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVD2LIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:08:36 -0400
Received: from [213.236.237.251] ([213.236.237.251]:15503 "EHLO atmail1")
	by vger.kernel.org with ESMTP id S262285AbVD2LH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:07:58 -0400
Subject: Re: New debugging patch was Re: x86-64 bad pmds in 2.6.11.6 II
From: Hans Kristian Rosbach <hk@isphuset.no>
To: Dave Jones <davej@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Chris Wright <chrisw@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050427173704.GC19011@redhat.com>
References: <20050414170117.GD22573@wotan.suse.de>
	 <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com>
	 <20050414181015.GH22573@wotan.suse.de>
	 <20050414181133.GA18221@wotan.suse.de>
	 <20050414182712.GG493@shell0.pdx.osdl.net>
	 <20050415172408.GB8511@wotan.suse.de>
	 <20050415172816.GU493@shell0.pdx.osdl.net>
	 <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com>
	 <20050415180703.GA26289@redhat.com> <20050427142343.GN13305@wotan.suse.de>
	 <20050427173704.GC19011@redhat.com>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Message-Id: <1114772842.6781.18.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 29 Apr 2005 13:07:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 19:37, Dave Jones wrote: 
> On Wed, Apr 27, 2005 at 04:23:44PM +0200, Andi Kleen wrote:
>  > 
>  > Could someone who reproduces this problem apply the following
>  > patch and see if the WARN_ON triggers?
>  > 
*snip* 
> I'm up to my eyeballs in other stuff right now, so probably won't
> get a chance to test this personally. I'll add it to the Fedora
> testing rpm however, as 1-2 users are also hitting it.
> 
> I'll let you know if I hear anything back.
> 
> 		Dave

I'm seeing this problem on 2.6.11-1.14_FC3smp, a part of dmesg is
supplied below. (these messages have flooded the buffer).
Kernel was updated from kernel-smp-2.6.9-1.667 yesterday, and no
similar messages was in dmesg at that time after 8 days uptime.

Fedora Core 3 w/latest updates atm
Running Mysql, exim, http + perl, clamav, spamassasin, courier.

Tyan motherboard, dual AMD 246, 4x512MB ram (one on each bus),
two 3ware 9xx, dual broadcom nic. (lspci output below)

I have not tried the testing kernel you suggested, but will see what
time will allow today. We already have a scheduled reboot on it so
maybe I'll just sneak in a kernel update again.

More info available on request.

-HK


# uptime
12:57:50 up  4:03,  1 user,  load average: 1.85, 1.87, 1.74

# lspci
00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev
03)
00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
(rev 12)
00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
(rev 12)
00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
01:03.0 RAID bus controller: 3ware Inc 3ware Inc 3ware 9xxx-series
SATA-RAID
02:03.0 RAID bus controller: 3ware Inc 3ware Inc 3ware 9xxx-series
SATA-RAID
02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 03)
02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 03)
03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
03:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 10)


# lsmod
Module                  Size  Used by
md5                     5953  1
ipv6                  297665  52
autofs4                24521  0
sunrpc                169017  1
xfs                   563953  1
exportfs                8385  1 xfs
dm_mod                 69761  0
video                  20169  0
button                  9185  0
battery                12233  0
ac                      6857  0
i2c_amd8111             8129  0
i2c_core               28353  1 i2c_amd8111
hw_random               7393  0
e100                   42305  0
mii                     7105  1 e100
tg3                    91717  0
reiserfs              276665  3
3w_9xxx                38725  6
sd_mod                 20929  8
scsi_mod              155665  2 3w_9xxx,sd_mod


Part of dmesg:
mm/memory.c:97: bad pmd ffff810059861a80(000000000000000b).
mm/memory.c:97: bad pmd ffff810059861a90(000000000000000c).
mm/memory.c:97: bad pmd ffff810059861aa0(000000000000000d).
mm/memory.c:97: bad pmd ffff810059861ab0(000000000000000e).
mm/memory.c:97: bad pmd ffff810059861ac0(0000000000000017).
mm/memory.c:97: bad pmd ffff810059861ad0(000000000000000f).
mm/memory.c:97: bad pmd ffff810059861ad8(00007ffffffffaf8).
mm/memory.c:97: bad pmd ffff810059861af8(000034365f363878).
mm/memory.c:97: bad pmd ffff810074cb7878(0000003926400a88).
mm/memory.c:97: bad pmd ffff810074cb7880(0000000000000004).
mm/memory.c:97: bad pmd ffff810074cb7888(00007ffffffffb00).
mm/memory.c:97: bad pmd ffff810074cb7890(00007ffffffffb01).
mm/memory.c:97: bad pmd ffff810074cb7898(00007ffffffffb02).
mm/memory.c:97: bad pmd ffff810074cb78a0(00007ffffffffb03).
mm/memory.c:97: bad pmd ffff810074cb78b0(00007ffffffffb04).
mm/memory.c:97: bad pmd ffff810074cb78b8(00007ffffffffb05).
mm/memory.c:97: bad pmd ffff810074cb78c0(00007ffffffffb06).
mm/memory.c:97: bad pmd ffff810074cb78c8(00007ffffffffb07).
mm/memory.c:97: bad pmd ffff810074cb78d0(00007ffffffffb08).
mm/memory.c:97: bad pmd ffff810074cb78d8(00007ffffffffb09).
mm/memory.c:97: bad pmd ffff810074cb78e0(00007ffffffffb0a).
mm/memory.c:97: bad pmd ffff810074cb78e8(00007ffffffffb0b).
mm/memory.c:97: bad pmd ffff810074cb78f0(00007ffffffffb0c).
mm/memory.c:97: bad pmd ffff810074cb78f8(00007ffffffffb0d).
mm/memory.c:97: bad pmd ffff810074cb7900(00007ffffffffb0e).
mm/memory.c:97: bad pmd ffff810074cb7908(00007ffffffffb0f).
mm/memory.c:97: bad pmd ffff810074cb7910(00007ffffffffb10).
mm/memory.c:97: bad pmd ffff810074cb7918(00007ffffffffb11).
mm/memory.c:97: bad pmd ffff810074cb7920(00007ffffffffb12).
mm/memory.c:97: bad pmd ffff810074cb7928(00007ffffffffb13).
mm/memory.c:97: bad pmd ffff810074cb7930(00007ffffffffb14).
mm/memory.c:97: bad pmd ffff810074cb7938(00007ffffffffb15).
mm/memory.c:97: bad pmd ffff810074cb7940(00007ffffffffb16).
mm/memory.c:97: bad pmd ffff810074cb7948(00007ffffffffb17).
mm/memory.c:97: bad pmd ffff810074cb7950(00007ffffffffb18).
mm/memory.c:97: bad pmd ffff810074cb7958(00007ffffffffb19).
mm/memory.c:97: bad pmd ffff810074cb7960(00007ffffffffb1a).
mm/memory.c:97: bad pmd ffff810074cb7968(00007ffffffffb1b).
mm/memory.c:97: bad pmd ffff810074cb7970(00007ffffffffb1c).
mm/memory.c:97: bad pmd ffff810074cb7978(00007ffffffffb1d).
mm/memory.c:97: bad pmd ffff810074cb7980(00007ffffffffb1e).
mm/memory.c:97: bad pmd ffff810074cb7988(00007ffffffffb1f).
mm/memory.c:97: bad pmd ffff810074cb7990(00007ffffffffb20).
mm/memory.c:97: bad pmd ffff810074cb7998(00007ffffffffb21).
mm/memory.c:97: bad pmd ffff810074cb79a0(00007ffffffffb22).
mm/memory.c:97: bad pmd ffff810074cb79a8(00007ffffffffb23).
mm/memory.c:97: bad pmd ffff810074cb79b0(00007ffffffffb24).
mm/memory.c:97: bad pmd ffff810074cb79b8(00007ffffffffb25).
mm/memory.c:97: bad pmd ffff810074cb79c0(00007ffffffffb26).
mm/memory.c:97: bad pmd ffff810074cb79c8(00007ffffffffb27).
mm/memory.c:97: bad pmd ffff810074cb79d0(00007ffffffffb28).
mm/memory.c:97: bad pmd ffff810074cb79d8(00007ffffffffb29).
mm/memory.c:97: bad pmd ffff810074cb79e0(00007ffffffffb2a).
mm/memory.c:97: bad pmd ffff810074cb79f0(0000000000000010).
mm/memory.c:97: bad pmd ffff810074cb79f8(00000000078bfbff).
mm/memory.c:97: bad pmd ffff810074cb7a00(0000000000000006).
mm/memory.c:97: bad pmd ffff810074cb7a08(0000000000001000).
mm/memory.c:97: bad pmd ffff810074cb7a10(0000000000000011).
mm/memory.c:97: bad pmd ffff810074cb7a18(0000000000000064).
mm/memory.c:97: bad pmd ffff810074cb7a20(0000000000000003).
mm/memory.c:97: bad pmd ffff810074cb7a28(0000000000400040).
mm/memory.c:97: bad pmd ffff810074cb7a30(0000000000000004).
mm/memory.c:97: bad pmd ffff810074cb7a38(0000000000000038).
mm/memory.c:97: bad pmd ffff810074cb7a40(0000000000000005).
mm/memory.c:97: bad pmd ffff810074cb7a48(0000000000000008).
mm/memory.c:97: bad pmd ffff810074cb7a50(0000000000000007).
mm/memory.c:97: bad pmd ffff810074cb7a60(0000000000000008).
mm/memory.c:97: bad pmd ffff810074cb7a70(0000000000000009).
mm/memory.c:97: bad pmd ffff810074cb7a78(0000000000401480).
mm/memory.c:97: bad pmd ffff810074cb7a80(000000000000000b).
mm/memory.c:97: bad pmd ffff810074cb7a90(000000000000000c).
mm/memory.c:97: bad pmd ffff810074cb7aa0(000000000000000d).
mm/memory.c:97: bad pmd ffff810074cb7ab0(000000000000000e).
mm/memory.c:97: bad pmd ffff810074cb7ac0(0000000000000017).
mm/memory.c:97: bad pmd ffff810074cb7ad0(000000000000000f).
mm/memory.c:97: bad pmd ffff810074cb7ad8(00007ffffffffaf9).
mm/memory.c:97: bad pmd ffff810074cb7af8(0034365f36387800).


