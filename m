Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313634AbSDURc3>; Sun, 21 Apr 2002 13:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSDURc2>; Sun, 21 Apr 2002 13:32:28 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:13731 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313634AbSDURc0>;
	Sun, 21 Apr 2002 13:32:26 -0400
Date: Sun, 21 Apr 2002 13:32:25 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Larry McVoy <lm@work.bitmover.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
        Wayne Scott <wscott@work.bitmover.com>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421133225.F4479@havoc.gtf.org>
In-Reply-To: <20020421044616.5beae559.spyro@armlinux.org> <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu> <20020421131354.C4479@havoc.gtf.org> <20020421102339.E10525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 10:23:39AM -0700, Larry McVoy wrote:
> > IOW, I propose to create a "linuspush" script that replaces his current
> > "bk push" command.  Linus pushes batches of csets out at a time,
> > make these cset batches the pre-patches...
> 
> This is easily doable as a trigger.  I'm pretty sure that all you want
> is

Not quite -- pre-patches are a one-big-patch, diffed against the most
recently released kernel.  Perl could easily parse the linux/Makefile
kernel version and deduce the BK tag (used for diffing) from that.
Finally, I'm not sure that BK can generate these kind of diffs, can it?
One quality of all traditional Linus pre-patches and patches is that
if you have N csets modifying a single file, you see N gnu-style diff
modifications, instead of the single one you would get when generating
the patch via GNU diff.

Also, (assuming Linus wants this, of course) I would want the
'linuspush' script to increment the pre-patch and check in that change,
before pushing.

	Jeff




