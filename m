Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUDBQn5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbUDBQn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:43:56 -0500
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:50952 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S264103AbUDBQnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:43:50 -0500
Subject: Re: 2.6.5-rc3-as1 patchset, cks5.2, cfq, aa1, and some wli
From: Antony Suter <suterant@users.sourceforge.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040402101407.GR791@holomorphy.com>
References: <1080894085.22675.0.camel@hikaru.lan>
	 <20040402101407.GR791@holomorphy.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PsagN0Xy4xl5tGdcGU+7"
Message-Id: <1080924208.9281.55.camel@hikaru.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 03 Apr 2004 02:43:28 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PsagN0Xy4xl5tGdcGU+7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-04-02 at 20:14, William Lee Irwin III wrote:
> On Fri, Apr 02, 2004 at 06:21:25PM +1000, Antony Suter wrote:
> > Some of those patches are now in the kernel proper. Some others have
> > been updated and are found elsewhere, like the objrmap series can be
> > found in Andrea Archangeli's -aa series. I'm starting to add some of th=
e
> > other patches from WLI's last release, depending on my ability to
> > resolve rejections. The numbers relate directly to those from
> > linux-2.6.0-test11-wli-1.tar.bz2
>=20
> Ouch! Please, use either Hugh's or Andrea's up-to-date patches.
> anobjrmap (and actually the vast majority of this material) was not
> original. You're also unlikely to find highpmd and a number of others
> useful without highmem and/or ia32 NUMA.

I certainly want to use the most up to date versions if others have
continued that work. Pointers appreciated.

> On Fri, Apr 02, 2004 at 06:21:25PM +1000, Antony Suter wrote:
> > < from linux-2.6.0-test11-wli-1 >
> > - #17 convert copy_strings() to use kmap_atomic() instead of kmap()
> > - #19 node-local i386 per_cpu areas
>=20
> These two are completely useless unless you're running on bigfathighmem.
>=20
> On Fri, Apr 02, 2004 at 06:21:25PM +1000, Antony Suter wrote:
> > - #22 increase static vfs hashtable and VM array sizes
> > - #24 /proc/ BKL gunk plus page wait hashtable sizing adjustment
> > - #25 invalidate_inodes() speedup
>=20
> #25 is in -mm and may have bugfixes/updates relative to whatever I had.
> #22 and #24 don't have very definite impacts; I only saw any difference
> with truly massive amounts of IO in-flight (e.g. 25GB/48GB), and while
> it wasn't a clear win, it moved around the blocking points surrounding
> IO submission to places where I'd rather it go. This is a rather foggy
> issue you probably shouldn't be concerned with. If you do see it make a
> difference, I'll be surprised, but happy to see the benchmark numbers
> demonstrating it.

Could you add some outlines of your patches #02, #03, #18 and #28
please?

> [...]
> altered so the parts stressing /proc/ are removed. I also had in the
> back of my mind the notion that /proc/ performance improvements would
> be appreciated by end users with limited cpu power to devote to the
> monitoring of their workloads and machines' performance, which is part
> of what motivated me to do it "the hard way" instead of modifying the
> benchmark or replacing the userspace procps utilities with /dev/kmem
> -diving utilities.

How important would improvements to /proc be now we have /sys ?

> The general points this is all meant to illustrate are that some of the
> cherrypicking going on doesn't really make sense, and to give the
> background on where all this stuff came from so you can understand
> which parts are going to be useful to you if you do choose to cherrypick
> them.

I certainly want to grok the purpose of each and every patch. This
release might would have been larger and out sooner if not for a reverse
patch cascade meltdown.

>  I very much regret not arranging relative benchmark results to
> post, as they are very impressive for not having exploited the extreme
> NUMA characteristics of the test machines. In the very strict sense of
> the slope of the curve as the number of processors increases, the
> original patch set was measured to literally double the kernel's
> scalability in this benchmark, which is something I'm rather proud of.
> There were other approaches which exploited the NUMA hardware aspects
> to achieve more drastic results with less code, but had more limited
> applicability as non-NUMA machines didn't benefit from them at all.

For as long as this series continues, I would want to include patches
that improve performance in any area, so long as the overall effect is
positive. And no improvement too great or small. I must have more power.

> Also, there will be new -wli's. They will be vastly different in nature
> from the prior -wli's. I don't like repeating myself. I already

I look forward to it ;)

> And finally, even with all this longwinded harangue, congratulations on
> your tree. There are very definite feelings of importance and
> satisfaction of having done service from producing releases others rely
> upon. And these are real, as real users do benefit from what you've
> assembled. I'm more than happy to help if you have bugreports in any
> code I maintained or other need to call on me. And whatever precedent I
> may have provided, you do own this, and this is your own original work.

Thanks for your kind words, and detailed notes! Again, any pointers to
similar sorts of work would be greatly appreciated. Can you recommend
any good tools for patch set management?

Cheers.

--=20
- Antony Suter  (suterant users sourceforge net)  "Bonta"
- "...through shadows falling, out of memory and time..."

--=-PsagN0Xy4xl5tGdcGU+7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAbZgwZu6XKGV+xxoRAoXOAKCB59L5BBijhkacWQ2c7CeOHRybtACcDU+H
uhRpuesLV3ODP6Bt7FuYS1E=
=7zUt
-----END PGP SIGNATURE-----

--=-PsagN0Xy4xl5tGdcGU+7--

