Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966486AbWKNXmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966486AbWKNXmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966487AbWKNXmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:42:39 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:11531 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S966486AbWKNXmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:42:38 -0500
Date: Wed, 15 Nov 2006 10:29:00 +1100
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: "Dennis J.A. Bijwaard" <dennis@h8922032063.dsl.speedlinq.nl>,
       bijwaard@gmail.com, sct@redhat.com, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup detected on CPU#0! in sys_close and ext3
Message-ID: <20061114232900.GD3155@zip.com.au>
References: <20061015175640.GA3673@jumbo.lan> <20061015121202.378bdd41.akpm@osdl.org> <20061015215854.GA12890@jumbo.lan> <20061114095818.GA2541@zip.com.au> <20061114020125.636c9006.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114020125.636c9006.akpm@osdl.org>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 02:01:25AM -0800, Andrew Morton wrote:
> > It did for me in all cases. Should it be taking long enough to trigger
> > the softlock timeout to do this? The size of the device is approx 280gig.
> 
> It's a bit of a worry if it's taking all that time to shoot down 4g of
> pagecache.  The 280G will affect things - the radix-tree will be sparse and
> the invalidate has firther to walk.  But still...

Yeah. I would've thought that legitimate usage would not trigger such
things, which is why I have it on whilst I'm building this box up.

> I assume that a fsck does the same thing?

Just did an e2fsck and it did the same thing.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
