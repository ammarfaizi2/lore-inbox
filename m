Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUDPTGx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbUDPTGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:06:53 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:14724
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263600AbUDPTGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:06:51 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>, shannon@widomaker.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040416184821.GA25402@mail.shareable.org>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <20040416090331.GC22226@mail.shareable.org>
	 <1082130906.2581.10.camel@lade.trondhjem.org>
	 <20040416184821.GA25402@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082142401.2581.131.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 12:06:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 11:48, Jamie Lokier wrote:

> In other words, with adaptive rtt the concept of "retrans" being a
> fixed number is fundamentally flawed -- unless it's also accompanied
> by a minimum timeout time.  You'd need a retrans value of 20 or so for
> the above perfectly normal LAN situation, but then that's far too
> large on other occasions with other networks or servers.

At that point, it makes sense to drop the entire "retrans+timeo"
paradigm, and just state that soft timeouts take a single parameter
("timeo") that determines the timeout value.

That's something that is dead easy to do...

Cheers,
  Trond
