Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUF0Nrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUF0Nrj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 09:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUF0Nrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 09:47:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:31410 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262106AbUF0Nrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 09:47:33 -0400
Subject: Re: Inclusion of UML in 2.6.8
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040626234025.7d69937c.akpm@osdl.org>
References: <200406261905.22710.blaisorblade_spam@yahoo.it>
	 <20040626130945.190fb199.akpm@osdl.org>
	 <20040627035923.GB8842@ccure.user-mode-linux.org>
	 <20040626233253.06ed314e.pj@sgi.com>
	 <20040626234025.7d69937c.akpm@osdl.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1088344199.21940.62.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 27 Jun 2004 15:50:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-27 at 08:40, Andrew Morton wrote:
> Paul Jackson <pj@sgi.com> wrote:
> >
> > > I'm looking at quilt
> > 
> > Good tool.
> > 
> > It's a bit like a loaded gun with no safety. You will learn a few new
> > ways to shoot your foot off, and become good at first aid.

Ideas for improvement are always welcome -- they would best be discussed
on http://lists.nongnu.org/mailman/listinfo/quilt-dev.

> >  You will
> > want someway to keep personal revision history of your patches, to aid
> > in such repair work.  CVS or RCS or local bitkeeper or (for ancient
> > hackers like me) raw SCCS or some such.  Quilt handles the patches, but
> > in and of itself has nothing to do with preserving history.
> > 
> > All software is divided into two parts - the concrete and the fluid.
> > 
> > Once something is accepted into the main kernel, it's concrete.  You can
> > never go back - you can only layer fixes on top.  Bitkeeper rules for
> > this stuff.
> > 
> > But work in progress, for which oneself is still the primary source, is
> > fluid.  You can slice and dice and redo it, and indeed you want to, to
> > get the best patch set.  Quilt and friends rule for this stuff.
> 
> Good description, that.  quilt is a grown-up version of patch-scripts, and
> is tailored to what I do, and to what distributors do: maintain a series of
> diffs against a monolithic tree which someone else maintains.

The concepts behind quilt are all stolen from patch-scripts, so it has
the same usability problem that patch-scripts has: forgetting to add a
file to a patch before modifying it is painful. the ``quilt edit''
command helps somewhat. I do not have a good idea how to fix this in a
more satisfactory way.

Quilt is missing some of the features of patch-scripts: there are no
equivalents to export_patch, which renames exported patches so that the
filename sort order equals the order of the patches in the series file.
Neither is there a way to strip such sequencing prefixes when importing
patches. (I consider this obsolete.) There is nothing kernel specific,
and nothing specific to version control systems. Also there are no
equiovalents to patch-scripts's new-kernel, mv-patch, patch-bomb,
pstatus, rename-patch, tag-series, unitdiff.py commands.

On the other hand there are lots of small improvements, no more patch
control files (that list the files a patch touches in patch-scripts),
improved diffing and status inquiry functionality, patch dependency
analysis, support for RPM packages. And there is more documentation.

Things I'm currently considering include:

 - handling of meta-information such as one-line summary, author,
   description,

 - support for diffstat (re-add; we had this in older versions),

 - a patch-bomb equivalent.

All of the above things will potentially conflict with the goal of
keeping the whole thing as policy-free and generally useful as possible.
> > Conclusion - use Quilt (with your favorite personal version control) on
> > top of Bitkeeper.
> 
> yup.  I use patch-scripts+CVS in the way which you describe.

Same here.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG


