Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263265AbVGAHIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263265AbVGAHIB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbVGAHIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:08:00 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:5124 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263256AbVGAHHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:07:48 -0400
To: akpm@osdl.org
CC: aia21@cam.ac.uk, arjan@infradead.org, linux-kernel@vger.kernel.org,
       frankvm@frankvm.com
In-reply-to: <20050630235059.0b7be3de.akpm@osdl.org> (message from Andrew
	Morton on Thu, 30 Jun 2005 23:50:59 -0700)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<20050630022752.079155ef.akpm@osdl.org>
	<E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	<1120125606.3181.32.camel@laptopd505.fenrus.org>
	<E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	<1120126804.3181.34.camel@laptopd505.fenrus.org>
	<1120129996.5434.1.camel@imp.csi.cam.ac.uk>
	<20050630124622.7c041c0b.akpm@osdl.org>
	<E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu> <20050630235059.0b7be3de.akpm@osdl.org>
Message-Id: <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 09:07:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >  > - aren't we going to remove the nfs semi-server feature?
> > 
> >  I leave the decision to you ;)  It's a separate independent patch
> >  already (fuse-nfs-export.patch).
> 
> Let's leave it out - that'll stimulate some activity in the
> userspace-nfs-server-for-FUSE area.
> 
> Speaking of which, dumb question: what does FUSE offer over simply using
> NFS protocol to talk to the userspace filesystem driver?

Oh lots:

  - no deadlocks (NFS mounted from localhost is riddled with them)

  - efficient protocol, optimized for less context switches

  - dcache invalidation policy
  
  - probably more, but I can't remember

Miklos
