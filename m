Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313217AbSDOUgh>; Mon, 15 Apr 2002 16:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313220AbSDOUgg>; Mon, 15 Apr 2002 16:36:36 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:52731 "HELO
	egghead.curl.com") by vger.kernel.org with SMTP id <S313217AbSDOUgf>;
	Mon, 15 Apr 2002 16:36:35 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: link() security
In-Reply-To: <20020415143641.A46232@hiwaay.net> <a9fb6v$d2f$1@cesium.transmeta.com>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 15 Apr 2002 16:36:36 -0400
Message-ID: <s5g3cxwk8bv.fsf@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> > Funny that news server authors realized that storing messages in files
> > by themselves is a bad idea, while at the same time mail server authors
> > realized that storing messages together in a single file is a bad idea.
> > Which one is right?  Both?  Neither?
> > 
> 
> It depends on your access patterns.  Newer news server use what I
> would classify as custom filesystems (which is what binary databases
> are, by and large) rather than "single files."

Exactly.  Although I would go farther.

I would not be at all surprised if a traditional news spool worked
just fine on a "real" high-performance file system; i.e., one whose
lookup/creat/unlink was not linear in the number of directory entries.
I wonder how well an old-fashioned news spool would perform on XFS,
for instance.

"One file per message" has many advantages, both for news and for
mail.  The biggest advantage is conceptual simplicity.  It is really
nice when you can use traditional Unix tools (like grep, mv, rm) to
fix things when they break.  Because they always break, sooner or
later.

Sure, you may wind up with 50,000 files in one directory.  But I would
rather rely on the filesystem wizards to deal with that than switch to
some obscure custom database format.  Maybe that's just me...

 - Pat
