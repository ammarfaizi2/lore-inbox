Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265430AbSJXN2g>; Thu, 24 Oct 2002 09:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265436AbSJXN2g>; Thu, 24 Oct 2002 09:28:36 -0400
Received: from rth.ninka.net ([216.101.162.244]:4510 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265430AbSJXN2g>;
	Thu, 24 Oct 2002 09:28:36 -0400
Subject: Re: feature request - why not make netif_rx() a pointer?
From: "David S. Miller" <davem@redhat.com>
To: Slavcho Nikolov <snikolov@okena.com>
Cc: "David S. Miller" <davem@rth.ninka.net>, jt@hpl.hp.com,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <000c01c27b61$86c903c0$800a140a@SLNW2K>
References: <20021023003959.GA23155@bougret.hpl.hp.com>
	<004c01c27a99$927b8a30$800a140a@SLNW2K>
	<1035432805.9626.4.camel@rth.ninka.net> 
	<000c01c27b61$86c903c0$800a140a@SLNW2K>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 06:46:55 -0700
Message-Id: <1035467215.14435.2.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 06:30, Slavcho Nikolov wrote:
> In other words, the new routine will not be a derivative of the old one
> or some other part of the kernel.
> Instead, I'll create my own (cleanroom) handler that doesn't reuse any
> existing code, which in the end will either pass control to the GPL routine
> being replaced or destroy the parameters and return.
> I can't see how that is a violation of GPL. If it is, then hundreds of
> Linux startups had better go bankrupt now instead of fighting losing 
> legal battles later.

Let me give you an example of what would be illegal.

Using this netif_rx() hook to implement a proprietary TCP stack
to replace the GPL'd one in the kernel right now.  And that is exactly
the reason I want any such netif_rx  function pointer crap to be
EXPORT_GPL

And before someone, I forget who it was, barks again, EXPORT_GPL has
no legal significance, it is merely an annotation.  Whether a symbol
is marked this way or not has no consequence on legal matters.

