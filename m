Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTJJPrH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbTJJPrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:47:07 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:20919 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S262848AbTJJPrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:47:03 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] kfree_skb() bug in 2.4.22
Date: Fri, 10 Oct 2003 17:43:48 +0200
User-Agent: KMail/1.5.4
Cc: toby@cbcg.net, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       netfilter@lists.netfilter.org, akpm@zip.com.au, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, jmorris@intercode.com.au, yoshfuji@linux-ipv6.org,
       jgarzik@pobox.com
References: <1065617075.1514.29.camel@localhost> <200310101453.44353.ioe-lkml@rameria.de> <20031010060050.057aab50.davem@redhat.com>
In-Reply-To: <20031010060050.057aab50.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310101743.48483.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 October 2003 15:00, David S. Miller wrote:
> Ingo Oeser <ioe-lkml@rameria.de> wrote:
> > Would you mind __attribute_nonnull__ for these functions, if we
> > enable GCC 3.3 support for this[1]?
>
> I would say yes, but why?  All this attribute does is optimize
> away tests for NULL which surprise surprise we don't have any
> of in kfree_skb().

And it wouldn't warn about passing NULL to these functions? That's bad...
But maybe sparse/smatch are better for this...


