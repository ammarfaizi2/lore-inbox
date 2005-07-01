Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbVGAPV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbVGAPV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 11:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbVGAPV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 11:21:26 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:6071 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263371AbVGAPUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 11:20:04 -0400
Date: Fri, 1 Jul 2005 17:20:03 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging?
Message-ID: <20050701152003.GA7073@janus>
References: <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <20050630222828.GA32357@janus> <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu> <20050701092444.GA4317@janus> <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu> <20050701120028.GB5218@janus> <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu> <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 03:21:59PM +0200, Miklos Szeredi wrote:
> 
> > To require an empty stub to mount FUSE upon makes the whole picture
> > cleaner: users are only able to extend the namespace _leaf_ nodes for
> > themselves and processes they can send signals to: setuid programs
> > which do not fully become root. The existing namespace [nodes] remains
> > unchanged for everyone.
> 
> It's not as simple.  A filesystem can be mounted many times (either
> with mount --bind, or just by mounting the same device on multiple
> mountpoints).  In this case you can't ensure, that a mountpoint will
> remain a leaf node after being mounted on.

I have bind-mounted / on /net/blabla
I tried two experiments:

	mounting something under / and looking for it under /net/blabla
	mounting something under /net/blabla and looking for it under /

The experiment was done with bind mounts and by mounting a USB stick
(/dev/sdb1) and there was no auto propagation of mounts.

(2.6.12-rc6)

How can a leaf dir suddenly become non-leaf by a mount without an explicit
mount command?

-- 
Frank
