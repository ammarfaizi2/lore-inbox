Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUFCKN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUFCKN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 06:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUFCKN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 06:13:28 -0400
Received: from adsl-67-118-43-14.dsl.renocs.pacbell.net ([67.118.43.14]:32898
	"EHLO mail.clouddancer.com") by vger.kernel.org with ESMTP
	id S263003AbUFCKNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 06:13:05 -0400
From: Klink <colonel@clouddancer.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2-mm1 lost gigabit ethernet config
Reply-To: colonel@clouddancer.com
Message-Id: <20040603101304.3A38D229DE4@phoenix.clouddancer.com>
Date: Thu,  3 Jun 2004 03:13:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running "make oldconfig" on a .config from 2.6.6-mm4 in the
2.6.7-rc2-mm1 directory results in loss of gigabit ethernet config
vars

2.6.6-mm4 .config:

# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
# CONFIG_E1000_NAPI is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
------------------------------------------------------------------

2.6.7-rc2-mm1 .config

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Gigabit Ethernet (1000/10000 Mbit)
#

#
# Token Ring devices
#
# CONFIG_TR is not set

------------------------------------------------------------------

It seems to be because of the merger of 1000/10000 MBit and not the
patching.


