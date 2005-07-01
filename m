Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVGAKp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVGAKp7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 06:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbVGAKp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 06:45:58 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:24335 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261463AbVGAKpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 06:45:53 -0400
To: frankvm@frankvm.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
In-reply-to: <20050701093627.GB4317@janus> (message from Frank van Maarseveen
	on Fri, 1 Jul 2005 11:36:27 +0200)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu> <20050701093627.GB4317@janus>
Message-Id: <E1DoJ1O-0002cu-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 12:45:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Here's a description of a theoretical DoS scenario:
> > 
> >   http://marc.theaimsgroup.com/?l=linux-fsdevel&m=111522019516694&w=2
> 
> So the open() hangs indefinately. but what if blackhat tries to install
> a package from a no longer existing server on /net or via NFS?
> 
> A user supplied pathname is not to be trusted by any setuid (or full
> root) program.

If /net won't detect a dead server within a timeout, I think it can be
considered broken.

> Another example: I'm not sure if there are still /dev/tty devices which
> may block indefinately upon open() but:
> 
> -	I have yet to see a setuid program which always uses O_NONBLOCK
> 	when opening user supplied pathnames.
> -	one cannot stat() and then open() because that gives a race.

Is "being already broken" an excuse for preventing future breakage,
when these are fixed?

Miklos
