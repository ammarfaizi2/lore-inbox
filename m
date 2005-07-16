Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVGPOEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVGPOEy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 10:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVGPOEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 10:04:53 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:52143 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261593AbVGPOE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 10:04:28 -0400
Message-ID: <42D913D6.5050902@colorfullife.com>
Date: Sat, 16 Jul 2005 16:04:06 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
CC: Ayaz Abdulla <AAbdulla@nvidia.com>
Subject: [PATCH] forcedeth: TX handler changes (experimental)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Attached is a patch that modifies the tx interrupt handling of the 
nForce nic. It's part of the attempts to figure out what causes the nic 
hangs (see bug 4552).
The change is experimental: It affects all nForce versions. I've tested 
it on my nForce 250-Gb.

Please test it. And especially: If you experince a nic hang, please send 
me the debug output. That's the block starting with

<<
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Got tx_timeout. irq: 00000000
eth1: Ring at  ...
<<

Thanks,
    Manfred
