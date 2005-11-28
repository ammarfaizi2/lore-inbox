Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVK1No5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVK1No5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 08:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVK1No5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 08:44:57 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:53679 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S932092AbVK1No4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 08:44:56 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
Date: Mon, 28 Nov 2005 13:44:55 +0000 (UTC)
Organization: Cistron
Message-ID: <dmf1kn$t2s$1@news.cistron.nl>
References: <20051128123601.GA32346@king.bitgnome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1133185495 29788 194.109.0.112 (28 Nov 2005 13:44:55 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@zahadum.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20051128123601.GA32346@king.bitgnome.net>,
Mark Nipper  <nipsy@bitgnome.net> wrote:
>        I received the following in my system logs recently:
>---
>Nov 27 22:56:20 king kernel: KERNEL: assertion (!sk->sk_forward_alloc)
>failed at net/core/stream.c (279)
>Nov 27 22:56:20 king kernel: KERNEL: assertion (!sk->sk_forward_alloc)
>failed at net/ipv4/af_inet.c (151)
>
>        All I could find related to this was some potential bugs
>mentioned in 2.6.9 and in particular with relation to TSO.
>However, I'm running a vanilla 2.6.13.4 at the moment.  But, I do
>have an e1000 and checking ethtool does show TSO on.

I'm seeing the same on 2.6.14.2, also with e1000. It wasn't there on
2.6.11.12 which I was running previously.

# dmesg | tail -4
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (148)
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (148)

# ethtool -k eth0
Offload parameters for eth0:
rx-checksumming: on
tx-checksumming: on
scatter-gather: on
tcp segmentation offload: on

Mike.

