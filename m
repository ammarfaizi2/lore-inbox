Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUFGVmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUFGVmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUFGVmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:42:24 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:60669 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S265091AbUFGVhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:37:37 -0400
Date: Mon, 7 Jun 2004 23:28:04 +0200
From: Roger Luethi <rl@hellgate.ch>
To: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [RFC] ethtool semantics
Message-ID: <20040607212804.GA17012@k3.hellgate.ch>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.7-rc1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the correct response if a user passes ethtool speed or duplex
arguments while autoneg is on? Some possible answers are:

a) Yell at the user for doing something stupid.

b) Fail silently (i.e. ignore command).

c) Change advertised value accordingly and initiate new negotiation.

d) Consider "autoneg off" implied, force media accordingly.

The ethtool(8) man page I'm looking at doesn't address that question. The
actual behavior I've seen is b) which is by far my least preferred
solution.

Roger
