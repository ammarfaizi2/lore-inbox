Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264989AbSJWNdR>; Wed, 23 Oct 2002 09:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264988AbSJWNdR>; Wed, 23 Oct 2002 09:33:17 -0400
Received: from user19.okena.com ([65.196.32.19]:26093 "EHLO
	gatemaster.okena.com") by vger.kernel.org with ESMTP
	id <S264989AbSJWNdP>; Wed, 23 Oct 2002 09:33:15 -0400
From: Slavcho Nikolov <snikolov@okena.com>
To: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Message-ID: <004c01c27a99$927b8a30$800a140a@SLNW2K>
References: <20021023003959.GA23155@bougret.hpl.hp.com>
Subject: Re: feature request - why not make netif_rx() a pointer?
Date: Wed, 23 Oct 2002 09:39:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, I cannot assume that every L2 (or maybe I can, we'll see) is
ethernet and I definitely cannot know in advance that every L3 is IP.
Nor can the assumption be made that netfilter has been built into the
kernel.
If I define my own private protocol handler (to catch all), I see cloned
skb's
which is not what I want. I tried that and dropped each one of them in the
handler, yet traffic continued to flow unimpeded (so I must have dropped
clones).
As for GPL, I hope that commercial enterprises be allowed to utilize
business models
which do not necessarily consist in providing services around free software.
The more replaceable hooks you provide to filesystems and network stacks,
the better.
S.N.


| Assuming that every L2 is Ethernet and every L3 is IP ?
| Well, I've got news for you : IrDA drivers are using
| netif_rx() to pass IrLAP frames to the IrDA stack, and 802.11 driver
| in the future will pass 802.11 frames to the 802.2 LLC layer via
| netif_rx().
| Please don't do that, I don't want people breaking the IrDA
| stack in weird ways just because some random clueless code hijacked
| netif_rx(). Use netfilters, or define your own private protocol/packet
| type to do what you want.


