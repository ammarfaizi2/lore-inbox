Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbTHSTiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbTHSTh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:37:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57229 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261379AbTHSTfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:35:50 -0400
Date: Tue, 19 Aug 2003 12:28:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@colin2.muc.de>
Cc: dang@fprintf.net, ak@muc.de, lmb@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819122847.2d7e2e31.davem@redhat.com>
In-Reply-To: <20030819193235.GG92576@colin2.muc.de>
References: <mdtk.Zy.1@gated-at.bofh.it>
	<mgUv.3Wb.39@gated-at.bofh.it>
	<mgUv.3Wb.37@gated-at.bofh.it>
	<miMw.5yo.31@gated-at.bofh.it>
	<m365ktxz3k.fsf@averell.firstfloor.org>
	<1061320620.3744.16.camel@athena.fprintf.net>
	<20030819192125.GD92576@colin2.muc.de>
	<1061321268.3744.20.camel@athena.fprintf.net>
	<20030819193235.GG92576@colin2.muc.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Aug 2003 21:32:35 +0200
Andi Kleen <ak@colin2.muc.de> wrote:

> What happens on outgoing active ARPs is a different thing. Reasonable
> choices would be either the prefered source address of the route or
> the local interface's address. I must admit I don't have a strong
> opinion on what the better behaviour of those is, but neither of them would
> seem particularly wrong to me.

Andi, we take the source address from the packet we are
trying to send out that interface.

Just as it is going to be legal to send out a packet from
that interface using that source address, it is legal to
send out an ARP request from that interface using that source
address.
