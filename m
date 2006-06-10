Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWFJVcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWFJVcN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 17:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWFJVcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 17:32:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20189 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161022AbWFJVcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 17:32:12 -0400
Date: Sat, 10 Jun 2006 14:31:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Theodore Tso <tytso@mit.edu>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Jeff Garzik <jeff@garzik.org>,
       Chase Venters <chase.venters@clientec.com>,
       Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <20060610212624.GD6641@thunk.org>
Message-ID: <Pine.LNX.4.64.0606101429160.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
 <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
 <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <4489C580.7080001@garzik.org>
 <17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com> <Pine.LNX.4.64.0606101238110.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606101248030.5498@g5.osdl.org> <20060610212624.GD6641@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Jun 2006, Theodore Tso wrote:
>
> 	So you you would be in OK of a model where we copy fs/ext3 to
> "fs/ext4", and do development there which would merged rapidly into
> mainline so that people who want to participate in testing can use
> ext3dev, while people who want stability can use ext3

Absolutely.

> --- and at some
> point, we remove the old ext3 entirely and let fs/ext4 register itself
> as both the ext3 and ext4 filesystem, and at some point in the future,
> remove the ext3 name entirely?

Maybe, and maybe not. That depends on where ext4 is when the thing calms 
down.

Look at what happened to ext2. Would you seriously suggest removing it 
just because ext3 does more than ext2 does?

And yes, if I recall correctly, all the same ext2 people were against the 
whole ext2->ext3 split also, which we did for the same reason - I and 
others refused to let people "hack on" the standard stable filesystem.

Yet I don't see anybody in this discussion saying "I admit I was wrong 
back then - the split was correct". Hmm. I wonder where those people went?

		Linus
