Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVL3Aid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVL3Aid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 19:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVL3Aic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 19:38:32 -0500
Received: from mail.autoweb.net ([198.172.237.26]:59309 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751178AbVL3Aic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 19:38:32 -0500
Message-ID: <43B48176.3080509@michonline.com>
Date: Thu, 29 Dec 2005 19:38:14 -0500
From: Ryan Anderson <ryan@michonline.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com>
In-Reply-To: <20051229224103.GF12056@redhat.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig753F8EBF4A95E3D3CE6CF406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig753F8EBF4A95E3D3CE6CF406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dave Jones wrote:
> On Thu, Dec 29, 2005 at 12:49:16PM -0800, Linus Torvalds wrote:
>  
>  > Umm.. Complain more. I upgrade kernels a lot more often than I upgrade 
>  > distros, and things don't break. They're not allowed to break, because I 
>  > refuse to upgrade my user programs just because I do kernel development. 
>  > But I'd only notice a small part of user space, so if people don't 
>  > complain, they break not because we don't care, but because we didn't even 
>  > know.
>  > 
>  > So if you have a user program that breaks, _complain_. It's really not 
>  > supposed to happen outside of perhaps kernel module loaders etc things 
>  > that get really really chummy with kernel internals (and even that was 
>  > fixed: the modern way of loading modules isn't that chummy any more, so 
>  > hopefully we'll not need to break even module loaders again).
>  > 
>  > If we change some /proc file thing, breakage is often totally 
>  > unintentional, and complaining is the right thing - people might not even 
>  > have realized it broke.
>  > 
>  > At least _I_ take breakage reports seriously. If there are maintainers 
>  > that don't, complain to them. I'll back you up. Breaking user space simply 
>  > isn't acceptable without years of preparation and warning.
> 
> The udev situation I mentioned has been known about for at least a month,
> probably longer. With old udev, we don't get /dev/input/event* created
> with 2.6.15rc.
> 
> At some point in time it became defacto that certain things like udev, hotplug,
> alsa-lib, wireless-tools and a bunch of others have to have kept in lockstep
> with the kernel, and if it breaks, it's your fault for not upgrading
> your userspace.

The biggest complaint I've seen about udev isn't the fact that you
sometimes need to upgrade to use a new kernel, that's something that
people like Dave can handle via package dependencies.

The part of the udev situation that I've heard as a complaint (though I
haven't experienced myself) is that the new udev wasn't backwards
compatible with certain older kernels.  I think the description I've
heard is that you need one udev for < 2.6.12, one for 2.6.12 - 2.6.14,
and now a new one for 2.6.15, and at least, jumping from < 2.6.12 to
2.6.15 is pretty much guaranteed to be difficult to get right.  (If the
kernel fails, you have a udev installed that won't work on the older
kernel correctly, apparently.)

This, for what it's worth, is the same breakage that Dave seemed to be
most frustrated with during his OLS keynote, regarding ALSA versions,
and a few other things that caused breakage and the user space failed to
work correctly when the kernel was reverted.  (I hope I'm not putting
words in your mouth, Dave).

That's my perspective from someone who has only dealt with the issue
from the point of view of a user, and only in the case of the Debian
udev packages flat out refusing to install while running a "too old"
kernel, which was rather, umm, annoying.

-- 

Ryan Anderson
  sometimes Pug Majere

--------------enig753F8EBF4A95E3D3CE6CF406
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDtIF5fhVDhkBuUKURAlPVAJ9+fxWRMM7YrqKA7ioIafXi5yFygwCfeUfb
xvD60Ike6ci/8q/JznS3Qxc=
=5v6M
-----END PGP SIGNATURE-----

--------------enig753F8EBF4A95E3D3CE6CF406--
