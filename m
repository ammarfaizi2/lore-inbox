Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUFCGje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUFCGje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUFCGje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:39:34 -0400
Received: from fmr99.intel.com ([192.55.52.32]:32657 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261252AbUFCGjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:39:17 -0400
Subject: Re: [RFD] Explicitly documenting patch submission
From: Len Brown <len.brown@intel.com>
To: Ian Stirling <ian.stirling@mauve.plus.com>
Cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FD265@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FD265@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1086244735.2241.269.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Jun 2004 02:38:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-23 at 11:38, Ian Stirling wrote:

> Has anyone ever tried to forge the name on a patch, and get it
> included?

Yes.

Today akpm send me a little patch via e-mail, I did this:

$ bk import -temail < akpm.email

This records the author as akpm -- not me.
I did a "bk comments" to clean up the comments,
but the author remains akpm, who included a
single "Signed-off-by: Andrew Morton <akpm@osdl.org>"

If you paw through the s-file, you'll find a little [lenb]
that shows I checked in the file -- but the tools don't
seem to show that.  You'll also see a little [torvalds]
on lots of akpm csets, so I guess Linus does the
same thing.

There is a clear audit trail that the csets came from
my repo: http://lkml.org/lkml/2004/5/3/77
Though I guess pawing through LKML archives to follow
patch origin should be an exception rather than a rule.

More often I apply a patch with "bk import -tpatch".
Here I get recorded as the one who checked-in,
so if the author was not me, I credit the author
in the check-in comments.  But I suppose that
here too I'm a forger b/c I use BK_USER=len.brown
so that the history records my valid company
e-mail address, rather than the userid [lenb]
I've got on my local development box.

I guess this second method is consistent with Linus'
proposal -- though I would have expected the first
method to be preferable -- at least for well-known
authors.

Also, I guess the news here is that sometimes the
last two levels of the check-in chain are automatically
recorded, but this is not well known.

cheers,
-Len


