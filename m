Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWGDMcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWGDMcE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWGDMcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:32:03 -0400
Received: from styx.suse.cz ([82.119.242.94]:40346 "EHLO elijah.suse.cz")
	by vger.kernel.org with ESMTP id S932242AbWGDMcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:32:01 -0400
Subject: Re: ext4 features (salvage)
From: Petr Tesarik <ptesarik@suse.cz>
To: Lex Lyamin <flx@namesys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <80294dc60607040508l1022d164ybe0ba10858e54f0c@mail.gmail.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	 <20060703205523.GA17122@irc.pl>
	 <1151960503.3108.55.camel@laptopd505.fenrus.org>
	 <44A9904F.7060207@wolfmountaingroup.com>
	 <20060703232547.2d54ab9b.diegocg@gmail.com>
	 <1152004929.3374.13.camel@elijah.suse.cz> <1152012907.23628.20.camel@lappy>
	 <1152013961.3374.78.camel@elijah.suse.cz>
	 <80294dc60607040508l1022d164ybe0ba10858e54f0c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: SuSE CR
Date: Tue, 04 Jul 2006 14:31:56 +0200
Message-Id: <1152016317.3374.94.camel@elijah.suse.cz>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 16:08 +0400, Lex Lyamin wrote:
> you mean that blocks are naturaly free, but we cant use them because
> someone may made them free by accident, but we cant use them...
> 
> hmm...
> great idea!
> 
> wait, its not.
> because of we cant use those blocks we cant optimise way we write one
> disk , and if we have defragmenter we cant  make use of them either.
> and if (just if) this is online defragmenter, it cant use them too. 

Well, the way I saw it done was that you had no guarantee that any
deleted file could be salvaged. Sometimes you even could salvage a file
but not another one which was deleted later. Users seemed to be content
with that, because in most situations it did help them restore files
they deleted and within a few seconds realized that they didn't want to.

This means that the allocator MAY purge any deleted block at any moment,
although it tends to allocate blocks from areas of disk which haven't
been used recently.

And the benefits? The performance of such a filesystem could be better
than snapshots, while allowing to cope with one of the most common human
errors.

Regards,
Petr Tesarik

> for what purpose ?
> are not we trying  play out solution to problem from level 3 on level
> 2 ?
> does the soulion really belong to this level ?
> would people pay with performance for "feature" which *probably* will
> help them to restore their files ? 



