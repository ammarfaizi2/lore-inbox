Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbTDXEup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTDXEup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:50:45 -0400
Received: from unthought.net ([212.97.129.24]:25483 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id S264391AbTDXEun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:50:43 -0400
Date: Thu, 24 Apr 2003 07:02:49 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Christoph Hellwig <hch@infradead.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030424050249.GC16519@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org> <1051122958.14761.110.camel@moss-huskers.epoch.ncsc.mil> <20030423194254.A5295@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030423194254.A5295@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 07:42:54PM +0100, Christoph Hellwig wrote:
> On Wed, Apr 23, 2003 at 02:35:59PM -0400, Stephen Smalley wrote:
> > The idea of using separate attribute names for each security module was
> > already discussed at length when I posted the original RFC, and I've
> > already made the case that this is not desirable.  Please see the
> > earlier discussion.
> 
> No.  It's not acceptable that the same ondisk structure has a different
> meaning depending on loaded modules.  If the xattrs have a different
> meaning they _must_ have a different name.

A .xyz file in my filesystem may mean one thing to application X, and
another thing to application Y - and quite possibly only application X
is able to make sense of the information in my .xyz file, even though
both applications use the .xyz suffix for their files.

We accept this ambiguity in file systems.

(We accept a similar possibility for ambiguity for UDP/TCP ports,
process names, etc. etc. etc.)

Even if I don't have application X installed, I can still backup and
restore my .xyz file.   Because the tools use a common interface.

Why do extended attributes have to be different?  (And who will maintain
the authorative registry over allocated xattr names?)

In my little mind it makes sense to have security information one
specific and well defined place.  Then, depending on the kernel security
model, it can either make sense of the information, or it can not.

If I insert a disk with MLS labelled files in a TE system, I cannot
expect the system to magically enforce the MLS policy - but my tools
will still work.  I think that sounds beneficial.   In fact, for
disaster recovery, it sounds pretty damn convenient in my ears.

Tell me what I am missing here, please.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
