Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVCPXAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVCPXAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVCPXAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:00:46 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:13203
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262857AbVCPXAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:00:00 -0500
Date: Wed, 16 Mar 2005 14:54:48 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: bunk@stusta.de, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipv4/inetpeer.c: make a struct static
Message-Id: <20050316145448.5a45dddc.davem@davemloft.net>
In-Reply-To: <20050316145343.6e31ba6a.davem@davemloft.net>
References: <20050315144408.GL3189@stusta.de>
	<20050316145343.6e31ba6a.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005 14:53:43 -0800
"David S. Miller" <davem@davemloft.net> wrote:

> On Tue, 15 Mar 2005 15:44:08 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > This patch makes a needlessly global struct static.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> You need to also kill the externs in net/inetpeer.h
> 
> Please fix this up and resubmit.

Actually, Adrian, net/inetpeer.h makes use of
inet_peer_unused_tailp in inline functions.

How did you get a successful build after marking
it static?
