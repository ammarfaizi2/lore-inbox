Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTIEAwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTIEAwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:52:50 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:16647 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261566AbTIEAwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:52:49 -0400
Subject: Re: [PATCH] fix remap of shared read only mappings
From: James Bottomley <James.Bottomley@steeleye.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200309050249.21152.phillips@arcor.de>
References: <1062686960.1829.11.camel@mulgrave>
	<20030904214810.GG31590@mail.jlokier.co.uk>
	<1062714829.2161.384.camel@mulgrave>  <200309050249.21152.phillips@arcor.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 04 Sep 2003 20:52:36 -0400
Message-Id: <1062723158.1829.541.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 20:49, Daniel Phillips wrote:
> This an interesting tidbit, as I'm busy working on a DFS mmap for OpenGFS, and 
> I want to be sure I'm implementing true-blue Posix semantics.  But trawling 
> through the Posix/SUS specification at:
> 
>    http://www.unix-systems.org/version3/online.html
> 
> all it says is that for MAP_SHARED "write references shall change the 
> underlying object."  I don't see anything about when those changes become 
> visible to other mappers, much less any discussion of local caching.  Am I 
> looking at the wrong document?

Not sure which is "correct", but the one I'm looking at is the POSIX
update from the open group:

http://www.opengroup.org/onlinepubs/007904975/functions/mmap.html

And that's where I was quoting from.

James


