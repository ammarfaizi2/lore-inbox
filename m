Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUE0PTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUE0PTA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264761AbUE0PTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:19:00 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:41367 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264734AbUE0PS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:18:57 -0400
Date: Thu, 27 May 2004 17:18:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Larry McVoy <lm@work.bitmover.com>, Andrew Morton <akpm@osdl.org>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040527151845.GH23194@wohnheim.fh-wedel.de>
References: <20040527062002.GA20872@work.bitmover.com> <20040527010409.66e76397.akpm@osdl.org> <20040527145127.GB3375@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040527145127.GB3375@work.bitmover.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004 07:51:27 -0700, Larry McVoy wrote:
> 
> I think we can have our cake and eat it too, at least in BK (and there
> is no reason other systems couldn't do this as well):  BK does not have
> the concept of a 1:1 binding between a change to a file and a changeset.
> A changeset is a container which may have one or more deltas to one or
> more files, i.e., it is many:1.
> 
> If you took to sending your patches as the original patch plus another
> patch, bundling them together (I can work out a format and GPLed tools for
> this) then what we could do is have the BK import tools record the first
> one as a set of deltas, the next one as another set of deltas, and so on.
> We can handle an arbitrary number of patches to patches to patches.
> Then when the import finishes we bundle up all the deltas in one logical
> changeset.  99% of the time people won't care about the details, when
> they are looking through the code the interfaces will all work as they
> do today, the BK/Web interface would export this as a patch just like
> you are used to, but when people do care the full information is there.

Sounds good, as long as it is simple (read: simplest) to read and
export the result of everything as one patch.  I.e. I wouldn't want to
see this:

@@ -28,6 +28,7 @@
 
 
 
+	/* new comment in empty raea */
 
 
 
@@ -28,67+28,7 @@
 
 
 
-	/* new comment in empty raea */
+	/* new comment in empty area */
 
 
 

But that goes without saying, doesn't it? ;)

> I suspect that with a little practice this could be quite useful.  
> I could build tools which record the secondary patches as diffs to
> the patches (I think) and if you have ever read a diff of a diff 
> it is suprisingly useful.  I tend to save diffs of my work in 
> progress and then later I'll generate diffs again and diff them to 
> get my context back.

Diffs to diffs I am even less eager to read.  As an internal format,
they make sense, though.

Jörn

-- 
There's nothing better for promoting creativity in a medium than
making an audience feel "Hmm ­ I could do better than that!"
-- Douglas Adams in a slashdot interview
