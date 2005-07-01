Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbVGALfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbVGALfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 07:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbVGALfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 07:35:00 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:54710 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263306AbVGALeK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 07:34:10 -0400
Date: Fri, 1 Jul 2005 13:34:08 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging?
Message-ID: <20050701113408.GA5218@janus>
References: <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu> <20050701093627.GB4317@janus> <E1DoJ1O-0002cu-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DoJ1O-0002cu-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 12:45:22PM +0200, Miklos Szeredi wrote:
> > > 
> > > Here's a description of a theoretical DoS scenario:
> > > 
> > >   http://marc.theaimsgroup.com/?l=linux-fsdevel&m=111522019516694&w=2
> > 
> > So the open() hangs indefinately. but what if blackhat tries to install
> > a package from a no longer existing server on /net or via NFS?
> > 
> > A user supplied pathname is not to be trusted by any setuid (or full
> > root) program.
> 
> If /net won't detect a dead server within a timeout, I think it can be
> considered broken.
> 
> > Another example: I'm not sure if there are still /dev/tty devices which
> > may block indefinately upon open() but:
> > 
> > -	I have yet to see a setuid program which always uses O_NONBLOCK
> > 	when opening user supplied pathnames.
> > -	one cannot stat() and then open() because that gives a race.
> 
> Is "being already broken" an excuse for preventing future breakage,
> when these are fixed?

All this breakage points into the same direction: A user supplied pathname
is not to be trusted by any setuid (or full root) program.

-- 
Frank
