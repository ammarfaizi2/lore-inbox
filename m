Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUFGWCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUFGWCG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbUFGWCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:02:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9189 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265098AbUFGWBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:01:53 -0400
Date: Mon, 7 Jun 2004 14:57:23 -0700
From: "David S. Miller" <davem@redhat.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ethtool semantics
Message-Id: <20040607145723.41da5783.davem@redhat.com>
In-Reply-To: <20040607212804.GA17012@k3.hellgate.ch>
References: <20040607212804.GA17012@k3.hellgate.ch>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004 23:28:04 +0200
Roger Luethi <rl@hellgate.ch> wrote:

> What is the correct response if a user passes ethtool speed or duplex
> arguments while autoneg is on? Some possible answers are:
> 
> a) Yell at the user for doing something stupid.
> 
> b) Fail silently (i.e. ignore command).
> 
> c) Change advertised value accordingly and initiate new negotiation.
> 
> d) Consider "autoneg off" implied, force media accordingly.
> 
> The ethtool(8) man page I'm looking at doesn't address that question. The
> actual behavior I've seen is b) which is by far my least preferred
> solution.

speed and duplex fields should be silently ignored in this case
