Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267287AbUIEWEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267287AbUIEWEt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUIEWEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:04:49 -0400
Received: from levante.wiggy.net ([195.85.225.139]:36481 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S267287AbUIEWEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:04:47 -0400
Date: Mon, 6 Sep 2004 00:04:45 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Oops when removing processor and thermal module
Message-ID: <20040905220445.GG7471@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the oops below when doing 'rmmod thermal ; rmmod processor' on
a 2.6.8.1 system. Interestingly enough it only happens the first time
I do that: if I reload the modules and rmmod them again.

Unable to handle kernel paging request at virtual address e091123a
 printing eip:
e091123a
*pde = 1ff20067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: ieee80211_crypt_wep radeon rfcomm l2cap bluetooth sd_mod ipw2100 ieee80211 ieee80211_crypt yenta_socket pcmcia_core tg3 snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_mpu401_uart snd_rawmidi ehci_hcd uhci_hcd usbcore intel_agp
CPU:    0
EIP:    0060:[<e091123a>]    Not tainted
EFLAGS: 00010216   (2.6.8.1) 
EIP is at 0xe091123a
eax: 00aa77a9   ebx: 00000808   ecx: 00aa6b2b   edx: 00000808
esi: dff596b0   edi: c0424120   ebp: dff59600   esp: c03fdfbc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03fc000 task=c0376a40)
Stack: 00099100 00000001 c03fc000 00099100 c0424120 00470007 c01030e4 c03fc000 
       c03fe723 c0376a40 00000000 c041bd10 0000002a c03fe340 c0424b80 00000816 
       c010019f 
Call Trace:
 [<c01030e4>] cpu_idle+0x34/0x40
 [<c03fe723>] start_kernel+0x163/0x180
 [<c03fe340>] unknown_bootoption+0x0/0x160
Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing


-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
