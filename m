Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbTFEURy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbTFEURy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:17:54 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:52957 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265102AbTFEURx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:17:53 -0400
Date: Thu, 5 Jun 2003 22:31:08 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.5.70-bk9 kick FAR out of the zlib
Message-ID: <20030605203108.GD22439@wohnheim.fh-wedel.de>
References: <20030605194644.GA22439@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0306051607260.2391@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0306051607260.2391@chaos>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus should have a firm position already, pruned from CC:.

On Thu, 5 June 2003 16:17:52 -0400, Richard B. Johnson wrote:
> On Thu, 5 Jun 2003, [iso-8859-1] Jörn Engel wrote:
> 
> > A while back:
> >
> > On Fri, 30 May 2003 14:38:07 -0700, Linus Torvalds wrote:
> > > On Fri, 30 May 2003, Jörn Engel wrote:
> > > >
> > > > How about an all or nothing approach?  If you really want to get rid
> > > > of K&R, change indentation as well, rip out some of the rather
> > > > tasteless macros (ZEXPORT, ZEXPORTVA, ZEXTERN, FAR, ...) and so on.
> > >
> > > I'd love to, but I suspect we lack the motivation to do so, and there
> > > aren't any obvious upsides. Yes, the code is ugly, but it's also fairly
> > > stable so people seldom need to look at it.

Please let the above sink in a moment.

> But you just removed the portability hooks. The current code worked
> in DOS, on Windows, etc., as will as Linux. This means that if some-
> body, as unlikely as it may seem, develops a better/quicker
> version using M$ Visual C/C++, you can't get a patch. In particular,
> FAR is your friend. A simple #define makes it disappear when you
> are not using a segmented architecture, but allows the use of
> large arrays when you are.
> 
> These kinds of things don't make the code 'pure'. It just prevents
> future enhancements. Look in the 'C' header files and see all the
> macros that disappear under the right conditions. Would you
> justify getting rid of __P in those headers? If not, please don't
> eliminate FAR.

My words were "all or nothing".  Linus was against nothing, so the
answer is all, that simple.

As to your "someone comes up with a better zlib" concern, this has
happened already.  An guess what, we ignored it.  So unless you come
up with a patch to get the 1.1.4 changes into the kernel and describe
what the two magic bits are all about, I couldn't care less.

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens
