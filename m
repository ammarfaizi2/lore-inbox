Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVDLFrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVDLFrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVDLFrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:47:15 -0400
Received: from orb.pobox.com ([207.8.226.5]:48107 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262068AbVDLFmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:42:14 -0400
Date: Mon, 11 Apr 2005 22:42:03 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@engr.sgi.com>,
       pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
Message-ID: <20050412054203.GA8008@ip68-4-98-123.oc.oc.cox.net>
References: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu> <20050411074552.4e2e656b.pj@engr.sgi.com> <20050411151204.GA5562@elte.hu> <Pine.LNX.4.58.0504110826140.1267@ppc970.osdl.org> <20050411153905.GA7284@elte.hu> <Pine.LNX.4.58.0504110852260.1267@ppc970.osdl.org> <20050411163358.GA9696@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411163358.GA9696@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 06:33:58PM +0200, Ingo Molnar wrote:
> ok. Meanwhile i found another counter-argument: the average committed 
> file size is 36K, which with gzip -9 would compress down to roughly 8K, 
> with the commit message being another block. That's 2+1 blocks used per 
> commit, while with deltas one could at most cut this down to 1+1+1 
> blocks - just as much space! So we would be almost even with the more 
> complex delta approach, just by increasing the default compression ratio 
> from 6 to 9. (but even with the default we are not that bad.)

I think you forgot about reiserfs/reiser4 tails. (At least, I *think*
reiser4 has tails. I know reiserfs 3.x does.)

BTW, I happen to agree completely with Linus on this issue, but I still
figured I'd mention this for the sake of completeness.

-Barry K. Nathan <barryn@pobox.com>
