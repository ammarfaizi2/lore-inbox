Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268858AbUHZNkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268858AbUHZNkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268840AbUHZNkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:40:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:58833 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268881AbUHZNjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:39:55 -0400
Subject: Re: silent semantic changes with reiser4
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <412DA25E.9090405@namesys.com>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825200859.GA16345@lst.de> <20040825201929.GA16855@lst.de>
	 <412DA25E.9090405@namesys.com>
Content-Type: text/plain
Message-Id: <1093527487.21878.270.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 09:38:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 04:42, Hans Reiser wrote:
> Christoph Hellwig wrote:
> 
> >
> >Over the last at least five years we've taken as much as possible
> >semantics out of the filesystems and into the VFS layer, thus having
> >a separation between the semantical layer (VFS) and the low level
> >filesystem.
> >
> VFS is the common filesystem layer.  The only reason you think semantics 
> belong in the common filesystem layer is that you are not innovating in 
> your semantics, and feel content with stasis.

This misunderstanding is the heart of the problem really.  In many ways,
the VFS is the semantic layer, it defines the picture of the directory
tree and the locking rules the applications see.

There's no rule that says you can't innovate in the VFS, in fact it is
where the semantic innovations belong.  Putting them there is what
allows other filesystems to implement your semantics, and this is
exactly what linux needs if these new semantics are going to be
standardized.

In other words, writing a reiser4 plugin is one way to get to the new
semantics, but it must not be the only way.  Keeping them entirely
within reiser4 is good for the research stage, but for actual deployment
they need to be finalized and pushed up.

If the early linux filesystems had taken the same attitude you have
(don't write new filesystems, only write plugins), there would be no
framework allowing the wealth of filesystems we do have, including
reiser4.

-chris


