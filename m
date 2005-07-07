Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVGGGuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVGGGuK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVGGGsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:48:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17591 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261189AbVGGGqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:46:12 -0400
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: davej@redhat.com, davem@davemloft.net, pmarques@grupopie.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050706234102.2172ca76.akpm@osdl.org>
References: <42CBE97C.2060208@grupopie.com>
	 <20050706.125719.08321870.davem@davemloft.net>
	 <20050706205315.GC27630@redhat.com> <20050706181220.3978d7f6.akpm@osdl.org>
	 <1120718229.3198.8.camel@laptopd505.fenrus.org>
	 <20050706234102.2172ca76.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 08:46:03 +0200
Message-Id: <1120718764.3198.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-06 at 23:41 -0700, Andrew Morton wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > > > On Transmeta CPUs that probably triggers a retranslation of
> >  > > x86->native bytecode, if it thinks it hasn't seen code at that
> >  > > address before.
> >  > > 
> >  > 
> >  > ouch.   What do we do?  Default to off?  Default to off on xmeta?
> > 
> >  off-on-xmeta would be my preference; I'll cook up a patch for that.
> 
> Well we seem to have several people reporting problems of various sorts
> with that patch?

actually we have several people reporting problems that started around
the time the patch got merged. There's very few cases that actually go
away when disabling this. (there's the weird kernel build one and we're
waiting on a good maps on that one)

