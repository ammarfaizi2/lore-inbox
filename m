Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWBGDHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWBGDHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWBGDHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:07:18 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:11681 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964920AbWBGDHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:07:15 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Jim Crilly <jim@why.dont.jablowme.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 7 Feb 2006 13:03:51 +1000
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, Pavel Machek <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1139275143.2041.24.camel@mindpipe> <20060207030129.GA23860@mail>
In-Reply-To: <20060207030129.GA23860@mail>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2018854.oY09Ma9ZBk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602071303.55753.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2018854.oY09Ma9ZBk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jim.

On Tuesday 07 February 2006 13:01, Jim Crilly wrote:
> On 02/06/06 08:19:02PM -0500, Lee Revell wrote:
> > On Mon, 2006-02-06 at 19:59 -0500, Jim Crilly wrote:
> > > I guess reasonable is a subjective term. For instance, I've seen
> > > quite a few people vehemently against adding new ioctls to the
> > > kernel and yet you'll be adding quite a few for /dev/snapshot. I'm
> > > just of the same mind as Nigel in that it makes the most sense to me
> > > that the majority of the suspend/hibernation process to be in the
> > > kernel.
> >
> > No one is saying that ANY new ioctls are bad, just that the KISS
> > principle of engineering dictates that it's bad design to use ioctls
> > where a simple read/write to a sysfs file will do.
>
> I understand that, but shouldn't the KISS principle also be applied to
> the user interface of a feature? As it stands it looks like Suspend2
> is going to be a lot simpler for users to configure and get right than
> uswsusp. As long as you have Suspend2 enabled in the kernel it 'just
> works', even if you don't have the userland UI it'll still suspend and
> resume just without the progress bars. There is still some room for
> error with things like forgetting to enable the swap writer and then
> attempting to suspend to a swap device or making lzf a module and
> forgetting to load it before resuming from a compressed image, but those
> are no worse than any other kernel option.
>
> With uswsusp it'll be more flexible in that you'll be able to use any
> userland process or library to transform the image before storing it,
> but the suspend and resume processes are going to be a lot more
> complicated. For instance, how are you going to tell the kernel that you
> need the uswsusp UI binary, /bin/gzip and /usr/bin/gpg to run after the
> rest of userland has been frozen?

As I understand it, with uswsusp, all the functionality will be compiled=20
into one monolithic binary, which you'll also need to put in your initrd=20
or initramfs.

Hope that helps.

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2018854.oY09Ma9ZBk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6A4bN0y+n1M3mo0RAhQfAKCMGjqF/dTR5cOcRyhd6Ad1pQJWzwCfW2LS
oGA4eSwrwlKk9Qa7SI1JxOs=
=z7ft
-----END PGP SIGNATURE-----

--nextPart2018854.oY09Ma9ZBk--
