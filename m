Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWHXJH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWHXJH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 05:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWHXJH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 05:07:27 -0400
Received: from xs.wurtel.net ([83.68.3.130]:36752 "EHLO mx.wurtel.net")
	by vger.kernel.org with ESMTP id S1750962AbWHXJH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 05:07:27 -0400
Date: Thu, 24 Aug 2006 11:07:03 +0200
From: Paul Slootman <paul+nospam@wurtel.net>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060824090703.GB1422@wurtel.net>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org
References: <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com> <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com> <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com> <20060814120032.E2698880@wobbly.melbourne.sgi.com> <ebv3ji$gls$1@news.cistron.nl> <20060817084750.B2787212@wobbly.melbourne.sgi.com> <20060817090149.GA7919@wurtel.net> <20060823084210.GA7106@wurtel.net> <20060824165534.A3003989@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824165534.A3003989@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Scanner: exiscan *1GGBB2-00052e-00*B0ZYm7q/4wM*Wurtel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 Aug 2006, Nathan Scott wrote:
> On Wed, Aug 23, 2006 at 10:42:10AM +0200, Paul Slootman wrote:
> > 
> > I compiled 2.6.17.9 yesterday with gcc 4.1 (the previous kernel that
> > showed problems was 2.6.17.7 compiled with gcc 3.3.5), and the same
> > problem showed itself again, after 2.6.15.6 had run with no problems
> > whatsoever for 5 days.
> > 
> > I'll now give 2.6.16.1 a go (we have that kernel lying around :-)

That also fell over.

> Hmm, if there's no reproducible case, next best thing is a git bisect
> to try to identify potential commits which are causing the problem...
> not easy on your production server, I know.  I had believed this to be
> a long-standing issue though, I'm sure I've seen it reported before -
> we've never had any information to go on to try to diagnose it however.
> Jesper's rename hint is the most helpful information we've had so far.

To me it seems to have happened somewhere between 2.6.15.6 and 2.6.16.1 :)
I'll have to boot with 2.6.15.6 again and run that for a couple of days,
after that I'll try some kernel  2.6.15.6 < x < 2.6.16.1 (any
suggestions?)


> > BTW, what's the significance of the xfs_repair message
> > LEAFN node level is 1 inode 827198 bno = 8388608
> > (I see a lot more of these this time round).
> 
> It basically means a directory inode's btree has got into an invalid
> state, somehow.

Hmm, what version of xfs_repair is supposed to fix that? Because neither
the 2.6.20 version that comes with Debian nor the CVS version of August
10 which calls itself 2.8.11 makes it go away (i.e. multiple runs will
persistently show those lines).


thanks,
Paul Slootman
