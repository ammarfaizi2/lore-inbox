Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUIUWgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUIUWgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 18:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUIUWgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 18:36:51 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:55945
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266790AbUIUWgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 18:36:39 -0400
Date: Tue, 21 Sep 2004 15:36:00 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: rusty@rustcorp.com.au, torvalds@osdl.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
Message-Id: <20040921153600.2e732ea6.davem@davemloft.net>
In-Reply-To: <20040922003646.3a84f4c5.Ballarin.Marc@gmx.de>
References: <1095721742.5886.128.camel@bach>
	<20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
	<1095803902.1942.211.camel@bach>
	<20040922003646.3a84f4c5.Ballarin.Marc@gmx.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004 00:36:46 +0200
Marc Ballarin <Ballarin.Marc@gmx.de> wrote:

> I just added some warnings, but modprobe ipchains always fails on
> 2.6.9-rc2:
> 
> FATAL: Error inserting ipchains
> (/lib/modules/2.6.9-rc2-rcf/kernel/net/ipv4/netfilter/ipchains.ko): Device
> or resource busy

You can't have ipchains and iptables loaded at the same time.
You must first manually unload iptables, then you can
successfully load the ipchains module.
