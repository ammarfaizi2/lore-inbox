Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWGaQQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWGaQQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWGaQQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:16:43 -0400
Received: from mail.fieldses.org ([66.93.2.214]:59812 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1030209AbWGaQQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:16:42 -0400
Date: Mon, 31 Jul 2006 12:16:33 -0400
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] knfsd: Fix stale file handle problem with subtree_checking.
Message-ID: <20060731161633.GB11459@fieldses.org>
References: <20060728194103.7245.patches@notabene> <1060728094255.7278@suse.de> <20060728205156.GB12183@fieldses.org> <17610.62013.790217.817455@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17610.62013.790217.817455@cse.unsw.edu.au>
User-Agent: Mutt/1.5.12-2006-07-14
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 03:29:33PM +1000, Neil Brown wrote:
> The first step would be to stop it from being the default (as Trond
> has suggested a number of times :-)
> 
> How about this.
>  I release a 1.0.10 shortly which addresses some 'portlist' related
>  breakage and prints a nasty warning if you have neither subtree_check
>  or no_subtree_check, but still defaults to subtree_check.
> 
>  Then the next release will be 1.1.0 which prints the same warning,
>  but defaults the other way - and probably removed the warning if you
>  include neither sync not async.
> 
> That should at least get subtree_check to be used less.

Sounds good to me.  (Though for these kinds of changes I suppose it's
the time elasped that matters more than the number of released
versions--people probably upgrade every x months/years/whatever rather
than every x versions.  By that criteria I think we might be making the
subtree_check change a little fast, while the warning period for the
sync change may already be overkill....)

> I think it is a great idea for a 'filesystem' to support multiple
> independent file-trees within the one storage set, which is roughly
> what you are saying I think (though probably not quite).
> 
> However I suspect that most people don't actually want subtrees.  They
> just get it as the default.  It isn't something that I would have
> implemented if I hadn't inherited the requirement, and no other OS
> that I know of provides that particular semantic.

Could be.

--b.
