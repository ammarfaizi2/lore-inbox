Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269462AbUI3TzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269462AbUI3TzA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269469AbUI3TzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:55:00 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:14494
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269462AbUI3Ty3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:54:29 -0400
Date: Thu, 30 Sep 2004 12:53:17 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, franz_pletz@t-online.de, michal@rokos.info,
       linux-kernel@vger.kernel.org, akpm@osdl.org, manfred@colorfullife.com
Subject: Re: [PATCH 2.6] Natsemi - remove compilation warnings
Message-Id: <20040930125317.5622a909.davem@davemloft.net>
In-Reply-To: <415C4EC5.4040603@pobox.com>
References: <200409230958.31758.michal@rokos.info>
	<200409231618.56861.michal@rokos.info>
	<415C37D8.20203@t-online.de>
	<Pine.LNX.4.58.0409300951150.2403@ppc970.osdl.org>
	<415C4EC5.4040603@pobox.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2004 14:21:57 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Wouldn't it be better to just phase out the base of dev->base_addr 
> completely?  I tend to prefer adding a "void __iomem *regs" to struct 
> netdev_private, and ignore dev->base_addr completely.

Yes, this is the way to go.

(BTW, Jeff, technically it's the 'ifmap' that the user uses
 to pass base_addr into the kernel.  The kernel drivers use
 the netdev struct one, which is an unsigned long)
