Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTJJM5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 08:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTJJM5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 08:57:06 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:17539 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S262776AbTJJM5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 08:57:02 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] kfree_skb() bug in 2.4.22
Date: Fri, 10 Oct 2003 14:53:44 +0200
User-Agent: KMail/1.5.4
Cc: toby@cbcg.net, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       netfilter@lists.netfilter.org, akpm@zip.com.au, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, jmorris@intercode.com.au, yoshfuji@linux-ipv6.org,
       Jeff Garzik <jgarzik@pobox.com>
References: <1065617075.1514.29.camel@localhost> <3F840C9C.9050704@pobox.com> <20031008064735.7373227b.davem@redhat.com>
In-Reply-To: <20031008064735.7373227b.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310101453.44353.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 October 2003 15:47, David S. Miller wrote:
> On Wed, 08 Oct 2003 09:09:48 -0400
>
> Jeff Garzik <jgarzik@pobox.com> wrote:
> > I would prefer that you fix your code instead, to not pass NULL to
> > kfree_skb()...
>
> Absolutely, there is no valid reason to pass NULL into these
> routines.

Would you mind __attribute_nonnull__ for these functions, if we
enable GCC 3.3 support for this[1]?


[1] Which includes editing the compiler.h and gcc3-compiler.h and so on.

Regards

Ingo Oeser


