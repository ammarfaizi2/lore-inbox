Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264868AbSJaLxH>; Thu, 31 Oct 2002 06:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264871AbSJaLxH>; Thu, 31 Oct 2002 06:53:07 -0500
Received: from mail.scram.de ([195.226.127.117]:29637 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S264868AbSJaLxG>;
	Thu, 31 Oct 2002 06:53:06 -0500
Date: Thu, 31 Oct 2002 12:53:43 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Skip Ford <skip.ford@verizon.net>
cc: "Randy.Dunlap" <randy.dunlap@verizon.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 ipmr.c syntax error
In-Reply-To: <200210310657.g9V6vrCA009366@pool-141-150-241-241.delv.east.verizon.net>
Message-ID: <Pine.LNX.4.44.0210311252540.7997-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Skip,

> -	if (skb->len+encap > rt->u.dst.pmtu && (ntohs(iph->frag_off) & IP_DF)) {
> +	if (skb->len+encap > dst_pmtu(rt->u.dst) && (ntohs(iph->frag_off) & IP_DF)) {

Shouldn't that be dst_pmtu(&rt->u.dst)?

--jochen

