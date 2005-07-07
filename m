Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVGGNma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVGGNma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVGGNkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:40:09 -0400
Received: from nysv.org ([213.157.66.145]:42625 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261523AbVGGNim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:38:42 -0400
Date: Thu, 7 Jul 2005 16:38:05 +0300
To: linux-kernel@vger.kernel.org, linux-usb-devel@vger.kernel.org
Cc: linux-poweredge@dell.com
Subject: Re: USB bugs in 2.6.11.8, 2.6.11.10 and 2.6.12.2
Message-ID: <20050707133805.GC11013@nysv.org>
References: <20050707092258.GA11013@nysv.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tEHm/81IqsjXUEYk"
Content-Disposition: inline
In-Reply-To: <20050707092258.GA11013@nysv.org>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tEHm/81IqsjXUEYk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Gotta love replying to oneself ;)

On Thu, Jul 07, 2005 at 12:22:58PM +0300, Markus   T=F6rnqvist wrote:
>Hi!
>
>I got some weird badness on two Dell PowerEdge 2850 (64-bit SMP Xeon)
>boxes. One of them is all identical with one that runs ok, so I
>attached that one's ksymoops information in this message.
>
>The one that works just fine was installed locally (iirc) so this
>may be an issue with Dell's Remote Administration Console's
>VGA console redirection and its emulation of USB for input, maybe?
>
>My first guess was just hardware failure, but it's a bit unlikely
>on two boxes, especially now that I installed the boxes with a 32-bit
>kernel and everything's fine.
>
>Needless to say both I and the customer would want the 64-bit
>one working :)
>
>The boxes are situated some 3000km from here so getting hard
>forensics is kind of hard, but the Dell system can do a bit,
>so please let me know ASAP if there's something more I can
>try out.
>
>Any ideas on why box number one works but these two don't?
>"Sunspots and lunar positions" is not a good theory ;)
>
>I put up everything I could easily dig out on
>http://mjt.nysv.org/kernelbugfest/
>
>It's just that the boxes don't boot far, as they get stuck in
>that suspend/wakeup loop, so there's only one really complete
>oops decode there from the identical working setup.

I reproduced this with vanilla 2.6.12.2 now, and I'm quoting
the entire message for the benefit of the guys over at
linux-poweredge@dell.com

To make it short, the suspend/wakeup loop didn't occur with 2.6.12.2
vanilla.

Still the bug happens, the box is apparently usable, but not
for the remote administration, so usability is quite shaky
a definition ;)

The relevant stuff is still at the url below, the two new interesting
files are:
http://mjt.nysv.org/kernelbugfest/usb_bug_2.6.12.2.ksymoops
http://mjt.nysv.org/kernelbugfest/netconsole_panic_2.6.12.2
(The netconsole issue is probably not related and I'll look into it
later, if ever, as we're not really using it...)

I also got a hint that disabling power management might help,
but that has to wait until tomorrow.. Anyone want to back
this theory? :)

Thanks!

--=20
mjt


--tEHm/81IqsjXUEYk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCzTA9IqNMpVm8OhwRAu7KAKC4bAv969mfXJdqlbDw3TjKFjAvDACfYKHo
yc+lOJp4QVgqwKgap+DwBEk=
=s0fF
-----END PGP SIGNATURE-----

--tEHm/81IqsjXUEYk--
