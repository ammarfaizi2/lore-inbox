Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVAaFST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVAaFST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 00:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVAaFSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 00:18:18 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:8157
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261921AbVAaFSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 00:18:17 -0500
Date: Sun, 30 Jan 2005 21:11:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Patrick McHardy <kaber@trash.net>
Cc: yoshfuji@linux-ipv6.org, herbert@gondor.apana.org.au,
       rmk+lkml@arm.linux.org.uk, Robert.Olsson@data.slu.se, akpm@osdl.org,
       torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-Id: <20050130211150.464d1c62.davem@davemloft.net>
In-Reply-To: <41FDBB78.2050403@trash.net>
References: <41FD2043.3070303@trash.net>
	<E1CvSuS-00056x-00@gondolin.me.apana.org.au>
	<20050131.134559.125426676.yoshfuji@linux-ipv6.org>
	<41FDBB78.2050403@trash.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 06:00:40 +0100
Patrick McHardy <kaber@trash.net> wrote:

> We don't need this for IPv6 yet. Once we get nf_conntrack in we
> might need this, but its IPv6 fragment handling is different from
> ip_conntrack, I need to check first.

Right, ipv6 netfilter cannot create this situation yet.

However, logically the fix is still correct and I'll add
it into the tree.
