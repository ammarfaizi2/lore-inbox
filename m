Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbRLGQAn>; Fri, 7 Dec 2001 11:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282850AbRLGQA1>; Fri, 7 Dec 2001 11:00:27 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:28299 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282843AbRLGQAI>; Fri, 7 Dec 2001 11:00:08 -0500
Date: Fri, 7 Dec 2001 08:59:58 -0700
Message-Id: <200112071559.fB7FxwR14021@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rene Rebe <rene.rebe@gmx.net>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@lists.sourceforge.net>
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] /
 ALSA-0.9.0beta[9,10]
In-Reply-To: <Pine.LNX.4.33.0112071617440.2935-100000@serv>
In-Reply-To: <200112070609.fB769Eo08508@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0112071617440.2935-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> Hi,
> 
> On Thu, 6 Dec 2001, Richard Gooch wrote:
> 
> > Two possibilities:
> >
> > - the module is trying to register "unknown" twice. The old devfs core
> >   was forgiving about this (although it was always a driver bug to
> >   attempt to create a duplicate). The new core won't let you do that.
> >   Error 17 is EEXIST. Please fix the driver
> >
> > - something in user-space created the "unknown" inode before the
> >   driver could create it. This is a configuration bug.
> 
> Option 3:
> Turn a user generated entry into a kernel generated one and return
> 0.  Prepopulating devfs was a valid option so far, you cannot simply
> change this during a stable kernel release.

Well, no, it was never a valid option. It was always a bug. In any
case, the stricter behaviour isn't preventing people from using their
drivers, it's just issuing a warning. The user-space created device
node still works.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
