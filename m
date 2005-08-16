Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVHPQpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVHPQpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbVHPQpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:45:04 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:28862 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030233AbVHPQpD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:45:03 -0400
Date: Tue, 16 Aug 2005 18:52:42 +0200
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays
Message-ID: <20050816165242.GA10024@aitel.hist.no>
References: <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com> <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no> <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org> <43008C9C.60806@aitel.hist.no> <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org> <20050815221109.GA21279@aitel.hist.no> <21d7e99705081516182e97b8a1@mail.gmail.com> <21d7e99705081516241197164a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e99705081516241197164a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 09:24:25AM +1000, Dave Airlie wrote:
> > > I'm a little surprised, as a ppc64 fix theoretically shouldn't matter for
> > > x86_64? But perhaps they share something?
> > 
> > My guess is that it is maybe the DRM changes that have done it... the
> > 32/64-bit code in 2.6.13-rc6 may have issues, but they've been tested
> > on a number of configurations (none of them by me... I can't test what
> > I don't have...)
> >
> 
> Actually after looking back 2.6.13-rc4-mm1 which you say works doesn't
> contain any of the later 32/64-bit changes.. so maybe you can try just
> applying the git-drm.patch from that tree to see if it makes a
> difference...
> 
> I'm getting less and less sure this is caused by the drm, (have you
> built with DRM disabled completely??)
> 
I tried rc6 with DRM turned off.  That kernel consistently _died_ when 
trying to start xdm. Xorg logs for both cards ended like this:

(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a

Of course the last block of the log may be lost, as this crash
blocked even sysrq so it is reasonable to assume that the disk drivers
and filesystems froze up too.

I can retry this with a syncronously mounted /var, if the last lines
of the Xorg logs might be interesting.


Helge Hafting
