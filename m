Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUCNSy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 13:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUCNSy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 13:54:26 -0500
Received: from ns.suse.de ([195.135.220.2]:2706 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261502AbUCNSyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 13:54:18 -0500
Subject: Re: [PATCH] lockfs patch for 2.6
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
In-Reply-To: <20040314104439.7c381a09.akpm@osdl.org>
References: <1078867885.25075.1458.camel@watt.suse.com>
	 <20040313131447.A25900@infradead.org>
	 <1079191213.4187.243.camel@watt.suse.com>
	 <20040313163346.A27004@infradead.org> <20040314140032.A8901@infradead.org>
	 <20040314104439.7c381a09.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079290590.4183.258.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Mar 2004 13:56:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-14 at 13:44, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > + * This takes the block device bd_mount_sem to make sure no new mounts
> >  + * happen on bdev until unlockfs is called.  If a super is found on this
> >  + * block device, we hould a read lock on the s->s_umount sem to make sure
> >  + * nobody unmounts until the snapshot creation is done
> >  + */
> >  +struct super_block *freeze_bdev(struct block_device *bdev)
> 
> I think you do need s_umount, as the comments say.  But this patch doesn't
> touch it.

get_super gives us a read lock on it.

-chris


