Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUGYOMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUGYOMW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 10:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUGYOMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 10:12:22 -0400
Received: from wit.mht.bme.hu ([152.66.80.190]:9628 "EHLO wit.wit.mht.bme.hu")
	by vger.kernel.org with ESMTP id S261169AbUGYOMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 10:12:20 -0400
Date: Sun, 25 Jul 2004 16:12:18 +0200 (CEST)
From: Ferenc Kubinszky <ferenc.kubinszky@wit.mht.bme.hu>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-velocity problem
In-Reply-To: <20040725002518.A14684@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.44.0407251603190.23775-100000@wit.wit.mht.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


On Sun, 25 Jul 2004, Francois Romieu wrote:

>
> It looks like the suspect (eth0) registers an event notifier and goes
> foobar when the other interface (lo) triggers an NETDEV_UP.
>
> Can you try the (gross) patch below against 2.6.8-rc1-mm1 ?

I patched the kernel and copied the driver into 2.6.8-rc2.
Now i does not hang the machine at all, but there is an other problem.
When I try to send or receive larger amount of data, something goes wrong.
If I ping with 64 byte packets it is good regardless of the time interval.
But when 1000 byte long packets are used with ping or just wget something,
there are mysterious errors:
ping response time goes up and down (approx 50msec..5000ms)
wget become stalled after ~100kbytes and tcpdump shows broken ip packets.

I'm not sure where is the error, in my card, my cable modem or at the
TV-NET provider.

With my e100 everithing OK.

Best regards,
Kubi

