Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRKXP4t>; Sat, 24 Nov 2001 10:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278714AbRKXP4j>; Sat, 24 Nov 2001 10:56:39 -0500
Received: from mail301.mail.bellsouth.net ([205.152.58.161]:51945 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278701AbRKXP40>; Sat, 24 Nov 2001 10:56:26 -0500
Message-ID: <3BFFC324.130A532C@mandrakesoft.com>
Date: Sat, 24 Nov 2001 10:56:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: admin@nextframe.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove last references to linux/malloc.h
In-Reply-To: <20011122145527.A117@sexything> <27400.1006437269@redhat.com> <20011122150738.D117@sexything> <3BFF1AAB.273A2BB@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> Morten Helgesen wrote:
> >
> > Hey David.
> >
> > I see your point - but someone has obiously decided to switch from malloc.h to slab.h, and I do not
> > see the point in having three references to malloc.h when malloc.h only prints a warning and then includes
> > slab.h
> >
> > == Morten
> >
> > On Thu, Nov 22, 2001 at 01:54:29PM +0000, David Woodhouse wrote:
> > >
> > >
> > > admin@nextframe.net said:
> > > >  Ok people - stop submitting patches which include malloc.h. Include
> > > > slab.h instead. :)
> > >
> > > Bah. I was sort of hoping we'd come to our collective senses and switch
> > > them all back.
> > >
> > > What does malloc.h do? Stuff to do with memory allocation, one presumes.
> > > What does slab.h do? Some random implementation detail that people have no
> > > business knowing about.
> 
> Too bad someone decided to change.  I agree with David.
> 
> malloc.h is just too plain obvious, I suppose.
> slab.h is only an implementation detail.

Water under the bridge...  someone should have spoken up long ago :) 
malloc.h has been an empty shell for years and years, and I do not see
how the API benefits from this.  Does "malloc" exist in kernel code? 
No.  kmalloc does...  so it's arguably already misnamed as well as
superfluous.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

