Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbTJSH4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 03:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTJSH4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 03:56:22 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:25363 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S262062AbTJSH4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 03:56:18 -0400
Date: Sun, 19 Oct 2003 07:56:02 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Finding memory leak
In-Reply-To: <20031018175912.GC12461@wohnheim.fh-wedel.de>
Message-Id: <Pine.LNX.4.44.0310190751530.21396-100000@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Oct 2003, Jörn Engel wrote:

> On Sat, 18 October 2003 19:46:36 +0200, Jörn Engel wrote:
> > On Sat, 18 October 2003 19:23:53 +0200, Jörn Engel wrote:
> > > > 
> > > >   - Could someone please check igmpv3_newpack() and assure me that there
> > > >     is no leak.
> > > 
> > > There was a leak, found by the stanford checker team.  I've provided a
> > > broken fix, DaveM wanted to write a decent one.  Not sure if it has
> > > already found it's way into the official kernel.
> > 
> > If DaveM hasn't fixed it yet, you can also try this patch.  Since I'm
> > pretty unaware of the networking code, this may be broken again, but
> > it also can't make things much worse for you.
> 
> Or this one.  igmpv3_newpack() is to a large degree identical to
> igmp_send_report().  The latter doesn't have a memleak, so I basically
> adjusted the former to behave identical.  Should be foolproof, even
> for me.
> 
Did try this, but the leak is still there. The size-2048 values is always
slowly going up.

Holger

