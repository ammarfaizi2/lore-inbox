Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbUDQF2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 01:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUDQF2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 01:28:47 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:31873
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263657AbUDQF2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 01:28:46 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Charles Shannon Hendrix <shannon@widomaker.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040417000353.GA3750@widomaker.com>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040416190126.GB408@widomaker.com>
	 <1082144608.2581.156.camel@lade.trondhjem.org>
	 <20040417000353.GA3750@widomaker.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082179726.3012.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 22:28:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 17:03, Charles Shannon Hendrix wrote:
> > 
> > 2.6.x can cache a lot more data, and will tend to write it out in a more
> > lazy fashion (i.e. only when the user requests it). That means the
> > writes tend to occur in a more bursty fashion.
> 
> That makes sense.
> 
> Was there a specific reason for making NFS traffic bursty, or did it
> just work out that way?

It's an inevitable side-effect of the increased caching. If you are
constantly writing out data, then you spread out the load a lot more
than if you wait until the user actually requests a flush.
On the other hand, it means that if your application reads/writs several
times over the same page, then you only write it out once.

Cheers,
  Trond
