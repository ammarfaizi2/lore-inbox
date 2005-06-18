Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVFRPDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVFRPDx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 11:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVFRPDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 11:03:53 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:36757 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262133AbVFRO55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 10:57:57 -0400
Date: Sat, 18 Jun 2005 16:57:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Rankin <rankincj@yahoo.com>
cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12: connection tracking broken?
In-Reply-To: <20050618124359.39052.qmail@web52901.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0506181656250.20828@yvahk01.tjqt.qr>
References: <20050618124359.39052.qmail@web52901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>I have just tried upgrading my firewall to 2.6.12, but neither of the following rules in my
>FORWARD table was allowing return traffic:

You forget about INPUT and OUTPUT. If you drop everything in INPUT, there's 
nothing to FORWARD.

> 1109  814K ACCEPT     all  --  ppp0   br0     anywhere             anywhere         ctstate
>RELATED,ESTABLISHED
>  11M   13G ACCEPT     all  --  ppp0   br0     anywhere             anywhere         state
>RELATED,ESTABLISHED
>
>I have currently returned to using 2.6.11.11, where the identical configuration works fine. br0 is
>a bridge device containing two e100 devices, and ppp0 is my PPPoE DSL link. I am using iptables
>1.3.1.


Jan Engelhardt                                                               
--                                                                            
| Gesellschaft fuer Wissenschaftliche Datenverarbeitung Goettingen,
| Am Fassberg, 37077 Goettingen, www.gwdg.de
