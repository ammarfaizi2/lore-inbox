Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUF1NWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUF1NWj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 09:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUF1NWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 09:22:39 -0400
Received: from news.cistron.nl ([62.216.30.38]:29323 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S264937AbUF1NWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 09:22:38 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: TCP-RST Vulnerability - Doubt
Date: Mon, 28 Jun 2004 13:22:37 +0000 (UTC)
Organization: Cistron Group
Message-ID: <cbp62t$a38$1@news.cistron.nl>
References: <40DC9B00@webster.usu.edu> <20040625150532.1a6d6e60.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1088428957 10344 62.216.29.200 (28 Jun 2004 13:22:37 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040625150532.1a6d6e60.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:
>RFC2385 MD5 hashing support is going in soon, and for the application where
>the vulnerability actually matters (BGP sessions between backbone routers)
>MD5 clears that problem right up and they're all using MD5 protection already
>anyways.

MD5 protection on BGP sessions isn't very common yet. MD5 uses CPU,
and routers don't usually have much of that. Which means that now an
MD5 CPU attack is possible instead of a TCP RST attack.

The "TTL hack" solution is safer. Make sure sender uses a TTL
of 255, on the receiver discard all packets with a TTL < 255.
You can use iptables to implement that on a Linux box.

Mike.

