Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVARLBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVARLBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 06:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVARLBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 06:01:45 -0500
Received: from colin2.muc.de ([193.149.48.15]:17938 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261252AbVARLBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 06:01:32 -0500
Date: 18 Jan 2005 12:01:28 +0100
Date: Tue, 18 Jan 2005 12:01:28 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Hellwig <hch@infradead.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, chrisw@osdl.org, davem@davemloft.net
Subject: Re: [PATCH 2/5] socket ioctl fix (from Andi)
Message-ID: <20050118110128.GA43344@muc.de>
References: <20050118072133.GB76018@muc.de> <20050118104816.GB23127@mellanox.co.il> <20050118105522.GA25875@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118105522.GA25875@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
> > +	if (S_ISSOCK(filp->f_dentry->d_inode->i_mode) &&
> > +	    cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
> >  		error = siocdevprivate_ioctl(fd, cmd, arg);
> 
> Maybe this should move into a new sock_compat_ioctl() instead?
> 

Seems like overkill for 3 lines of code.

-Andi
