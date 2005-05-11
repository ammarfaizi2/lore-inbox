Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVEKSlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVEKSlM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVEKSlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:41:12 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:10404
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262013AbVEKSlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:41:08 -0400
Date: Wed, 11 May 2005 11:40:24 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Stuffed Crust <pizza@shaftnet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix long-standing bug in 2.6/2.4
 skb_copy/skb_copy_expand
Message-Id: <20050511114024.278b97d4.davem@davemloft.net>
In-Reply-To: <20050508143259.GA30676@shaftnet.org>
References: <20050508143259.GA30676@shaftnet.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 May 2005 10:32:59 -0400
Stuffed Crust <pizza@shaftnet.org> wrote:

> But if the alloc_skb function 
> allocates extra head room (ie calls skb_reserve() on the skb before it 
> passes it to the callee, this doesn't quite work.

alloc_skb() may call skb_reserve() in your tree, but it doesn't in anyone
else's.
