Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWFJWVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWFJWVn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 18:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWFJWVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 18:21:43 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:16583 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161034AbWFJWVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 18:21:42 -0400
Message-ID: <448B45ED.1040209@garzik.org>
Date: Sat, 10 Jun 2006 18:21:33 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, Jeff Garzik <jeff@garzik.org>,
       Chase Venters <chase.venters@clientec.com>,
       Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org> <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <4489C580.7080001@garzik.org> <17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com> <Pine.LNX.4.64.0606101238110.5498@g5.osdl.org> <Pine.LNX.4.64.0606101248030.5498@g5.osdl.org> <20060610212624.GD6641@thunk.org>
In-Reply-To: <20060610212624.GD6641@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> 	So you you would be in OK of a model where we copy fs/ext3 to
> "fs/ext4", and do development there which would merged rapidly into
> mainline so that people who want to participate in testing can use
> ext3dev, while people who want stability can use ext3 --- and at some
> point, we remove the old ext3 entirely and let fs/ext4 register itself
> as both the ext3 and ext4 filesystem, and at some point in the future,
> remove the ext3 name entirely?

Yep, and in addition I would argue that you can take the opportunity to 
make ext4 default to extents-enabled, and some similar behavior changes 
(dir_index default?).  The existence of both ext3 and ext4 means you can 
be more aggressive in turning on stuff, IMO.

	Jeff


