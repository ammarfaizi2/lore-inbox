Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313453AbSDPBhg>; Mon, 15 Apr 2002 21:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313455AbSDPBhf>; Mon, 15 Apr 2002 21:37:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46085 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313453AbSDPBhf>; Mon, 15 Apr 2002 21:37:35 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: link() security
Date: 15 Apr 2002 18:37:19 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a9fv8f$l3t$1@cesium.transmeta.com>
In-Reply-To: <20020415143641.A46232@hiwaay.net> <a9fb6v$d2f$1@cesium.transmeta.com> <s5g3cxwk8bv.fsf@egghead.curl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <s5g3cxwk8bv.fsf@egghead.curl.com>
By author:    "Patrick J. LoPresti" <patl@curl.com>
In newsgroup: linux.dev.kernel
> > 
> > It depends on your access patterns.  Newer news server use what I
> > would classify as custom filesystems (which is what binary databases
> > are, by and large) rather than "single files."
> 
> Exactly.  Although I would go farther.
> 
> I would not be at all surprised if a traditional news spool worked
> just fine on a "real" high-performance file system; i.e., one whose
> lookup/creat/unlink was not linear in the number of directory entries.
> I wonder how well an old-fashioned news spool would perform on XFS,
> for instance.
> 
> "One file per message" has many advantages, both for news and for
> mail.  The biggest advantage is conceptual simplicity.  It is really
> nice when you can use traditional Unix tools (like grep, mv, rm) to
> fix things when they break.  Because they always break, sooner or
> later.
> 
> Sure, you may wind up with 50,000 files in one directory.  But I would
> rather rely on the filesystem wizards to deal with that than switch to
> some obscure custom database format.  Maybe that's just me...
> 

I think the biggest problem with the one-file-per-message format is
that you still want to maintain some kind of metadata (.overview
files.)  This is cached information, but still needs to be maintained,
so you don't end up opening up every file to get the overview data.
With a application-specific store, you can make that more explicit.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
