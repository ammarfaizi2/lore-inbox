Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUHYUcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUHYUcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268637AbUHYUaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:30:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:16286 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268591AbUHYUYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:24:51 -0400
Date: Wed, 25 Aug 2004 13:24:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@lst.de>
cc: Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040825201929.GA16855@lst.de>
Message-ID: <Pine.LNX.4.58.0408251323170.17766@ppc970.osdl.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825200859.GA16345@lst.de> <20040825201929.GA16855@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Aug 2004, Christoph Hellwig wrote:
> 
> Over the last at least five years we've taken as much as possible
> semantics out of the filesystems and into the VFS layer, thus having
> a separation between the semantical layer (VFS) and the low level
> filesystem.  Your attributes are absoultely a VFS thing and as such
> should not happen at the filesystem layer, and no, that doesn't mean
> they're bad per se, I just think they are a rather bad fit for Linux.

Now this I agree with, in the sense that I think that if we want to 
support this, it should be supported at a VFS layer. 

On the other hand, I think doing it inside the filesystem with ugly hacks 
is an acceptable way to prototype the idea before it's been proven to 
really be workable. Maybe it has more problems with legacy apps than we'd 
expect..

		Linus
