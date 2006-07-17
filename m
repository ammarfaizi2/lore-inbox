Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWGQO4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWGQO4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWGQO4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:56:08 -0400
Received: from mail.gmx.de ([213.165.64.21]:17291 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750817AbWGQO4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:56:07 -0400
X-Authenticated: #428038
Date: Mon, 17 Jul 2006 16:56:04 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Lexington Luthor <Lexington.Luthor@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserFS?
Message-ID: <20060717145604.GA8276@merlin.emma.line.org>
Mail-Followup-To: Lexington Luthor <Lexington.Luthor@gmail.com>,
	linux-kernel@vger.kernel.org
References: <50d1c22d0607160545rd06c828n55ad9bbbd2f20bfd@mail.gmail.com> <20060716135038.GA8850@merlin.emma.line.org> <e9dm0p$15s$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9dm0p$15s$1@sea.gmane.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2006, Lexington Luthor wrote:

> Matthias Andree wrote:
> >Why would anyone want ReiserFS in the kernel that is discontinued by its
> >developers when it's just started to become stabile and useful, with
> >bugs (hashing) remaining, as happened with 3.6? Who is going to make
> >guarantees this won't happen again with reiser4?
> 
> I looked at the reiser4 patch, and it does very little outside of the 
> fs/reiser4 directory. If it is no longer supported by namesys, why can't 
> it just be removed from the kernel like all the other bits that are 
> obsoleted?

People (including you) would scream blue murder if their file system
were going away. The same would happen if it just didn't work for them.

Somebody, however skilled they may be, just trying out a patch and
finding it works for them is certainly not sufficient reason to judge if
a product is of adequate quality. The code was reviewed, found to
contain major misdesigns, and the maintainers refused to fix those, and
that's it.

> I am just saddened that kernel decisions are motivated by politics and a 
> personal dislike of Hans Reiser rather than technical merit. :(

If you had understood my postings, it had been clear to you that there
have been technical reasons that blocked the inclusion, and there have
additionally been precedences of such misconduct, or maintainers
declaring the system stable when in fact it was years (literally) from
that.

I respect namesys for the efforts they made in getting 3.6 and the
toolchain workable, but some issues remain that some people never run
into, are showstoppers for others, and at that point where minor
polishing was due, namesys moved on to reiser4, dropping 3.6 support -
and that was a decision that made me phase out reiserfs 3.6, and I'm
certainly not looking into reiser4 until 2 years after a first major
distro (that's currently Debian, Ubuntu, Fedora, Opensuse, Mandrake)
ships it as the default root and user FS.

> >There's ext3, you can set the dir_index option (either for mke2fs, or
> >afterwards with tune2fs, then unmount and run e2fsck -fD) and you're set.
> 
> I am not arguing for the inclusion of reiser4 in the kernel, but you 
> should know it has its uses. There are very many things that reiser4 can 
> do that will make ext3 blow up. It simply the best filesystem for many 
> kinds of usage patterns.

Apparently, kernel coding standard applicability doesn't fall into the
usage patterns you're referring to. SCNR. I haven't heard the other
side, but if you're going to contribute to some project you MUST please
its maintainers - life's bad...

-- 
Matthias Andree
