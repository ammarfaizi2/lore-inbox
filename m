Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUDPTjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUDPTjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:39:23 -0400
Received: from mail.shareable.org ([81.29.64.88]:51618 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262425AbUDPTjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:39:22 -0400
Date: Fri, 16 Apr 2004 20:39:14 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, shannon@widomaker.com,
       linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040416193914.GA25792@mail.shareable.org>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <20040416090331.GC22226@mail.shareable.org> <1082130906.2581.10.camel@lade.trondhjem.org> <20040416184821.GA25402@mail.shareable.org> <1082142401.2581.131.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082142401.2581.131.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> > In other words, with adaptive rtt the concept of "retrans" being a
> > fixed number is fundamentally flawed -- unless it's also accompanied
> > by a minimum timeout time.  You'd need a retrans value of 20 or so for
> > the above perfectly normal LAN situation, but then that's far too
> > large on other occasions with other networks or servers.
> 
> At that point, it makes sense to drop the entire "retrans+timeo"
> paradigm, and just state that soft timeouts take a single parameter
> ("timeo") that determines the timeout value.

I agree.  30 seconds seems like a good default.

> That's something that is dead easy to do...

I'll test a patch for 2.6.5 if you provide one.

-- Jamie
