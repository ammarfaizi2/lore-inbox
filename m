Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWHXGzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWHXGzs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWHXGzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:55:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35540 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030365AbWHXGzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:55:47 -0400
Date: Thu, 24 Aug 2006 16:55:34 +1000
From: Nathan Scott <nathans@sgi.com>
To: Paul Slootman <paul+nospam@wurtel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060824165534.A3003989@wobbly.melbourne.sgi.com>
References: <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com> <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com> <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com> <20060814120032.E2698880@wobbly.melbourne.sgi.com> <ebv3ji$gls$1@news.cistron.nl> <20060817084750.B2787212@wobbly.melbourne.sgi.com> <20060817090149.GA7919@wurtel.net> <20060823084210.GA7106@wurtel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060823084210.GA7106@wurtel.net>; from paul+nospam@wurtel.net on Wed, Aug 23, 2006 at 10:42:10AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 10:42:10AM +0200, Paul Slootman wrote:
> 
> I compiled 2.6.17.9 yesterday with gcc 4.1 (the previous kernel that
> showed problems was 2.6.17.7 compiled with gcc 3.3.5), and the same
> problem showed itself again, after 2.6.15.6 had run with no problems
> whatsoever for 5 days.
> 
> I'll now give 2.6.16.1 a go (we have that kernel lying around :-)

Hmm, if there's no reproducible case, next best thing is a git bisect
to try to identify potential commits which are causing the problem...
not easy on your production server, I know.  I had believed this to be
a long-standing issue though, I'm sure I've seen it reported before -
we've never had any information to go on to try to diagnose it however.
Jesper's rename hint is the most helpful information we've had so far.

> BTW, what's the significance of the xfs_repair message
> LEAFN node level is 1 inode 827198 bno = 8388608
> (I see a lot more of these this time round).

It basically means a directory inode's btree has got into an invalid
state, somehow.

cheers.

-- 
Nathan
