Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVLDR2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVLDR2F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 12:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVLDR2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 12:28:05 -0500
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:15503 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S1751223AbVLDR2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 12:28:04 -0500
Date: Sun, 4 Dec 2005 19:27:53 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Bharath Ramesh <krosswindz@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Only one processor detected in 8-Way opteron in 32-bit mode
Message-ID: <20051204172753.GB22829@mea-ext.zmailer.org>
References: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com> <a762e240512011527s69053b8eg13ec4674c3e36b07@mail.gmail.com> <c775eb9b0512011651kb0e1cb4xf79ca20372f6d76e@mail.gmail.com> <c775eb9b0512011712x2f4f2f44t4cd11d5d6f60a9d8@mail.gmail.com> <a762e240512011742p681df3bdic16598a85926dd67@mail.gmail.com> <c775eb9b0512020732v3f41f91fpb3b4b61b0b539d92@mail.gmail.com> <a762e240512021407p5a31c0daid902352625701ca2@mail.gmail.com> <p73psod4yat.fsf@verdi.suse.de> <c775eb9b0512040624ob4bcb3drfbdcdd427df2d2e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c775eb9b0512040624ob4bcb3drfbdcdd427df2d2e3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 09:24:08AM -0500, Bharath Ramesh wrote:
> 
> Can you point me to the thread in which you posted the patch so that I
> can try it out. I am limited to a 32-bit kernel as the library I want
> use requires a 32bit kernel. I need to try to get some performance
> results.

With "libary" I presume you to mean something used by an application
program ?

If so, a 64-bit kernel on x86_64 will work just fine for your 32 bit
code.  What you do need, however, are some compiler magic to construct
your binary -- in essence doing a cross-compilation on 64 bit platform
to 32 bit target.

The resulting application binary will run just fine.

You will need things like  glibc  installed both for 32 bit i386
and 64 bit x86_64, and possibly some others, but those should be
mostly coming in current distributions, anyway.

I use daily 32-bit Mozilla with several 3rd party plugins in my
64-bit machine.  My kernel is fully 64-bit.


> Thanks,
> Bharath

  /Matti Aarnio


> On 03 Dec 2005 15:21:14 -0700, Andi Kleen <ak@suse.de> wrote:
> > Keith Mannthey <kmannth@gmail.com> writes:
> >
> > > Welcome to hardware bring up.  Ok I looked a little closer at the
> > > story.  In x86_64 the only check for valid apic is apicid < MAX_APICS
> > > which make sense to me.
> >
> > It will still not work. He will need a variant of the physflat-i386
> > patch I posted some time ago. However it needs some cleanup
> > to be actually mergeable
> >
> > My recommendation is a 64bit kernel.
> >
> > -Andi
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
