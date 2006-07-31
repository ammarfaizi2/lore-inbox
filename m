Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWGaBAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWGaBAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 21:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWGaBAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 21:00:11 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:46278
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932496AbWGaBAJ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 21:00:09 -0400
Message-Id: <200607310058.k6V0wYj2004593@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Shem Multinymous <multinymous@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
In-Reply-To: Your message of "Sun, 30 Jul 2006 14:48:07 +0300."
             <41840b750607300448u353a3276o8c30d7d880da6329@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz> <20060728134307.GD29217@suse.cz> <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com> <200607281557.k6SFvn09022794@turing-police.cc.vt.edu> <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com> <200607282314.k6SNESSg019274@turing-police.cc.vt.edu> <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com> <200607300835.k6U8ZvSB016669@turing-police.cc.vt.edu>
            <41840b750607300448u353a3276o8c30d7d880da6329@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154307514_2988P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Jul 2006 20:58:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154307514_2988P
Content-Type: text/plain; charset=us-ascii

On Sun, 30 Jul 2006 14:48:07 +0300, Shem Multinymous said:
> On 7/30/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> > If the program says '100ms' because it knows it will need to do a GUI update
> > then, and you block it for 5 seconds because that's when the next value
> > update happens, the user is stuck looking at their gkrellm or whatever not
> > doing anything at all for 4.9 seconds....

> Please read my detailed proposal, posted (and resivsed) later.

OK, if you meant this one (that hadn't shown up here before I hit 'send'):

On Sun, 30 Jul 2006 13:14:10 +0300, Shem Multinymous said:
> Actually my solution was "any update but no sooner than N msecs". So
> you might be getting a readout that's N-1 msecs old, which was
> meanwhile cached by the driver. If you care about that, you need to
> use interleave those polls with msleep()s; see my recent detailed
> post. You'll still doing at most one msleep() per fetched readout,
> regardless of how frequently the driver provides them.

That has slightly different semantics indeed, and avoids the issue I
was commenting about.  A gkrellm-ish program can query every 100ms and
get a cached value 49 times out of 50 for a value that's hardware-updated
every 5 seconds, and all will be well (of course, there's room for some
added optimization, but I suspect trying to add that will end up more
expensive than just re-reading the same cached value, unless the kernel has
a good way to pass back a good hint of when the next update will be...)

--==_Exmh_1154307514_2988P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEzVW6cC3lWbTT17ARAsCEAKClFzQFGLORbD/7Kf+zx65ekej/VACdFtst
UQgPDm8bdpHwYRiAxim+1sY=
=J8Ki
-----END PGP SIGNATURE-----

--==_Exmh_1154307514_2988P--
