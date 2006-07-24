Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWGXNjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWGXNjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWGXNjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:39:44 -0400
Received: from thunk.org ([69.25.196.29]:28298 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932160AbWGXNjn (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:39:43 -0400
Date: Mon, 24 Jul 2006 09:39:39 -0400
From: Theodore Tso <tytso@mit.edu>
To: Olivier Galibert <galibert@pobox.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Nikita Danilov <nikita@clusterfs.com>, Steve Lord <lord@xfs.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060724133939.GA11353@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Olivier Galibert <galibert@pobox.com>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
	Nikita Danilov <nikita@clusterfs.com>, Steve Lord <lord@xfs.org>
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C42B92.40507@xfs.org> <17604.31844.765717.375423@gargle.gargle.HOWL> <20060724103023.GA7615@thunk.org> <20060724113534.GA64920@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724113534.GA64920@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 01:35:34PM +0200, Olivier Galibert wrote:
>Ext patches don't get reviewed much
> outside of the developpers, and they go in pretty much without
> discussion in any case, except when Linus blows a fuse.

Um, you're kidding, right?  We certainly don't make the assumption
that we can violate CodingStyle willy nilly and stuff in yacc grammers
into ext3 and assume that no one will push back.

In fact we did a lot of work to make sure the patches were clean and
mostly ready to be accepted to mainline even before we made the first
proposal to push extents to LKML.

> I think there is something of a problem currently, tough.  It is
> getting too hard to get code in if you're not a maintainer for an
> existing subsystem (reiser4, suspend2...), and too easy when you're a
> maintainer (ext4, uswsusp...).  

It's not fair to assume that the only reason why non-maintainers have
a harder time getting changes is because their changes are getting
more intensive review.  (Although it is the case that we probably do
need to get better at reviewing changes that go in via git trees.)  A
much more important effect is that non-maintainers aren't familiar
with coding and patch submission guidelines.  For example, in
suspend2, Nigel first tried with patches that were too monolithic, and
then his next series was too broken down such that it was too hard to
review (and "git bisect" wouldn't work).  And of course, there are
people who assume that the rules shouldn't apply to their filesystem...

						- Ted
