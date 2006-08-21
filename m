Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWHUURY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWHUURY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 16:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWHUURY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 16:17:24 -0400
Received: from server6.greatnet.de ([83.133.96.26]:27111 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750780AbWHUURX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 16:17:23 -0400
Message-ID: <44EA14BF.5090102@nachtwindheim.de>
Date: Mon, 21 Aug 2006 22:17:03 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Linker error on via-velocity driver
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I found a bug in the via-velocity driver, but I cant find a maintainer for that, so I write to the lists.
This driver depends on CONFIG_INET (tcp/ip) if CONFIG_PM is enabled.
This is tested on i386 and x86_64.
I'm not familiar with network stuff but I don't believe a device should depend on a protocol.
If you are interested to fix it:

make allnoconfig
enable CONFIG_PCI
enable CONFIG_NET
enable CONFIG_NET_ETHERNET
enable CONFIG_NET_PCI
enable CONFIG_VIA_VELOCITY
make

That only happens when CONFIG_PM is enabled. If it's switched off it won't happen.

Greets,
Henne

