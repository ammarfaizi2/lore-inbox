Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVEYE4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVEYE4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 00:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVEYE4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 00:56:34 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:30870 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262266AbVEYE4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 00:56:30 -0400
Subject: Re: [RFC][patch 4/7] v9fs: VFS superblock operations (2.0-rc6)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
In-Reply-To: <a4e6962a0505241208214a200f@mail.gmail.com>
References: <200505232225.j4NMPte1029529@ms-smtp-02-eri0.texas.rr.com>
	 <84144f0205052400113c6f40fc@mail.gmail.com>
	 <a4e6962a0505241208214a200f@mail.gmail.com>
Date: Wed, 25 May 2005 07:54:03 +0300
Message-Id: <1116996843.9580.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-05-24 at 14:08 -0500, Eric Van Hensbergen wrote:
> Thanks for the comments!  A bit of a clarification on slab policy - I
> did my own find_slab() so I could keep tight control over my own slabs
> (and monitor for slab leaks, etc.).  There seems to be similar
> functionality for the malloc slabs (kmem_find_general_cachep), but I'm
> not sure if this is really something that is generally useful.  What
> do folks think?  Is this something that would be generally useful to
> add to slab.c?  Or is there something like this that I just
> overlooked?

Most subsystems also implement this (a custom allocator for tracking
memory leaks) so, yes, I think it's generally useful. However, adding
yet another custom allocator is not the way to go. Perhaps some of the
fs developers could cue in here to talk about how they track memory
leaks? Pretty please?

In the meantime, please drop the custom allocator from your code.

			Pekka

