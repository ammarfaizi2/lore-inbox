Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267629AbUH3OTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267629AbUH3OTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUH3OTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:19:04 -0400
Received: from clusterfw.beelinegprs.net ([217.118.66.232]:47782 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S267491AbUH3OSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:18:49 -0400
Date: Mon, 30 Aug 2004 18:10:56 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Hans Reiser <reiser@namesys.com>,
       Jamie Lokier <jamie@shareable.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040830141055.GS5108@backtop.namesys.com>
References: <Pine.LNX.4.58.0408260919380.2304@ppc970.osdl.org> <XFMail.20040827111855.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20040827111855.pochini@shiny.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 11:18:55AM +0200, Giuliano Pochini wrote:
> 
> On 26-Aug-2004 Linus Torvalds wrote:
> 
> > I advocated (long ago) something like this for /dev handling, just because
> > I think it would make sense to have
> >
> >       /dev/hda        <- special file
> >       /dev/hda/part1  <- partition 1 (aka /dev/hda1)
> 
> This breaks the r4 semantics if I understood it correctly. 

Reiser4 currently links /metas/ directory under each reiser4 fs object. 
Reiser4 "silently" allows regular file to be a directory for that.

That is only an example how an fs object may link its internal hierarchical
structure to the fs tree.  /dev/hda/-as-a-dir is another example, but, I am
afraid, it is not a reiser4 business to look into the devices.  Devfs or its
successor may do it. 

> Because
> /partN are not simply associated to the file, they are part of the
> file. ie. when I modify /dev/hda I also change /dev/hda/partN and
> vice-versa. I don't see any pratical problem, though.
> 
> 
> > Still, I really do like the idea of merging the notion of file and
> > directory into one notion of "container". I absolutely _detest_ files with
> > internal structure that tools have to know about (ie I hate seeing all
> > those embedded formats that I can't use "grep" on - MIME being one case).
> > I'd much rather see a "group of files"  and a "file with a grouping of
> > information".
> 
> You're actually looking for a database with a legacy fs-like interface :)
> 
> 
> --
> Giuliano.

-- 
Alex.
