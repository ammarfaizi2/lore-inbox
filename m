Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbTA2INP>; Wed, 29 Jan 2003 03:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTA2INP>; Wed, 29 Jan 2003 03:13:15 -0500
Received: from postoffice.virtusa.com ([12.40.51.200]:62735 "EHLO
	mailserver.virtusa.com") by vger.kernel.org with ESMTP
	id <S265139AbTA2INO>; Wed, 29 Jan 2003 03:13:14 -0500
Date: Wed, 29 Jan 2003 14:22:26 +0600
From: Anuradha Ratnaweera <ARatnaweera@virtusa.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where are the matroxfb updates?
Message-ID: <20030129082226.GA668@aratnaweera.virtusa.com>
References: <20030129020639.GA10213@aratnaweera.virtusa.com> <20030129053159.GA5999@platan.vc.cvut.cz> <20030129073629.GA26091@aratnaweera.virtusa.com> <20030129080420.GB4950@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129080420.GB4950@vana.vc.cvut.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 12:04:20AM -0800, Petr Vandrovec wrote:
>
> On Wed, Jan 29, 2003 at 01:36:29PM +0600, Anuradha Ratnaweera wrote:
> > 
> > -pre3 and -pre4 don't build matroxfb_g450 and matroxfb_crtc2 as
> > modules.  I have FB_MATROX_G450 set to "m", so these modules don't
> > get added to obj-m.  The "ifeq"s in the Makefile now check only for
> > the value "y" of this symbol, not for "m".
> 
> You did not run 'make oldconfig', did you?

I did.  (I use make-kpkg on Debian, so it does another superfluous make
oldconfig, too).  But I tried many other variations before looking at
the Makefile and Config.in itself.

> By default people use secondary output on g550 and they were
> complaining that they see nothing.

Then isn't it then sane to make FB_MATROX_G450 to "bool" and not
"tristate", because selecting "m" does _nothing_ !

> So you do not have choice to screw up things now.

Only for 550 owners, though :-(

BTW, now I _have_ g450 built into the kernel (see signature below) and
both monitors display the same screen.  /dev/fb1 gets registered, and
ttys get moved to it with con2fb, but not to any of the monitors.  Both
monitors still seem to act as /dev/fb0.  The moved tty no longer exist.

Didn't have time to do more research on this.

Thanks.

	Anuradha

-- 

Debian GNU/Linux (kernel 2.4.21-pre4)

It is amazing how complete is the delusion that beauty is goodness.

