Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278669AbRJXRlQ>; Wed, 24 Oct 2001 13:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278673AbRJXRlG>; Wed, 24 Oct 2001 13:41:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:15370 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278669AbRJXRkt>;
	Wed, 24 Oct 2001 13:40:49 -0400
Date: Wed, 24 Oct 2001 15:41:02 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: James Sutherland <jas88@cam.ac.uk>
Cc: Jan Kara <jack@suse.cz>, Neil Brown <neilb@cse.unsw.edu.au>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: <Pine.SOL.4.33.0110241646420.24809-100000@yellow.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.33L.0110241540090.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, James Sutherland wrote:

> Yep, you're right: you'd need to ascend the target directory tree,
> increasing the cumulative size all the way up, then do the move and
> decrement the old location's totals in the same way. All wrapped up in a
> transaction (on journalled FSs) or have fsck rebuild the totals on a dirty
> mount. Fairly clean and painless on a JFS,

It's only clean and painless when you have infinite journal
space. When your filesystem's journal isn't big enough to
keep track of all the quota updates from an arbitrarily deep
directory tree, you're in big trouble.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

