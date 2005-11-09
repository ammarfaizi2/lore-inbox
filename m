Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVKIXVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVKIXVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVKIXVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:21:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750700AbVKIXVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:21:43 -0500
Date: Wed, 9 Nov 2005 15:21:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       James.Bottomley@steeleye.com, len.brown@intel.com, jgarzik@pobox.com,
       bcollins@debian.org, scjody@modernduck.com, dwmw2@infradead.org,
       rolandd@cisco.com, davej@codemonkey.org.uk, axboe@suse.de,
       shaggy@austin.ibm.com, sfrench@us.ibm.com
Subject: Re: merge status
Message-Id: <20051109152125.21bfd8a9.akpm@osdl.org>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F04EADD18@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F04EADD18@scsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> wrote:
>
> > -rw-r--r--    1 akpm     akpm        78245 Nov  9 11:19 git-ia64.patch
> 
> Some of this size may be a git artifact (or to be strictly accurate
> an artifact of the way I maintain my git branches).  I just merged
> up the latest linus branch into my test tree, and then ran:
> 
>  $ git diff linus test
> 
> which only came up with 34799 bytes of diff.

Yes, sorry, I'd forgotten that I'm now including `git log' output in the
git-*.patch files.

diffstat patches/git-ia64.patch says:
 13 files changed, 364 insertions(+), 181 deletions(-)

>  The extra bytes you
> see may be due to some commits that went into my test tree, but
> I goofed some of the comments ... so I ended up with the same patches
> going to my release tree, but as different commits.  I assume that
> quilt then figures out that this stuff is already in Linus tree?
> 
> I think that I may need to periodically ditch and re-create my test
> branch ... it is full of "Auto-update from upstream" commits, plus
> all the commits to pull in topic branches.  So when I've merged
> over all the topic branches to send to Linus the contents of the
> tree exactly match my release tree ... the history is very different
> (and somewhat messy in places).

Yes, the `git log' output is >40k and is stuffed full of "Pull ...  into
...  branch" and "Auto-update from upstream" messages.  I wonder if there's
some way of asking git-diff to omit that stuff..

