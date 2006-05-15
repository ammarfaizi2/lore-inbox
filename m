Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWEOJff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWEOJff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWEOJff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:35:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:10454 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932347AbWEOJff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:35:35 -0400
Message-ID: <44684B60.1070705@am-anger-1.de>
Date: Mon, 15 May 2006 11:35:28 +0200
From: Heiko Gerstung <heiko@am-anger-1.de>
User-Agent: Mail/News 1.5 (X11/20060322)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug related to bonding
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:25672344472c4ac2bbe53bd9833f99fb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am at a total loss with this one.  My vanilla 2.4.32 crashes when I
try to use bonding together with my rtl8150 based (USB-Ethernet) NICs.
If this is a known error, I apologize for bothering the list and would
appreciate any pointers to a working solution/workaround.

Reproduce:
# modprobe bonding mode=1 miimon=100 maxbonds=4
# ifconfig bond0 172.16.10.111 netmask 255.255.255.0 up
# ifenslave bond0 eth1 eth2
Ethernet Channel Bonding Driver: v2.6.0 (January 14, 2004)
bonding: MII link monitoring set to 100 ms
00:60:6E:30:07:Scheduling in interrupt
kernel BUG at sched.c:564!
invalid operand: 0000
CPU:     0
EIP:      0010:[<c011461d>]    Not tainted
EFLAGS:  00010282
...(following the CPU registers and Call Trace)....

Please let me know which details I have to provide from the bug message
(I have to type it in manually, no copy'n'paste possible:-)).

It is not clear to me whether this is a bug in the bonding module, in
the network driver or in the kernel itself.
All 2.6.x kernels I tried worked fine, but I am currently bound to a
2.4.x kernel and all 2.4.x kernels I tried (2.4.20, 2.4.29) showed
similiar problems when activating bonding.

Thank you in advance,
kind regards,
Heiko

