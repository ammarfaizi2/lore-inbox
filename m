Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267929AbUGaKJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267929AbUGaKJz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 06:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267932AbUGaKJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 06:09:55 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:9961 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S267929AbUGaKJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 06:09:49 -0400
Date: Sat, 31 Jul 2004 12:09:47 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc2-mm1 breaks PPPoE for me (was: 2.6.8-rc2-mm1)
Message-ID: <20040731100947.GA7453@merlin.emma.line.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040728020444.4dca7e23.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728020444.4dca7e23.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm1/
...
> gcc35-pppoe.c.patch
>   gcc-3.5 fixes

Andrew,

I'm not sure if my problem is related to this patch, but in
2.6.8-rc2-mm1, PPPoE doesn't work for me, kernel compiled with gcc (GCC)
3.3.1 (SuSE Linux), a vanilla 2.6.7 is fine with the same compiler.

pppd[5685]: Plugin /usr/lib/pppd/2.4.1/pppoe.so loaded.
pppd[5685]: PPPoE Plugin Initialized
pppd[5685]: pppd 2.4.1 started by root, uid 0
pppd[5685]: Sending PADI
pppd[5685]: HOST_UNIQ successful match 
pppd[5685]: Failed to negotiate PPPoE connection: 25 Inappropriate ioctl for device
pppd[5685]: Exit.

A successful pppd session start, with 2.6.7, looks like this:

pppd[5070]: PPPoE Plugin Initialized
pppd[5070]: pppd 2.4.1 started by root, uid 0
pppd[5070]: Sending PADI
pppd[5070]: HOST_UNIQ successful match 
pppd[5070]: HOST_UNIQ successful match 
pppd[5070]: Got connection: 164b
pppd[5070]: Connecting PPPoE socket: 00:90:1a:XX:XX:XX 4b16 eth1 0x808a560
/sbin/hotplug[5166]: INTERFACE=ppp0
pppd[5070]: Using interface ppp0
pppd[5070]: Connect: ppp0 <--> eth1
pppd[5070]: Setting MTU to 1492.
pppd[5070]: Couldn't increase MRU to 1500
pppd[5070]: Setting MTU to 1492.
pppd[5070]: local  IP address 217.81.XXX.XXX
pppd[5070]: remote IP address 217.5.XXX.XXX
pppd[5070]: Script /etc/ppp/ip-up finished (pid 5180), status = 0x0

HTH,

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
