Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRJ3S3L>; Tue, 30 Oct 2001 13:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277393AbRJ3S3B>; Tue, 30 Oct 2001 13:29:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11014 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277294AbRJ3S2s>; Tue, 30 Oct 2001 13:28:48 -0500
Date: Tue, 30 Oct 2001 19:29:02 +0100
From: Jan Kara <jack@suse.cz>
To: "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        miles@megapathdsl.net, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: What is standing in the way of opening the 2.5 tree?
Message-ID: <20011030192902.B22781@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1004219488.11749.19.camel@stomata.megapathdsl.net> <3BDB91D7.C7975C44@mandrakesoft.com> <20011027.224602.74750641.davem@redhat.com> <20011028185844.C1311@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011028185844.C1311@lynx.no>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Oct 27, 2001  22:46 -0700, David S. Miller wrote:
> > In particular, the quota stuff, which has sat in Alan's tree forever.
> > If Linus is ignoring the changes it probably is for a good reason
> > but it would be nice for him to let Alan know what that reason is :-)
> 
> AFAIK (not much, since I don't use quotas), the on-disk quota format used
> by Alan's tree was changed to support 32-bit UID/GIDs, which makes it
> incompatible with that used in the Linus tree.  However, there was also
> some quota merging done in 2.4.13 or so, which _may_ have resolved this.
  Actually there were two quota patches in Alan's tree. The first one was
just some fixes in quota code - some locking changes, race fixes, dynamic allocation
of quota structures. This patch went into 2.2.12.
  The second patch is patch which implements new quota format. It makes
changes in quotactl() interface and other changes visible in userspace.
I think that is the reason why Linus doesn't want it in 2.4 and I agree with him.

> Yes, it's vague, but nobody else has answered yet.  I'm only aware of these
> issues because the ext3 code had to work with both trees, and the quota
> compat stuff was removed in the most recent ext3 release.  That may have
> only been an in-kernel API issue and not the on-disk format, I don't know.
> 
> Cheers, Andreas

								Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs
