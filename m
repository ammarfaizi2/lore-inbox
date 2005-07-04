Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVGDPUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVGDPUp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 11:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVGDPUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 11:20:45 -0400
Received: from [217.149.127.10] ([217.149.127.10]:9961 "EHLO stine.vestdata.no")
	by vger.kernel.org with ESMTP id S261224AbVGDPUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 11:20:37 -0400
Date: Mon, 4 Jul 2005 17:19:42 +0200
From: Ragnar =?iso-8859-15?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: 7eggert@gmx.de, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging? (2)
Message-ID: <20050704151942.GB32763@vestdata.no>
References: <4maPM-5XJ-5@gated-at.bofh.it> <4mcHV-7no-21@gated-at.bofh.it> <4mduc-7Zg-1@gated-at.bofh.it> <4mfcJ-UT-17@gated-at.bofh.it> <4mitV-3mL-3@gated-at.bofh.it> <4mv7Q-2Ki-19@gated-at.bofh.it> <4mwdG-3AP-15@gated-at.bofh.it> <4mwwX-3N9-9@gated-at.bofh.it> <E1DpQhW-0004Sv-Iw@be1.7eggert.dyndns.org> <E1DpQpL-0006aM-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1DpQpL-0006aM-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Zet.no-MailScanner-Information: Please contact the ISP for more information
X-Zet.no-MailScanner: Found to be clean
X-MailScanner-From: ragnark@stine.vestdata.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 03:17:35PM +0200, Miklos Szeredi wrote:
> > > I see your point.  But then this is really not a security issue, but
> > > an "are you sure you want to format C:" style protection for the
> > > user's own sake.  Adding a mount option (checked by the library) for
> > > this would be fine.  E.g. with "mount_nonempty" it would not refuse to
> > > mount on a non-leaf dir, and README would document, that using this
> > > option might cause trouble.  Otherwise the mount would be refused with
> > > a reference to the above option.
> > 
> > IMO that should be a generic mount option, not FUSE specific.
> > Maybe the default could vary for each fs, but I'd vote against that.

Why a mount option at all?
Why not just a switch for the mount utility?

> The option only makes sense with the default being restrictive.  But
> making that default for all filesystems can't be done, because that
> would immediately break thousands of existing installations.

I think it is acceptable to change this behaviour in a new version of
the mount utility. One could considder ignoring the restriction when
running with "-a" or when running as root - that would reduce or
eliminate the problems with the transition.

However, if this is implemented in mount itself, it is totally
orthogonal to the FUSE merge discussion.


-- 
Ragnar Kjørstad
Software Engineer
Scali - http://www.scali.com
Scaling the Linux Datacenter
