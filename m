Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbUC2Skx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbUC2Skx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:40:53 -0500
Received: from smtp1.pp.htv.fi ([212.90.64.119]:8136 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S263044AbUC2Sku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:40:50 -0500
Subject: Re: Via-Rhine ethernet driver problem?
From: Janne Pikkarainen <jaba@mikrobitti.fi>
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40685BC9.1040902@myrealbox.com>
References: <40685BC9.1040902@myrealbox.com>
Content-Type: text/plain
Message-Id: <1080585650.1349.2.camel@cs95250.pp.htv.fi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 21:40:50 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 20:24, walt wrote:
> Hi, Roger et al,
> 
> ECS K7VTA3 motherboard with built-in ethernet chip:
> 
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
>          Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet Controller on VT8235
>          Flags: bus master, medium devsel, latency 32, IRQ 11
>          I/O ports at ec00 [size=256]
>          Memory at e9041000 (32-bit, non-prefetchable) [size=256]
>          Capabilities: [40] Power Management version 2
> 
> The problem is terrible performance -- I noticed that NFS file transfers grind
> to a complete halt almost immediately on this machine.
> 
> I also discovered by using 'scp' to copy files between machines that the bad
> performance is assymetrical:  copying a file *to* this machine runs at about
> half-speed (5 MB/sec) whereas copying a file *from* this machine runs at
> 45 KiloB/sec, about one percent of expected.
> 
> The reason I feel this is software and not hardware is that the same machine
> running any of the BSD's runs full-speed in both directions.

Hello,

I'm trying to take some load off from actual kernel developers and doing
just a small check: is your NIC in full duplex mode while in Linux?
Please check it with mii-tool or ethtool. This sounds like a half-duplex
problem for me...


Best Regards,

Janne Pikkarainen

