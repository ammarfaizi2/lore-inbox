Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWGDMq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWGDMq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWGDMq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:46:58 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:46997 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750739AbWGDMq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:46:58 -0400
Date: Tue, 4 Jul 2006 14:42:48 +0200
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Lex Lyamin <flx@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: ext4 features (salvage)
Message-ID: <20060704124248.GA11458@aitel.hist.no>
References: <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <44A9904F.7060207@wolfmountaingroup.com> <20060703232547.2d54ab9b.diegocg@gmail.com> <1152004929.3374.13.camel@elijah.suse.cz> <1152012907.23628.20.camel@lappy> <1152013961.3374.78.camel@elijah.suse.cz> <80294dc60607040508l1022d164ybe0ba10858e54f0c@mail.gmail.com> <1152016317.3374.94.camel@elijah.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152016317.3374.94.camel@elijah.suse.cz>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 02:31:56PM +0200, Petr Tesarik wrote:
> On Tue, 2006-07-04 at 16:08 +0400, Lex Lyamin wrote:
> > you mean that blocks are naturaly free, but we cant use them because
> > someone may made them free by accident, but we cant use them...
> > 
> > hmm...
> > great idea!
> > 
> > wait, its not.
> > because of we cant use those blocks we cant optimise way we write one
> > disk , and if we have defragmenter we cant  make use of them either.
> > and if (just if) this is online defragmenter, it cant use them too. 
> 
> Well, the way I saw it done was that you had no guarantee that any
> deleted file could be salvaged. Sometimes you even could salvage a file
> but not another one which was deleted later. Users seemed to be content
> with that, because in most situations it did help them restore files
> they deleted and within a few seconds realized that they didn't want to.
> 
> This means that the allocator MAY purge any deleted block at any moment,
> although it tends to allocate blocks from areas of disk which haven't
> been used recently.
> 
> And the benefits? The performance of such a filesystem could be better
> than snapshots, while allowing to cope with one of the most common human
> errors.

The most common error?  A few years ago I restored a file from
backup, because I deleted it in error.  I can't even remember
the second-last time I had that problem.

I'd say this error is among the easiest to avoid. :-)
Even a little performance loss won't justify it for me.

Now, there may be clumsier users than me, but they tend to
be using GUI "file managers" which do implement a "wastebasket"
for all internal deletion.

Helge Hafting


