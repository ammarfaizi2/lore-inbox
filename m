Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbULZIrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbULZIrI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 03:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULZIrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 03:47:08 -0500
Received: from mail.linicks.net ([217.204.244.146]:48388 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261541AbULZIrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 03:47:03 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: kswapd oops - advice on debug
Date: Sun, 26 Dec 2004 08:47:01 +0000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412260847.01250.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Merry Christmas!  Hope you all had a good one.

I need advice on debugging kswapd oops.  I get these on every kernel from 
2.6.5 -> 2.6.9.  2.6.4 performs OK.  I am currently building 2.6.10 to try 
this as I see in changelog there was some work done in this area.  The oops 
is always kswapd writing to and unpaged area (I believe).

I have tried everything...  2.6.4 just works.  2.6.5 -> 2.6.9 can run anywhere 
from 7 to 90 days before I get an oops.  After an oops the system stays up, 
but I cannot login on any terminal and new connections (pop3 etc.) fail.

I can't really give much info, as it all varies, but I really need to sort 
myself so I _can_ give you all correct information.  This is also my gateway, 
so I cannot play around much on this box.

I have new memory coming, so that will also aid to debugging - current memory 
is 128MB with 128MB disc swap and 260MB file swap:

             total       used       free     shared    buffers     cached
Mem:        126872     123032       3840          0      19088      49956
-/+ buffers/cache:      53988      72884
Swap:       398648       1452     397196

The box runs httpd, ntpd, ssh, nfs client, sendmail, spamd, ircd, pop3, 
iptables/NAT, DNS cache server.

File system ext3.  Minimal hardware:

:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX] (rev 23)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] 
(rev 27)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium 
II]

No sound, parport, USB etc.  Barebones.

Any help on what to do to trap this properly much appreciated.

Thanks,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
