Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUCLIS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 03:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUCLIS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 03:18:56 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:5643 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S262022AbUCLISy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 03:18:54 -0500
Date: Fri, 12 Mar 2004 09:18:50 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Subject: CardBus 16-bit IO on 32-bit-IO platforms
Message-ID: <Pine.LNX.4.33.0403120902380.15941-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

I am trying to get CardBus to work on a PXA-based platform (kernel
2.4.21 so far). CardBus cards seem to work (at least one of them - a
USB2.0 card), however, I have problems getting 16-bit PCMCIA cards to
work.

I specified an IO-range from the statically mapped PCI IO-range in
/etc/pcmcia/config.opts, fixed a couple of hard-coded 16-bit assumptions
in yenta-driver and arount it, this IO-range gets successfully allocated,
then it comes to the point of writing these addresses to the CardBus
controller's configuration registers, and they are 16-bit... And then it
doesn't work.

So, my question to all, having experience running CardBus on platforms,
where IO doesn't lie in the first 64K - how is that done?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

