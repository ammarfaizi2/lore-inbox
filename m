Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263330AbVBFELL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbVBFELL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 23:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbVBFELL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 23:11:11 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:16051
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263330AbVBFEKu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 23:10:50 -0500
Date: Sat, 5 Feb 2005 20:02:42 -0800
From: "David S. Miller" <davem@davemloft.net>
To: yoshfuji@linux-ipv6.org
Cc: herbert@gondor.apana.org.au, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-Id: <20050205200242.2b629de7.davem@davemloft.net>
In-Reply-To: <20050205.195039.05988480.yoshfuji@linux-ipv6.org>
References: <20050205061110.GA18275@gondor.apana.org.au>
	<20050204221344.247548cb.davem@davemloft.net>
	<20050205064643.GA29758@gondor.apana.org.au>
	<20050205.195039.05988480.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Feb 2005 19:50:39 +0900 (JST)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> In article <20050205064643.GA29758@gondor.apana.org.au> (at Sat, 5 Feb 2005 17:46:43 +1100), Herbert Xu <herbert@gondor.apana.org.au> says:
> 
> > If we wanted to preserve the split device semantics, then we
> > can create a local GC list in IPv6 so that it can search based
> > on rt6i_idev as well as the other keys.  Alternatively we can
> > remove the dst->dev == dev check in dst_dev_event and dst_ifdown
> > and move that test down to the individual ifdown functions.
> 
> Yes, IPv6 needs "split device" semantics
> (for per-device statistics such as Ip6InDelivers etc),
> and I like later solution.

Ok.  I never read whether ipv6, like ipv4, is specified to support
a model of host based ownership of addresses.  Does anyone know?
