Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbULGSuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbULGSuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbULGSuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:50:14 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:38317
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261895AbULGSuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:50:08 -0500
Date: Tue, 7 Dec 2004 10:48:15 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: yoshfuji@linux-ipv6.org, mitch@sfgoth.com, kernel@linuxace.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] fix select() for SOCK_RAW sockets (ipv6)
Message-Id: <20041207104815.3f7a4684.davem@davemloft.net>
In-Reply-To: <20041207100140.781f4c00@dxpl.pdx.osdl.net>
References: <20041207045302.GA23746@linuxace.com>
	<20041207054840.GD61527@gaz.sfgoth.com>
	<20041207150834.GA75700@gaz.sfgoth.com>
	<20041208.023530.26430801.yoshfuji@linux-ipv6.org>
	<20041207100140.781f4c00@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004 10:01:40 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> > Probably, we need to do the same for ipv6, don't we?
> 
> diff -Nru a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> --- a/net/ipv6/af_inet6.c	2004-12-07 10:02:50 -08:00
> +++ b/net/ipv6/af_inet6.c	2004-12-07 10:02:50 -08:00
> @@ -513,6 +513,27 @@

We didn't do the "UDP select() fix" on ipv6 because we don't
have the delayed checksumming optimization there.  So the
ipv6 side really doesn't need this change.

Or did I miss something?
