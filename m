Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936396AbWK3Mgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936396AbWK3Mgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936397AbWK3Mga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:36:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936304AbWK3MgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:36:21 -0500
Subject: Re: [GFS2] split gfs2_dinode into on-disk and host variants [1/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <20061130122538.GA27549@infradead.org>
References: <1164888743.3752.303.camel@quoit.chygwyn.com>
	 <20061130122538.GA27549@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:36:56 +0000
Message-Id: <1164890216.3752.457.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-11-30 at 12:25 +0000, Christoph Hellwig wrote:
> > +	struct gfs2_dinode_host *di = &ip->i_di;
> 
> Please call this things just gfs2_inode.  gfs_d(isk)_inode_host doesn't
> make any sense.
> 
Its not the final intention to keep this dinode_host structure (or
indeed the other _host structures introduced by Al's patches), its a
means to an end. Later patches in my inode shrinking series remove a
number of the fields from it, so it is much smaller. I do want to do
what you are requesting eventually, but I'm working on it a stage at a
time now that Al has pushed me in the right direction,

Steve.


