Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268970AbRIDUf3>; Tue, 4 Sep 2001 16:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268996AbRIDUfU>; Tue, 4 Sep 2001 16:35:20 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:35260 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S268970AbRIDUfO>; Tue, 4 Sep 2001 16:35:14 -0400
Date: Tue, 4 Sep 2001 14:35:25 -0600
Message-Id: <200109042035.f84KZPc08540@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Taral <taral@taral.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DEVFS_FL_AUTO_DEVNUM on block devices
In-Reply-To: <20010904152406.A5735@taral.net>
In-Reply-To: <20010904144605.A5496@taral.net>
	<200109042013.f84KDYD08203@vindaloo.ras.ucalgary.ca>
	<20010904152406.A5735@taral.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

taral@taral.net writes:
> On Tue, Sep 04, 2001 at 02:13:34PM -0600, Richard Gooch wrote:
> > taral@taral.net writes:
> > > 
> > > --HlL+5n6rz5pIUxbD
> > > Content-Type: text/plain; charset=us-ascii
> > > Content-Disposition: inline
> > > Content-Transfer-Encoding: quoted-printable
> > 
> > Please fix your mailer to not send this junk.
> 
> It's not junk, it's PGP/MIME.

"One man's junk is another man's treasure" :-)

> But I disabled it for you.

Thanks. It just gets in the way. And I'm tired of what I consider
pollution on the 'net. With horror I consider MIME+HTML+vcard. Next I
suppose we'll have M$ "active email" which requires a full virtual
machine in which to execute. <shudder>

> > You can use the devfs_alloc_major() function to grab a major number
> > that won't conflict with another driver. Then use that major when
> > calling devfs_register().
> 
> Sounds good to me. It might be wise, however, to disable use of
> DEVFS_FL_AUTO_DEVNUM in devfs_register with block devices, since
> it's not incredibly useful to have two different drivers sharing a
> major number.

That's a policy decision, and I don't want to make that. Also
consider that with the block I/O rewrite planned for 2.5, we'll do
away with these abominable arrays, and thus DEVFS_FL_AUTO_DEVNUM makes
plenty of sense even for block devices. It will in fact be the
preferred way of doing things (at least for devfs).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
