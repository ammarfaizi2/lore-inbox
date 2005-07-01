Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263294AbVGAJio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbVGAJio (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 05:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbVGAJio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 05:38:44 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:49078 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263294AbVGAJg2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 05:36:28 -0400
Date: Fri, 1 Jul 2005 11:36:27 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
Subject: Re: FUSE merging?
Message-ID: <20050701093627.GB4317@janus>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 08:36:02AM +0200, Miklos Szeredi wrote:
> 
> Here's a description of a theoretical DoS scenario:
> 
>   http://marc.theaimsgroup.com/?l=linux-fsdevel&m=111522019516694&w=2

So the open() hangs indefinately. but what if blackhat tries to install
a package from a no longer existing server on /net or via NFS?

A user supplied pathname is not to be trusted by any setuid (or full
root) program.

Another example: I'm not sure if there are still /dev/tty devices which
may block indefinately upon open() but:

-	I have yet to see a setuid program which always uses O_NONBLOCK
	when opening user supplied pathnames.
-	one cannot stat() and then open() because that gives a race.

-- 
Frank
