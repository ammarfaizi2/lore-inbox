Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTIEApm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbTIEApm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:45:42 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:38100 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261376AbTIEApl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:45:41 -0400
From: Daniel Phillips <phillips@arcor.de>
To: James Bottomley <James.Bottomley@steeleye.com>,
       Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] fix remap of shared read only mappings
Date: Fri, 5 Sep 2003 02:49:21 +0200
User-Agent: KMail/1.5.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <1062686960.1829.11.camel@mulgrave> <20030904214810.GG31590@mail.jlokier.co.uk> <1062714829.2161.384.camel@mulgrave>
In-Reply-To: <1062714829.2161.384.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309050249.21152.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 00:33, James Bottomley wrote:
> On Thu, 2003-09-04 at 17:48, Jamie Lokier wrote:
> However, POSIX does imply levels of cache coherence for both MAP_SHARED
> and MAP_PRIVATE:
>
> With MAP_SHARED, any change to the underlying object after the mapping
> must become visible to the mapper (although the change may be delayed by
> local caching of the changer's implementation until it is explicitly
> flushed).

This an interesting tidbit, as I'm busy working on a DFS mmap for OpenGFS, and 
I want to be sure I'm implementing true-blue Posix semantics.  But trawling 
through the Posix/SUS specification at:

   http://www.unix-systems.org/version3/online.html

all it says is that for MAP_SHARED "write references shall change the 
underlying object."  I don't see anything about when those changes become 
visible to other mappers, much less any discussion of local caching.  Am I 
looking at the wrong document?

Regards,

Daniel


