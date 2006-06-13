Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWFMA3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWFMA3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWFMA3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:29:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:27090 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932319AbWFMA3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:29:03 -0400
Subject: Re: Stable/devel policy - was Re: [Ext2-devel] [RFC 0/13] extents
	and 48bit ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Neil Brown <neilb@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       Linus Torvalds <torvalds@osdl.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Chase Venters <chase.venters@clientec.com>,
       Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <17547.40585.982575.7069@cse.unsw.edu.au>
References: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	 <20060609181020.GB5964@schatzie.adilger.int>
	 <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
	 <m31wty9o77.fsf@bzzz.home.net>
	 <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
	 <4489C580.7080001@garzik.org>
	 <17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com>
	 <Pine.LNX.4.64.0606101238110.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606101248030.5498@g5.osdl.org>
	 <20060610212624.GD6641@thunk.org> <448B45ED.1040209@garzik.org>
	 <17547.40585.982575.7069@cse.unsw.edu.au>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 12 Jun 2006 17:28:58 -0700
Message-Id: <1150158539.3719.25.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-11 at 14:39 +1000, Neil Brown wrote:
> On Saturday June 10, jeff@garzik.org wrote:
> > Theodore Tso wrote:
> > > 	So you you would be in OK of a model where we copy fs/ext3 to
> > > "fs/ext4", and do development there which would merged rapidly into
> > > mainline so that people who want to participate in testing can use
> > > ext3dev, while people who want stability can use ext3 --- and at some
> > > point, we remove the old ext3 entirely and let fs/ext4 register itself
> > > as both the ext3 and ext4 filesystem, and at some point in the future,
> > > remove the ext3 name entirely?
> > 
> > Yep, and in addition I would argue that you can take the opportunity to 
> > make ext4 default to extents-enabled, and some similar behavior changes 
> > (dir_index default?).  The existence of both ext3 and ext4 means you can 
> > be more aggressive in turning on stuff, IMO.
> > 
> > 	Jeff
> 
> I'm wondering what all this has to say about general principles of
> sub-project development with the Linux kernel.
> 
> There is a strong tradition of software projects having a 'stable'
> branch and a 'development' branch, and having both available and both
> receiving bug fixes (at least) so that users can choose what best
> suits their needs.
> 
> Due to the (quite appropriate) lack of a stable API for kernel
> modules, it isn't really practical (and definitely isn't encouraged)
> to distribute kernel-modules separately.  This seems to suggest that
> if we want a 'stable' and a 'devel' branch of a project, both branches
> need to be distributed as part of the same kernel tree.
> 
> Apart from ext2/3 - and maybe reiserfs - there doesn't seem to be much
> evidence of this happening.  Why is that?
> 
>  - is -mm enough?  It seems to be enough for small updates, but
>    doesn't seem to be enough for more major projects.  How long
>    have the ext3 patches been in -mm?? (I cannot actually seem
>    to find them there at all)
> 

To clarify, the first 4 patches of the series are bug fixes for both 32
bit ext3 (with current on-disk layout) and 48 bit ext3(extents based),
they are in mm tree now. The rest of the patches 5-13 to support 48 bit
ext3 based on extents are not in mm tree.


