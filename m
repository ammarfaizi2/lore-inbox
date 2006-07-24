Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWGXPiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWGXPiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 11:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWGXPiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 11:38:54 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:49164 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751136AbWGXPiy (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 11:38:54 -0400
Date: Mon, 24 Jul 2006 17:38:53 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Theodore Tso <tytso@mit.edu>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Nikita Danilov <nikita@clusterfs.com>, Steve Lord <lord@xfs.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060724153853.GA88678@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Theodore Tso <tytso@mit.edu>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
	Nikita Danilov <nikita@clusterfs.com>, Steve Lord <lord@xfs.org>
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C42B92.40507@xfs.org> <17604.31844.765717.375423@gargle.gargle.HOWL> <20060724103023.GA7615@thunk.org> <20060724113534.GA64920@dspnet.fr.eu.org> <20060724133939.GA11353@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724133939.GA11353@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 09:39:39AM -0400, Theodore Tso wrote:
> On Mon, Jul 24, 2006 at 01:35:34PM +0200, Olivier Galibert wrote:
> >Ext patches don't get reviewed much
> > outside of the developpers, and they go in pretty much without
> > discussion in any case, except when Linus blows a fuse.
> 
> Um, you're kidding, right?  We certainly don't make the assumption
> that we can violate CodingStyle willy nilly and stuff in yacc grammers
> into ext3 and assume that no one will push back.

I'm not kidding.  I do recognise that the ext* maintainers do a very
good and clean job.


> In fact we did a lot of work to make sure the patches were clean and
> mostly ready to be accepted to mainline even before we made the first
> proposal to push extents to LKML.

I'm no talking about extends only.  Ext3 now is very, very different
than the ext2+journal it was at the start, with backwards-incompatible
format changes added all the time[1].  These changes went in
no-questions-asked.


> > I think there is something of a problem currently, tough.  It is
> > getting too hard to get code in if you're not a maintainer for an
> > existing subsystem (reiser4, suspend2...), and too easy when you're a
> > maintainer (ext4, uswsusp...).  
> 
> It's not fair to assume that the only reason why non-maintainers have
> a harder time getting changes is because their changes are getting
> more intensive review.

"only", no, definitively not.  The impact is non-negligible though.


> (Although it is the case that we probably do
> need to get better at reviewing changes that go in via git trees.)

Ohh yes, a lot better.  Just look at ALSA, most of SNDRV_HWDEP* should
never have gotten in in the first place, especially some recent ones
like SNDRV_HWDEP_IFACE_SB_RC, and even some (SNDRV_HWDEP_IFACE_USX2Y*)
are security holes the size of Cleveland.  I need to continue
documenting the Alsa kernel interface, but I need a new bucket, the
first one is overflowing.


> A much more important effect is that non-maintainers aren't familiar
> with coding and patch submission guidelines.  For example, in
> suspend2, Nigel first tried with patches that were too monolithic,
> and then his next series was too broken down such that it was too
> hard to review (and "git bisect" wouldn't work).

All his submissions since 2004 or so?  It's a little easy to limit
oneself to the last two ones.


> And of course, there are people who assume that the rules shouldn't
> apply to their filesystem...

It may be a little hard to remove XFS at that point though...  And,
while it's not a filesystem, I'd love to be pointed to the technical
discussion deciding whether uswsusp is a good idea.

  OG.

[1] All optional, I know.
