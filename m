Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUCNRut (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 12:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUCNRut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 12:50:49 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:61837 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261463AbUCNRur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 12:50:47 -0500
Date: Sun, 14 Mar 2004 12:49:41 -0500 (EST)
From: Richard A Nelson <kenpocowboy@bellsouth.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6 IPSEC and NAT issue
Message-ID: <Pine.LNX.4.58.0403141240510.1855@onpx40.onqynaqf.bet>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


An odd difference betwixt 2.4/Freeswan and 2.6/IPSEC has been driving
me nuts - can anyone help ?

I've got a box on the local lan (192.168.1.0/24) that creates a tunnel
to a VPN server via ipsec.
	* On 2.4/Freeswan, lan traffic is eth0 and tunnel is ipsec0
	* On 2.6.4/IPSEC, both lan and tunnel is through eth0

I need to be able to NAT lan traffic across the VPN.  On 2.4/Freeswan
this was trivial with
	iptables -t nat -o eth0 -s 192.168.1.0/24 -j MASQUERADE
	and, of course, allowing forwarding betwixt the interfaces

On 2.6/IPSEC, this setup doesn't seem to be working at all (no changes
have been done to the iptables rules) - traffic comming in eth0 is
either not NAT'd (haven't been able to check upstream traffic yet),
but in anycase I see no response to lan traffic that should've gone
out the tunnel
-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya
