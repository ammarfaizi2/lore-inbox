Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTIEBSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbTIEBSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:18:16 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:13191 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261918AbTIEBSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:18:15 -0400
From: Daniel Phillips <phillips@arcor.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] fix remap of shared read only mappings
Date: Fri, 5 Sep 2003 03:21:55 +0200
User-Agent: KMail/1.5.3
Cc: Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <1062686960.1829.11.camel@mulgrave> <200309050249.21152.phillips@arcor.de> <1062723158.1829.541.camel@mulgrave>
In-Reply-To: <1062723158.1829.541.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309050321.55799.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 02:52, James Bottomley wrote:
> On Thu, 2003-09-04 at 20:49, Daniel Phillips wrote:
> > This an interesting tidbit, as I'm busy working on a DFS mmap for
> > OpenGFS, and I want to be sure I'm implementing true-blue Posix
> > semantics.  But trawling through the Posix/SUS specification at:
> >
> >    http://www.unix-systems.org/version3/online.html
> >
> > all it says is that for MAP_SHARED "write references shall change the
> > underlying object."  I don't see anything about when those changes become
> > visible to other mappers, much less any discussion of local caching.  Am
> > I looking at the wrong document?
>
> Not sure which is "correct", but the one I'm looking at is the POSIX
> update from the open group:
>
> http://www.opengroup.org/onlinepubs/007904975/functions/mmap.html
>
> And that's where I was quoting from.

It appears to be the same text.  Either I'm blind, or the part about the 
caching was your editorial commentaryk.  Anyway, I'm going with Linus' ruling 
on semantics, I agree totally.

Regards,

Daniel

