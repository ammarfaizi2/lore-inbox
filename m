Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUHWWrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUHWWrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUHWWqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:46:13 -0400
Received: from av13-1-sn4.m-sp.skanova.net ([81.228.10.104]:42199 "EHLO
	av13-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S267721AbUHWWbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:31:15 -0400
Date: Tue, 24 Aug 2004 00:31:14 +0200 (CEST)
Message-Id: <200408232231.i7NMVEh13558@d1o408.telia.com>
From: "Voluspa" <lista4@comhem.se>
Reply-To: "Voluspa" <lista4@comhem.se>
To: "Patrick McHardy" <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0
X-Mailer: SF Webmail
X-SF-webmail-clientstamp: [213.64.150.229] 2004-08-24 00:31:14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

citerar Patrick McHardy:

> Did you also apply this patch ? If not, please try it and tell us
> if it helps.

No, haven't seen that one before. Ok, results:

01-2.6-cbq-leaks.diff aka [PKT_SCHED]: Fix class leak in CBQ scheduler
plus
[PKT_SCHED]: cacheline-align qdisc data in qdisc_create()

_Clean environment_

"shutdown -r now": OK
"rmmod 8139too"  : OK

_QoS through wshaper script_

"shutdown -r now": OK
"rmmod 8139too"  : OK

_Compiled kernel for size, no debugging_

Rest of my modules loaded. As above: OK and OK

Nice work. Thanks.

Mvh
Mats Johannesson

