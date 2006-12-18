Return-Path: <linux-kernel-owner+w=401wt.eu-S1753466AbWLRHmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbWLRHmk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 02:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbWLRHmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 02:42:40 -0500
Received: from brick.kernel.dk ([62.242.22.158]:24668 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467AbWLRHmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 02:42:39 -0500
Date: Mon, 18 Dec 2006 08:44:17 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Damien Wyart <damien.wyart@free.fr>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com, xfs-masters@oss.sgi.com, Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.20-rc1-mm1
Message-ID: <20061218074417.GC5010@kernel.dk>
References: <20061214225913.3338f677.akpm@osdl.org> <20061215203936.GA2202@localhost.localdomain> <20061215130141.fd6a0c25.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215130141.fd6a0c25.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15 2006, Andrew Morton wrote:
> On Fri, 15 Dec 2006 21:39:36 +0100
> Damien Wyart <damien.wyart@free.fr> wrote:
> 
> > With this new kernel, I notice two messages I do not have with
> > 2.6.19-rc6-mm2 :
> > 
> > Dec 15 20:00:47 brouette kernel: Filesystem "sdb9": Disabling barriers,trial barrier write failed
> > Dec 15 20:00:47 brouette kernel: Filesystem "sda5": Disabling barriers,trial barrier write failed
> > 
> > Nothing changed in the config between the two, and going back to
> > 2.6.19-rc6-mm2 do not give the messages.
> 
> I don't think anything has changed in this area in XFS.  I'd expect that
> something got broken in sata, ata_piix or the block core which caused the
> "trial barrier write" to start failing.  Various cc's hopefully added.

There hasn't been any barrier changes lately (or block layer handling of
such), so I don't think it's in that area. I'll do some barrier testing
today to verify that things work for me.

-- 
Jens Axboe

