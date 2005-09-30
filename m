Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbVI3HKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVI3HKd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 03:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVI3HKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 03:10:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19615
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932568AbVI3HKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 03:10:33 -0400
Date: Fri, 30 Sep 2005 00:10:25 -0700 (PDT)
Message-Id: <20050930.001025.86739685.davem@davemloft.net>
To: chuckw@quantumlinux.com
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, stable@kernel.org,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       rdunlap@xenotime.net, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, mk@linux-ipv6.org
Subject: Re: [PATCH 07/10] [PATCH] check connect(2) status for IPv6 UDP
 socket
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.63.0509292318320.29997@localhost.localdomain>
References: <20050930022016.640197000@localhost.localdomain>
	<20050930022239.411732000@localhost.localdomain>
	<Pine.LNX.4.63.0509292318320.29997@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Wolber <chuckw@quantumlinux.com>
Date: Thu, 29 Sep 2005 23:25:14 -0700 (PDT)

> Does this really qualify as a necessary bug fix?

Yes.  Without this unconnected ipv6 UDP sockets end up using the wrong
route or IPSEC path.
