Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270223AbUJTCBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270223AbUJTCBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270245AbUJTB4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:56:17 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:27542
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S270237AbUJTAuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:50:00 -0400
Date: Tue, 19 Oct 2004 17:44:32 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: herbert@gondor.apana.org.au, vda@port.imtp.ilyichevsk.odessa.ua,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net
Subject: Re: tun.c patch to fix "smp_processor_id() in preemptible code"
Message-Id: <20041019174432.41fcdc17.davem@davemloft.net>
In-Reply-To: <1098226288.23628.6.camel@krustophenia.net>
References: <E1CK1e6-0004F3-00@gondolin.me.apana.org.au>
	<1098222676.23367.18.camel@krustophenia.net>
	<20041019215401.GA16427@gondor.apana.org.au>
	<1098223857.23367.35.camel@krustophenia.net>
	<20041019153308.488d34c1.davem@davemloft.net>
	<1098225729.23628.2.camel@krustophenia.net>
	<20041019154249.6afcaaad.davem@davemloft.net>
	<1098226288.23628.6.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 18:51:28 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> OK, thanks for clarifying.  The correct patch is therefore:
 ...
>  static inline int netif_rx_ni(struct sk_buff *skb)
>  {
> +       preempt_disable();
>         int err = netif_rx(skb);

You need to put statements after local function variable
declarations.
