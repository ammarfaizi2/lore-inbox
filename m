Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268792AbRHFP1E>; Mon, 6 Aug 2001 11:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268794AbRHFP0y>; Mon, 6 Aug 2001 11:26:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41819 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S268792AbRHFP0n>; Mon, 6 Aug 2001 11:26:43 -0400
To: Abraham vd Merwe <abraham@2d3d.co.za>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Felix von Leitner <leitner@fefe.de>
Subject: Re: kernel headers & userland
In-Reply-To: <20010806095638.A5638@crystal.2d3d.co.za>
	<m166c1wj66.fsf@frodo.biederman.org>
	<20010806130924.A14167@crystal.2d3d.co.za>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Aug 2001 09:20:16 -0600
In-Reply-To: <20010806130924.A14167@crystal.2d3d.co.za>
Message-ID: <m1wv4husen.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abraham vd Merwe <abraham@2d3d.co.za> writes:

> Hi Eric!
> 
> > > Apparently Linus told Felix von Leitner (the author of dietlibc - a small,
> > > no nonsense glibc replacement C library) a while ago _not_ to include any
> > > linux kernel headers in userland (i.e. the C library headers in this case).
> > > 
> > > This imho is obviously wrong since there are definitely a need for including
> 
> > > kernel headers on a linux platform.
> > 
> > ???  Necessity no.  Are there practical benefits yes.
> > 
> > The policy of the kernel developers in general is that if your apps
> > includes kernel headers and it breaks, it is a kernel problem.
> > 
> > As for ioctl it is a giant mess that needs to be taken out and shot.
> > 
> > And yes there are places where even the mighty glibc is in the wrong.
> 
> Just acknowledging that it is a problem doesn't solve the problem though.
> The question remains how you approach the kernel headers issue at the moment?
> 
> My guess is the only way is by including the kernel headers for now and
> change it one day when someone decides to clean up the mess.

Well. I'm not certain which mess you are refering too.  A normal
user space program should never include kernel headers period.  If it
does it should get fixed.   At minimum ``cp include/linux/xx.h . ''

And probably something similiar for libc.

The problem is not that it is evil to include kernel headers but
instead that it is a maintenance nightmare from both the glibc and
the kernel to have one set of headers that satisfy both their.  
purposes.  Perhaps if someone built a set of headers with that in mind
it could work.

Eric

