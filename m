Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268167AbUIKPcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268167AbUIKPcI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268165AbUIKPcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:32:08 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:3204 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S268168AbUIKPbg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:31:36 -0400
Date: Sat, 11 Sep 2004 11:31:36 -0400
From: Yaroslav Halchenko <mutt@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: crash of -bk17.  bad: scheduling while atomic!
Message-ID: <20040911153136.GG6735@washoe.rutgers.edu>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel people

I decided to give a try to recent rc1-bk17 moving from 2.6.8-rc3-bk3.

Computer boots but crashes not long after with

Sep 11 11:04:10 ravana kernel: bad: scheduling while atomic!
Sep 11 11:04:10 ravana kernel:  [schedule+1507/1520] schedule+0x5e3/0x5f0
Sep 11 11:04:10 ravana kernel:  [__do_softirq+186/208] __do_softirq+0xba/0xd0
Sep 11 11:04:10 ravana kernel:  [preempt_schedule+42/80] preempt_schedule+0x2a/0x50
Sep 11 11:04:10 ravana kernel:  [udp_sendmsg+753/1696] udp_sendmsg+0x2f1/0x6a0
Sep 11 11:04:10 ravana kernel:  [skb_copy_and_csum_bits+102/752] skb_copy_and_csum_bits+0x66/0x2f0
Sep 11 11:04:10 ravana kernel:  [__wake_up_common+65/112] __wake_up_common+0x41/0x70
Sep 11 11:04:10 ravana kernel:  [inet_sendmsg+77/96] inet_sendmsg+0x4d/0x60
Sep 11 11:04:10 ravana kernel:  [sock_sendmsg+229/256] sock_sendmsg+0xe5/0x100
....

full logs files for boot part of syslog and crash part (which seems to
be looping and producing huge log files) can be found at

http://www.onerussian.com/Linux/bugs/bug.bk17/

I'm going to try pure rc1 version...

-- 
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
             Key  http://www.onerussian.com/gpg-yoh.asc
GPG fingerprint   3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

