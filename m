Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTJ0MW0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbTJ0MW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:22:26 -0500
Received: from f17.mail.ru ([194.67.57.47]:29451 "EHLO f17.mail.ru")
	by vger.kernel.org with ESMTP id S261606AbTJ0MWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:22:24 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: =?koi8-r?Q?=22?=Jan Ploski=?koi8-r?Q?=22=20?= <jpljpl@gmx.de>
Subject: Re:  2.6.0-testX and pppd/pppoe stuck after connecting
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [212.30.182.96]
Date: Mon, 27 Oct 2003 15:22:22 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AE6O6-000KbW-00.arvidjaar-mail-ru@f17.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ever since I upgraded from 2.4.18 to 2.6.0-test? (now -test8),
> I have been encountering problems with my pppd/pppoe setup.
> Specifically, right after the ppp0 interface is brought up, and several
> packets go through that interface (4-5 packets RX/TX), no more packets
> are transmitted until I restart pppd and reconnect to my ISP.
> ping www.google.com will report 100% packet loss, and I cannot see the
> TX packet count on ppp0 increasing. Nothing suspicious appears in ppp.log.
> More often than not, I have to reconnect multiple times until at last
> a working connection is established.

I can confirm it with 2.6.0-test8 and simple modem connection (no pppoe). Connection
is established, I get IP, DNS - everything but no IP packet ever seems to either go out
or come in. The same works just fine with 2.6.0-test5; I have not tried intermediate
versions. Probably if test9 is going to have the same problem I will have to. This happens
every time on boot of test8 and works every time under test5

the system is Mandrake 9.2 without updates, compiler gcc-3.3.1 as shipped with
mdk 9.2. previous kernel was compiled under mdk 9.1 with whatever compiler it
had.

Enabling pppd debugging does not show anything interesting except it gets LCP
echo from remote so some data _is_ flowing between systems. Enabling iptables
LOG for all packets shows that packets _are_ submitted to ppp0.

So it looks like for whatever resons ppp0 either does not receive packet passed to it
or never processes them.

As my knowledge of networking layer is near to zero, I appreciate pointers to where
I can enable debugging, printk or whatever.

TIA

-andrey



