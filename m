Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759721AbWLDV1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759721AbWLDV1M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759728AbWLDV1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:27:12 -0500
Received: from pat.uio.no ([129.240.10.15]:34010 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759721AbWLDV1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:27:10 -0500
Subject: Re: Mounting NFS root FS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Janne Karhunen <Janne.Karhunen@gmail.com>
Cc: MrUmunhum@popdial.com, linux-kernel@vger.kernel.org
In-Reply-To: <200612042205.57577.Janne.Karhunen@gmail.com>
References: <4571CE06.4040800@popdial.com>
	 <200612041912.30527.Janne.Karhunen@gmail.com>
	 <1165256490.711.233.camel@lade.trondhjem.org>
	 <200612042205.57577.Janne.Karhunen@gmail.com>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 16:27:03 -0500
Message-Id: <1165267623.5698.33.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.795, required 12,
	autolearn=disabled, AWL 1.21, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 22:05 +0200, Janne Karhunen wrote:
> On Monday 04 December 2006 20:21, Trond Myklebust wrote:
> 
> > > > 2) NFS provides persistent storage.
> > >
> > > To me this sounds like a chicken and an egg problem. It
> > > both depends and provides this at the same time :/. But
> > > hey, if it's supposed to work then OK.
> >
> > ??? Locking depends on persistent storage, but persistent storage never
> > depended on locking.
> 
> Except for the fact that to be able to mount anything RW you
> generally _want_ to have locks. And can't have locks without 
> the mount. Not that it wouldn't work, it's just that I would
> not do it [for obvious reasons].

You just need to be careful to set it up correctly in the initrd: either
make sure that you mount the root partition as 'nolock' or else make
sure that you mount /var/lib/nfs, and start rpc.statd before you start
init and any other applications that might need locking.

  Trond

