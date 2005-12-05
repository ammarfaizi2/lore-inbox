Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVLERyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVLERyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVLERyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:54:01 -0500
Received: from 75.red-82-159-197.user.auna.net ([82.159.197.75]:33702 "EHLO
	indy.cmartin.tk") by vger.kernel.org with ESMTP id S1751256AbVLERyA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:54:00 -0500
From: Carlos =?iso-8859-1?q?Mart=EDn?= <carlos@cmartin.tk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm1
Date: Mon, 5 Dec 2005 08:49:03 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20051204232153.258cd554.akpm@osdl.org>
In-Reply-To: <20051204232153.258cd554.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512050749.03673.carlos@cmartin.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 08:21, Andrew Morton wrote:
> 
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/

Hi,

 I've been getting these:

Dec 27 14:32:45 kiopa kernel: BUG: soft lockup detected on CPU#1!
Dec 27 14:32:45 kiopa kernel: CPU 1:
Dec 27 14:32:45 kiopa kernel: Modules linked in: ipv6 parport_pc parport 
psmouse ns558 analog pcspkr snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm 
gameport ohci_hcd snd_timer ide_cd cdrom forcedeth snd ehci_hcd usbcore 
snd_page_alloc evdev unix
Dec 27 14:32:45 kiopa kernel: Pid: 0, comm: swapper Not tainted 2.6.15-rc5-mm1 
#2
Dec 27 14:32:45 kiopa kernel: RIP: 0010:[<ffffffff80311453>] 
<ffffffff80311453>{_spin_unlock_irq+19}
Dec 27 14:32:45 kiopa kernel: RSP: 0000:ffff810001ffbf08  EFLAGS: 00000246
Dec 27 14:32:45 kiopa kernel: RAX: ffff810001ff3fd8 RBX: ffff810001ffbe58 RCX: 
ffffffff8040fba0
Dec 27 14:32:45 kiopa kernel: RDX: 0000000000000001 RSI: ffff810001e19ad8 RDI: 
ffff810001e18c20
Dec 27 14:32:45 kiopa kernel: RBP: ffffffff8010e354 R08: 00000000000000e9 R09: 
0000000000000000
Dec 27 14:32:45 kiopa kernel: R10: 0000000000000000 R11: ffff810001e17660 R12: 
ffffffff8014cd49
Dec 27 14:32:45 kiopa kernel: R13: ffffffff801106ff R14: ffff810001ff3f18 R15: 
ffff810001ffbf18
Dec 27 14:32:45 kiopa kernel: FS:  0000000000000000(0000) GS:ffffffff8041c080
(0000) knlGS:00000000556b26c0
Dec 27 14:32:45 kiopa kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 
000000008005003b
Dec 27 14:32:45 kiopa kernel: CR2: 0000000056b8d012 CR3: 000000003cc2c000 CR4: 
00000000000006e0
Dec 27 14:32:45 kiopa kernel: 
Dec 27 14:32:45 kiopa kernel: Call Trace: <IRQ> 
<ffffffff80311449>{_spin_unlock_irq+9} 
<ffffffff8810db70>{:ipv6:addrconf_verify+0}
Dec 27 14:32:45 kiopa kernel:        
<ffffffff8014d0e2>{run_ktimeout_softirq+370} 
<ffffffff801394c4>{__do_softirq+100}
Dec 27 14:32:45 kiopa kernel:        <ffffffff8010f166>{call_softirq+30} 
<ffffffff801106bc>{do_softirq+44}
Dec 27 14:32:45 kiopa kernel:        <ffffffff801391a8>{irq_exit+72} 
<ffffffff8010e9ca>{apic_timer_interrupt+98}
Dec 27 14:32:45 kiopa kernel:         <EOI> 
<ffffffff80311449>{_spin_unlock_irq+9} <ffffffff8030fed0>{thread_return+95}
Dec 27 14:32:45 kiopa kernel:        <ffffffff8010c69d>{default_idle+45} 
<ffffffff8010c731>{cpu_idle+97}
Dec 27 14:32:45 kiopa kernel:        <ffffffff80433ea5>{start_secondary+1253}

The full log is at http://www.cmartin.tk/linux/dmesg.bz2 which is 7.9M 
uncompressed, with just the logs from the last boot.

The date is wrong because this is a second boot. Time goes extremely fast. 
When I rebooted into an older kernel it said it was the 8th July 2006!

The system halts for up to a minute (I got a console login timeout out after 
60secs). The keyboard lights still change, but the cursor on the screen stays 
put. After a bit things return to normal for a bit, repeat until reboot.

   cmn
-- 
Carlos Martín       http://www.cmartin.tk
