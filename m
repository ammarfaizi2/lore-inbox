Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267649AbUG3MRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUG3MRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 08:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267642AbUG3MRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 08:17:19 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:40967 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S267649AbUG3MRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 08:17:17 -0400
Date: Fri, 30 Jul 2004 14:10:04 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: greearb@candelatech.com, akpm@osdl.org, alan@redhat.com,
       jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040730121004.GA21305@alpha.home.local>
References: <20040729041811.GF1545@alpha.home.local> <E1BqN0L-0005dD-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BqN0L-0005dD-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 12:20:17PM +1000, Herbert Xu wrote:
> Willy Tarreau <willy@w.ods.org> wrote:
> > 
> > I noticed a bug in the 2.4 tulip driver concerning MTU. The parameter
> > is correctly declared as a static int, initialized with default values,
> > checked by the code, but not declared as MODULE_PARM, so the user cannot
> > change it ! I wanted to send a patch but didn't find time to work on it
> > yet. So if your vlan patch fixes it, it's welcome :-)
> 
> Why is this a module parameter at all? Can't you set it using ifconfig?

no, because the driver has no change_mtu() function, so it uses the generic
one, eth_change_mtu(), which is bound to 1500.

Regards,
Willy

