Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVD3J0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVD3J0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 05:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVD3J0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 05:26:25 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:25776 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261169AbVD3J0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 05:26:15 -0400
To: hch@infradead.org
CC: bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050430083516.GC23253@infradead.org> (message from Christoph
	Hellwig on Sat, 30 Apr 2005 09:35:16 +0100)
Subject: Re: [PATCH] private mounts
References: <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost> <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org>
Message-Id: <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Apr 2005 11:25:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I can't write a script that reads your mind. But I sure can write
> > > a script that finds out what you mounted in the other shells (with help
> > > of a little wrapper around the mount command).
> > 
> > How do you bind mount it from a different namespace?  You _do_ need
> > bind mount, since a new mount might require password input, etc...
> 
> Not nessecarily.  The filesystem gets called into ->get_sb for every mount,
> and can then decided whether to return an existing superblock instance or
> setup a new one.  If the credentials for the new mount match an old one
> it can just reuse it.  (e.g. for block based filesystem it will always reuse
> right now)

And if the credentials are checked in userspace (sshfs)?

Miklos
