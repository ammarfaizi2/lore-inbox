Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289340AbSBEHfA>; Tue, 5 Feb 2002 02:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289341AbSBEHet>; Tue, 5 Feb 2002 02:34:49 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:47239 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289340AbSBEHel>; Tue, 5 Feb 2002 02:34:41 -0500
Message-Id: <200202041324.g14DOcv7001338@tigger.cs.uni-dortmund.de>
To: Jeff Garzik <garzik@havoc.gtf.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Message from Jeff Garzik <garzik@havoc.gtf.org> 
   of "Fri, 01 Feb 2002 09:55:10 EST." <20020201095510.D17412@havoc.gtf.org> 
Date: Mon, 04 Feb 2002 14:24:38 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <garzik@havoc.gtf.org> said:
> On Fri, Feb 01, 2002 at 03:03:13PM +0000, Alan Cox wrote:
> > > If you have a dependency concern, you put yourself in the
> > > right initcall group.  You don't depend ever on the order within the
> > > group, thats the whole idea.  You can't depend on that, so you must
> > > group things correctly.

> > This was proposed right back at the start. Linus point blank vetoed it.

> My ideal would be to express dependencies in driver.conf (when that is
> implemented), and that will in turn affect the link order by
> autogenerating part of vmlinux.lds.  Until then, initcall groups are
> fine with me...

Not _one_ central file telling everything, please! Let each driver declare
what it needs and provides, and sort it out from there. Even better would
be something like "depmod -a" that doesn't need explicit dependencies
declared, but that looks like too much hair IMVHO.

Why do I have this uneasy feeling it would somehow overlap with CML2's job?
-- 
Horst von Brand			     http://counter.li.org # 22616
