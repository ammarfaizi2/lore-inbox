Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261516AbSJDHfp>; Fri, 4 Oct 2002 03:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261517AbSJDHfp>; Fri, 4 Oct 2002 03:35:45 -0400
Received: from gw.itelsat.com.ua ([193.41.161.98]:19465 "EHLO
	gw.itelsat.com.ua") by vger.kernel.org with ESMTP
	id <S261516AbSJDHfo>; Fri, 4 Oct 2002 03:35:44 -0400
Date: Fri, 4 Oct 2002 10:47:03 +0300
From: Denis Fedorishenko <nuclearcat@nuclearcat.com>
X-Mailer: The Bat! (v1.61)
Reply-To: Denis Fedorishenko <nuclearcat@nuclearcat.com>
Organization: Private
X-Priority: 3 (Normal)
Message-ID: <6788034296.20021004104703@nuclearcat.com>
To: linux-kernel@vger.kernel.org
Subject: ip_conntrack problem / perfomance
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr. linux-net@vger.kernel.org !

I got some problem with conntrack. Very strange problems...

1st - i compile it as module on RedHat kernel 2.4.18-3custom.
I have NAT on this machine, and have users who work on it.
When i start benchmark (polygraph + proxy server) on same host -
perfomance is ~800 req/s.

2nd - i have another, same configuration PC, and have compiled in (not
as module) 2.4.18-10custom and 2.4.20-pre8-ac3 kernel. When it
compiled in - i have at starts ~800 req/s and after 10-20 seconds it
decrease to ~200req/s. If i compile ip_conntrack as module, and not use
ip_conntrack - 1000 req/s. If use as module - decrease to 200 req/s.

I have questions:

1)Is a possible to use any alternative hash for ip_conntrack or like
this?
2)Why conntrack track all requests (for example local) and what way to
drop this tracks, but i still need ip_conntrack to NAT?
3)Any other suggestions?

About hardware:
2xPIII|1.3Ghz / ServerWorks / 2xEtherExpress/100 /1GB RAM

Also in logs, not always, but i see messages like "ip_conntrack: table
full, dropping packet.", but on 2.4.18-custom3 i see this messages
too... but it works 800 req/s :)

Thank you!
-----------------------------------------------------------------------------------------
Fedorishenko Denis Olegovich
nuclearcat@nuclearcat.com * Tel: +380 679322793
www.nuclearcat.com * www.planetsky.org * www.itelsat.org

