Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSGGVYZ>; Sun, 7 Jul 2002 17:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSGGVYY>; Sun, 7 Jul 2002 17:24:24 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:1762 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316585AbSGGVYW> convert rfc822-to-8bit; Sun, 7 Jul 2002 17:24:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: BKL removal
Date: Sun, 7 Jul 2002 23:28:34 +0200
User-Agent: KMail/1.4.1
Cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0207061306440.8346-100000@imladris.surriel.com> <3D27390E.5060208@us.ibm.com> <20020707205543.GA18298@kroah.com>
In-Reply-To: <20020707205543.GA18298@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207072328.34244.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[..]
> Excuse me, but please do NOT compare coding style with using the BKL!  I
> can use the BKL in my code just fine, and it does not impare your
> ability to use, modify, or understand my code.  As long as I comment why
> I am using the BKL.

That should be something the maintainers enforce.

[..]
> > I would mind the BKL a lot less if it was as well understood
> > everywhere as it is in VFS.  The funny part is that a lock like the
> > BKL would not last very long if it were well understood or documented
> > everywhere it was used.
>
> I would mind it a whole lot less if when you try to remove the BKL, you
> do it correctly.  So far it seems like you enjoy doing "hit and run"
> patches, without even fully understanding or testing your patches out
> (the driverfs and input layer patches are proof of that.)  This does
> nothing but aggravate the developers who have to go clean up after you.
>
> Also, stay away from instances of it's use WHERE IT DOES NOT MATTER for
> performance.  If I grab the BKL on insertion or removal of a USB device,
> who cares?  I know you are trying to remove it entirely out of the
> kernel, but please focus on places where it actually helps, and leave
> the other instances alone.

If you really want to make maximum impact, do tests. Very few people can measure
lock contention on a 4-CPU system. And please rest assured that nobody wants to
be maintainer of the subsystem that ruins scalability.

And if you see a use of the BKL you don't understand ask first, or send a patch
to the subsystem's mailing list, not lkml. People will look at BKL usage if you ask.
In fact such a look might even uncover bugs as in case of USB.

	Regards
		Oliver

