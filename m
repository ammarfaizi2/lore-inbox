Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTFCAYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 20:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTFCAYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 20:24:38 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:52946 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264271AbTFCAYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 20:24:37 -0400
Date: Mon, 2 Jun 2003 19:39:01 -0400
From: Ben Collins <bcollins@debian.org>
To: Rob Landley <rob@landley.net>
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
Subject: Re: BKCVS issue
Message-ID: <20030602233901.GT10102@phunnypharm.org>
References: <20030602211436.GF14878@vitelus.com> <200306021937.03013.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306021937.03013.rob@landley.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 07:37:02PM -0400, Rob Landley wrote:
> On Monday 02 June 2003 17:14, Aaron Lehmann wrote:
> > For the past few days, it seems like every time something changes in
> > BK, the bkcvs repository has all of its files touched. At least, all
> > files in the repository have a P preceding their names on a cvs up.
> >
> > It's not intolerable, but I was wondering if anyone's aware of it.
> 
> CVS thinks of changes as having been applied in a certain order, with each 
> cange applying to the result of previous changes.
> 
> Bitkeeper does not.  Each change applies to a historical version of the tree, 
> and when it gets two sets of changes based on the same historical tree 
> neither one of them goes "before" the other, they both apply to the old tree.  
> (This isn't a linear process, it's lots and lots of branches.  Conflicts 
> don't come up at this point, think quantum indeterminacy and the trousers of 
> time and all that.)

bkcvs doesn't do this. It can't. There's no way for CVS to represent
what BK does. bkcvs is instead linear, but some commits are groups of
changesets instead of single changesets.

The problem is that bkcvs 2.5 is broken. Larry has said he will fix it,
time permitting.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
