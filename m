Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTFCAeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 20:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTFCAeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 20:34:37 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:39828
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264374AbTFCAef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 20:34:35 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Ben Collins <bcollins@debian.org>
Subject: Re: BKCVS issue
Date: Mon, 2 Jun 2003 20:50:51 -0400
User-Agent: KMail/1.5
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
References: <20030602211436.GF14878@vitelus.com> <200306021937.03013.rob@landley.net> <20030602233901.GT10102@phunnypharm.org>
In-Reply-To: <20030602233901.GT10102@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306022050.51909.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 June 2003 19:39, Ben Collins wrote:
> On Mon, Jun 02, 2003 at 07:37:02PM -0400, Rob Landley wrote:
> > On Monday 02 June 2003 17:14, Aaron Lehmann wrote:
> > > For the past few days, it seems like every time something changes in
> > > BK, the bkcvs repository has all of its files touched. At least, all
> > > files in the repository have a P preceding their names on a cvs up.
> > >
> > > It's not intolerable, but I was wondering if anyone's aware of it.
> >
> > CVS thinks of changes as having been applied in a certain order, with
> > each cange applying to the result of previous changes.
> >
> > Bitkeeper does not.  Each change applies to a historical version of the
> > tree, and when it gets two sets of changes based on the same historical
> > tree neither one of them goes "before" the other, they both apply to the
> > old tree. (This isn't a linear process, it's lots and lots of branches. 
> > Conflicts don't come up at this point, think quantum indeterminacy and
> > the trousers of time and all that.)
>
> bkcvs doesn't do this. It can't. There's no way for CVS to represent
> what BK does. bkcvs is instead linear, but some commits are groups of
> changesets instead of single changesets.
>
> The problem is that bkcvs 2.5 is broken. Larry has said he will fix it,
> time permitting.

I was under the impression that the problem in bkcvs was a design issue: it 
converted a BK repository to a CVS repository by creating a fresh CVS 
repository from scratch each time.  It didn't modify an existing CVS 
repository, which would be a bit more work.

It's not impossible, I suppose.  If you can feed bk the tree version that the 
old CVS was created against, there's existing logic to create create a 
gnu-style patch that gets the tree from point B to point C.  The only problem 
with creating a series of CVS entries instead of a patch is keeping the 
changes seperate when you do it...

Dunno how big a problem that is, I haven't looked at the BK source.  I'd like 
to keep my options open if I decide to work on subversion or some such in the 
future. :)

Rob
