Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267258AbUH1Pgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267258AbUH1Pgh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUH1Pgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:36:37 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:53265 "EHLO
	smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP id S267258AbUH1Pdg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:33:36 -0400
Date: Sat, 28 Aug 2004 17:33:10 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: 2.6.9-rc1 & 2.6.9-rc1-mm1: can't shutdown / unregister_netdevice complains about my ipv6-in-ipv4 tunnel
Message-ID: <20040828153310.GA25626@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to shutdown my system with both 2.6.9-rc1 and 2.6.9-rc1-mm1,
I see:

unregister_netdevice: waiting for xs6all to become free

etc. when trying to reboot or shutdown.

I didn't see this in 2.6.8.1 nor in 2.6.8.1-mm1.

This is a plain ipv6-over-ipv4 tunnel like this:

/etc/network/interfaces:
auto xs6all
iface xs6all inet6 v4tunnel
        endpoint xxx.xxx.xxx.xxx
        up ip route add 2000::0/3 via xxx:xxx:xxx:xxx:xxx:xxx
        address xxx:xxx:xxx:xxx:xxx:xxx
        netmask 64
        up ip tunnel change xs6all ttl 64

I'm running Debian Unstable with all the latest updates as of today.

Thanks for any hints,
Jurriaan
-- 
If an elderly but distinguished scientist says that something is possible
he is almost certainly right, but if he says that it is impossible he is
very probably wrong.
	Arthur C Clarke
Debian (Unstable) GNU/Linux 2.6.7-mm5 2x6078 bogomips load 0.15
