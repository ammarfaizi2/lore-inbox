Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVAMUXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVAMUXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVAMTh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:37:59 -0500
Received: from grendel.firewall.com ([66.28.58.176]:34977 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261365AbVAMTgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:36:37 -0500
Date: Thu, 13 Jan 2005 20:36:37 +0100
From: Marek Habersack <grendel@caudium.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113193637.GB24970@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050113032506.GB1212@redhat.com> <20050113035331.GC9176@beowulf.thanes.org> <1105627951.4664.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <1105627951.4664.32.camel@localhost.localdomain>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2005 at 03:36:33PM +0000, Alan Cox scribbled:
> On Iau, 2005-01-13 at 03:53, Marek Habersack wrote:
> > That might be, but note one thing: not everybody runs vendor kernels (f=
or various
> > reasons). Now see what happens when the super-secret vulnerability (with
> > vendor fixes) is described in an advisory. A person managing a park of =
machines=20
> > (let's say 100) with custom, non-vendor, kernels suddenly finds out tha=
t they=20
> > have a buggy kernel and 100 machines to upgrade while the exploit and t=
he
>=20
> Those running 2.4 non-vendor kernels are just fine because Marcelo
> chooses to work with vendor-sec while Linus chooses not to. I choose to
> work with vendor-sec so generally the -ac tree is also fairly prompt on
> fixing things.=20
That's fine, but if one isn't on vendor-sec, they are still out in the cold
until the vulnerability with an embargo is announced - at which point all
the vendors are ready, but those with non-vendor kernels are in for an
unpleasant surprise. And as for 2.4, yes, Marcelo does a good job applying
the fixes asap, but that's not helping. If one runs (as I wrote) a kernel
with custom code inside, tux and, say, grsecurity - and it's not the latest
2.4 kernel - he still needs to backport the fixes and make sure they work
fine with is custom code, all that in a great hurry.  Somebody suggested
here that perhaps there could be a version of a security fix released for
X past kernel versions (2? 3?) if it doesn't apply cleanly to them. That
would be a great help along with earlier notification of a problem - not in
the way it is done with vendor-sec where you have to wear a pointy hat and
a beard to be accepted as a member. It's not that I'm whining or bitching,
hell no, I just think it would be more fair if everybody was treated the
same - vendors, non-vendors, bad guys, all alike.

> Given that base 2.6 kernels are shipped by Linus with known unfixed
> security holes anyone trying to use them really should be doing some
> careful thinking. In truth no 2.6 released kernel is suitable for
> anything but beta testing until you add a few patches anyway.=20
>=20
> 2.6.9 for example went out with known holes and broken AX.25 (known)=20
> 2.6.10 went out with the known holes mostly fixed but memory corrupting
> bugs, AX.25 still broken and the wrong fix applied for the smb holes so
> SMB doesn't work on it
>=20
> I still think the 2.6 model works well because its making very good
> progress and then others are doing testing and quality management on it.
> Linus is doing the stuff he is good at and other people are doing the
> stuff he doesn't.
>=20
> That change of model changes the security model too however.
yes, definitely. IMHO, it enforces prompt and open security advisory/patch
releases, just as Linus proposed (with the limited embargo). Of course, one
can just take a released vendor kernel, patch it with their custom code and
compile the way they see it fit, but it's not in any way faster or better
than backporting the fixes to your own kernel.

regards,

marek

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5s3Fq3909GIf5uoRAljNAJ45FCDjEcncSDgoFVtmuN11DnKBMACfSYK1
DT9TFxQMbZG6xRxLrXKLMvM=
=ppCr
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
