Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVDXUqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVDXUqA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVDXUqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:46:00 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:33689 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262410AbVDXUpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:45:54 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-fsdevel@vger.kernel.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <20050424201356.GJ13052@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Sun, 24 Apr 2005 21:13:56 +0100)
Subject: Re: [PATCH] private mounts
References: <E1DPnOn-0000T0-00@localhost> <20050424201356.GJ13052@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1DPnyx-0000Uf-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 22:45:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Comments are appreciated.  If there are no vetoes agains the patch, I
> > think it's suitable for -mm.
> 
> Vetoed.  Having suid application with different pathname resolution than
> that of parent just because it is suid is not acceptable.  I'm sorry,
> but breaking hell knows how many existing applications is not an option.

I'm pretty sure any suid program doing path resolution and other
filesystem operations on _behalf_ of the original user will do them
with fsuid, fsgid set to the original.  Otherwise they are bound to
break in other cases too (NFS export with root_sqash, etc).

Have any counterexamples?

Thanks,
Miklos
