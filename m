Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVAOLnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVAOLnl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 06:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVAOLnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 06:43:41 -0500
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:43531 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S262261AbVAOLni convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 06:43:38 -0500
From: "Udo van den Heuvel" <udovdh@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: VIA Rhine ethernet driver bug
Date: Sat, 15 Jan 2005 12:43:33 +0100
Message-ID: <001001c4faf7$71a26230$450aa8c0@hierzo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: High
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On my firewall (VIA EPIA CL-6000 with VIA Rhine network chips running FC3
and custom kernels) I see messages like:

Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x4 length 0 status 00000600!
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame ccf80040 vs
ccf80040.
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x5 length 0 status 00000400!
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame ccf80050 vs
ccf80050.

[...]

Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0xf length 0 status 00000400!
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame ccf800f0 vs
ccf800f0.
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x0 length 0 status 00000400!
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame ccf80000 vs
ccf80000.
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x1 length 0 status 00000400!
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame ccf80010 vs
ccf80010.
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x2 length 0 status 00000400!
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame ccf80020 vs
ccf80020.
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple
buffers, entry 0x3 length 0 status 00000581!
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame ccf80030 vs
ccf80030.

every 3 or 4 days or so when I really use the card. (please notice all 16
entries are used and the length is 0)
Eth1 is connected to an Alcatel Speedtouch Home at 10 Mbits, Half Duplex.
This problem did not occur when I wsa using other hardware for the firewall.

While googlin' I saw that this is an old bug which was not fixed for years.
I am in contact with the maintainer and currently am trying to see what
effect a smaller mtu and/or older driver versions might have.

Because of the impact of this nasty bug (many users have these chips in
their hardware) I would like to ask if others could have a look into this
problem as well. Please email me your experiences (2.6.x kernel? Same bug or
no problem? Fixes? Etc).
PLEASE help!

Thanks,
Udo


