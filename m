Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268529AbUIGS4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268529AbUIGS4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUIGShI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:37:08 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:45489 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268506AbUIGSef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:34:35 -0400
Date: Tue, 7 Sep 2004 13:33:32 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Roland Dreier <roland@topspin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Michael.Waychison@Sun.COM,
       plars@linuxtestproject.org, Brian.Somers@Sun.COM,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040907133332.4ceb3b5a@localhost>
In-Reply-To: <52ekljq6l2.fsf@topspin.com>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com>
	<412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com>
	<412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com>
	<412DC055.4070401@sun.com>
	<20040830161126.585a6b62.davem@davemloft.net>
	<1094238777.9913.278.camel@plars.austin.ibm.com>
	<4138C3DD.1060005@sun.com>
	<52acw7rtrw.fsf@topspin.com>
	<20040903133059.483e98a0.davem@davemloft.net>
	<52ekljq6l2.fsf@topspin.com>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     Setting up network interfaces:
>         lo
>         lo        IP address: 127.0.0.1/8                                 done
>         dummy0
>         dummy0    No configuration found for dummy0                       unused
>         eth0      device: Broadcom Corporation NetXtreme BCM5
>     system>
>     system> console -T system:blade[11]
>     SOL is not ready

Whenever an adapter reset is done (eg ifconfig up) on the same adapter
that SoL is using, you'll lose SoL.  SoL usually comes back, although
I've not had much luck ever since the Sun auto negotiation patch went
in.  One fix/workaround to not losing your SoL connection is having the
network go only over eth1 (assuming you have two switch modules).

Thanks,
Jake
