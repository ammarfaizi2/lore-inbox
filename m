Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbTDUUHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTDUUHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:07:48 -0400
Received: from [62.39.112.246] ([62.39.112.246]:6786 "EHLO dot.kde.org")
	by vger.kernel.org with ESMTP id S261927AbTDUUHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:07:47 -0400
Date: Mon, 21 Apr 2003 22:19:43 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org
Subject: ISDN (hisax_fcpcipnp) problems in 2.4.21-pre7-ac1?
Message-ID: <Pine.LNX.4.53.0304212214300.19250@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've just tried getting an ISDN connection to work with 2.4.21-pre7-ac1 - 
setting up the device etc. works normally, but the connection is killed 
immediately on connection.

Syslog says:
Apr 21 21:07:19 localhost kernel: isdn_tx_timeout dev ippp0 dialstate 0
Apr 21 21:07:19 localhost kernel: ippp0: dialing 1 01929...
Apr 21 21:07:21 localhost kernel: isdn_net: ippp0 connected
Apr 21 21:07:21 localhost ipppd[1199]: Local number: 99608, Remote number: 
01929, Type: outgoing
Apr 21 21:07:21 localhost ipppd[1199]: PHASE_WAIT -> PHASE_ESTABLISHED, 
ifunit: 0, linkunit: 0, fd: 6
Apr 21 21:07:21 localhost ipppd[1199]: Modem hangup
Apr 21 21:07:21 localhost ipppd[1199]: Connection terminated.
Apr 21 21:07:21 localhost ipppd[1199]: taking down PHASE_DEAD link 0, 
linkunit: 0
Apr 21 21:07:21 localhost ipppd[1199]: closing fd 6 from unit 0
Apr 21 21:07:21 localhost ipppd[1199]: link 0 closed , linkunit: 0
Apr 21 21:07:21 localhost ipppd[1199]: reinit_unit: 0
Apr 21 21:07:21 localhost ipppd[1199]: Connect[0]: /dev/ippp0, fd: 6
Apr 21 21:07:21 localhost kernel: ippp0: remote hangup
Apr 21 21:07:21 localhost kernel: ippp0: Chargesum is 0
Apr 21 21:07:59 localhost kernel: NETDEV WATCHDOG: ippp0: transmit timed 
out
Apr 21 21:07:59 localhost kernel: isdn_tx_timeout dev ippp0 dialstate 0

It looks like the remote side is hanging up immediately, but from a 
different machine (same kernel, but good old Teles 16.3 ISA card), 
connections to the same ISP work.

Are there any known problems with hisax_fcpcipnp that could cause this?

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
