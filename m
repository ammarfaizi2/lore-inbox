Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVGCTkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVGCTkG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVGCTkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:40:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2250 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261505AbVGCTjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:39:42 -0400
Date: Sun, 3 Jul 2005 21:39:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
Subject: Re: FUSE merging?
Message-ID: <20050703193941.GA27204@elf.ucw.cz>
References: <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu> <20050630235059.0b7be3de.akpm@osdl.org> <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu> <20050701001439.63987939.akpm@osdl.org> <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu> <20050701010229.4214f04e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701010229.4214f04e.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > >  I leave the decision to you ;)  It's a separate independent patch
> > > > > >  already (fuse-nfs-export.patch).
> > > > > 
> > > > > Let's leave it out - that'll stimulate some activity in the
> > > > > userspace-nfs-server-for-FUSE area.
> > > > > 
> > > > > Speaking of which, dumb question: what does FUSE offer over simply using
> > > > > NFS protocol to talk to the userspace filesystem driver?
> > > > 
> > > > Oh lots:
> > > > 
> > > >   - no deadlocks (NFS mounted from localhost is riddled with them)
> > > 
> > > It is?  We had some low-memory problems a while back, but they got fixed. 
> > > During that work I did some nfs-to-localhost testing and things seemed OK.
> > 
> > Well, there's the "unsolvable" writeback deadlock problem, that FUSE
> > works around by not buffering dirty pages (and not allowing writable
> > mmap).  Does NFS solve that?  I'm interested :)
> 
> I don't know - first you'd have to describe it.

Actually, the right question is "how is fuse better than coda". I've
asked that before; unlike nfs, userspace filesystems implemented with
coda actually *work*, but do not provide partial-file writes.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
