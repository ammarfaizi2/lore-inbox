Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbUDRXWh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 19:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbUDRXWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 19:22:34 -0400
Received: from mail.shareable.org ([81.29.64.88]:47523 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264208AbUDRXWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 19:22:32 -0400
Date: Mon, 19 Apr 2004 00:22:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jamie Lokier <jamie@shareable.or>, linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040418232230.GA11064@mail.shareable.org>
References: <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <20040416090331.GC22226@mail.shareable.org> <1082130906.2581.10.camel@lade.trondhjem.org> <20040416184821.GA25402@mail.shareable.org> <1082142401.2581.131.camel@lade.trondhjem.org> <20040416193914.GA25792@mail.shareable.org> <1082241169.3930.14.camel@lade.trondhjem.org> <20040418032638.GA1786@mail.shareable.org> <1082271815.3619.104.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082271815.3619.104.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Sat, 2004-04-17 at 20:26, Jamie Lokier wrote:
> >       Are they intended to stop doubling at 3.2?  The major timeout
> >       thus happens after 22.3 seconds.
> > 
> >       Unsurprisingly, subsequent major timeouts take 44.1 seconds.
> 
> Right... ...but since the timeout value is already capped at 60 seconds,
> this is not a major problem. It is pretty pointless to be talking about
> "predictable" or "consistent" behaviour when talking about a situation
> where we believe that the server has crashed.

I agree, but would still prefer more consistent behaviour if it is
easy -- and I explained how to do it, it's an easy algorithm.

You don't respond to the other question: the doubling stopping at
3.2s.  Is it intended?  It goes againt a basic principle of congestion
control.

> AFAICS, all we care about is to establish a predictable *lower limit*.

I agree that is the most important thing, and the old behaviour was
probably the cause of problems for at least one poster on this thread.

-- Jamie

