Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUCNSxB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 13:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUCNSxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 13:53:01 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:5394 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261468AbUCNSw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 13:52:58 -0500
Date: Sun, 14 Mar 2004 18:52:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mason@suse.com, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [PATCH] lockfs patch for 2.6
Message-ID: <20040314185254.A10989@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, mason@suse.com,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <1078867885.25075.1458.camel@watt.suse.com> <20040313131447.A25900@infradead.org> <1079191213.4187.243.camel@watt.suse.com> <20040313163346.A27004@infradead.org> <20040314140032.A8901@infradead.org> <20040314104439.7c381a09.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040314104439.7c381a09.akpm@osdl.org>; from akpm@osdl.org on Sun, Mar 14, 2004 at 10:44:39AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 10:44:39AM -0800, Andrew Morton wrote:
> > + * This takes the block device bd_mount_sem to make sure no new mounts
> >  + * happen on bdev until unlockfs is called.  If a super is found on this
> >  + * block device, we hould a read lock on the s->s_umount sem to make sure
> >  + * nobody unmounts until the snapshot creation is done
> >  + */
> >  +struct super_block *freeze_bdev(struct block_device *bdev)
> 
> I think you do need s_umount, as the comments say.  But this patch doesn't
> touch it.

get_super takes it for us.

