Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVATQ71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVATQ71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVATQzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:55:31 -0500
Received: from mail.tmr.com ([216.238.38.203]:64017 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262237AbVATQxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:53:16 -0500
Date: Thu, 20 Jan 2005 11:42:11 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Dan Hollis <goemon@anime.net>, Venkat Manakkal <venkat@rayservers.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       Paul Walker <paul@black-sun.demon.co.uk>, linux-kernel@vger.kernel.org,
       linux-crypto@nl.linux.org, James Morris <jmorris@redhat.com>
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
In-Reply-To: <1106157459.19164.8.camel@ghanima>
Message-ID: <Pine.LNX.3.96.1050120112048.15116C-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"; BOUNDARY="=-fjc1Kbnlm7nutSy6fUMk"
Content-ID: <Pine.LNX.3.96.1050120112048.15116D@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--=-fjc1Kbnlm7nutSy6fUMk
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.3.96.1050120112048.15116E@gatekeeper.tmr.com>

On Wed, 19 Jan 2005, Fruhwirth Clemens wrote:

> On Wed, 2005-01-19 at 12:03 -0500, Bill Davidsen wrote:
> > On Tue, 18 Jan 2005, Dan Hollis wrote:
> > 
> > > On Tue, 18 Jan 2005, Venkat Manakkal wrote:
> > > > As for cryptoloop, I'm sorry, I cannot say the same. The password hashing
> > > > system being changed in the past year, poor stability and machine lockups are
> > > > what I have noticed, besides there is nothing like the readme here:
> > > 
> > > cryptoloop is also unusably slow, even on my x86_64 machines...
> > 
> > I'm obviously doing something wrong, I just copied about 40MB of old
> > kernels (vmlinuz*) and some jpg files into a subdir on my cryptoloop
> > filesystem, and I measured 4252.2375kB/s realtime and 18819.7879 kB/s CPU
> > time. This doesn't seem unusably slow, even on my mighty P-II/350 and
> > eight year old 4GB drives. The hdb is so old it has to run in pio mode, to
> > give you an idea, and the original data was not in memory.
> 
> I've rewritten some CBC code to fit the facilities I introduce in my LRW
> patch[1]. Here are the results for my P4@1.8GHZ:
> 
> loop-aes, CBC: ~30.5mb/s
> dm-crypt, CBC prior to my rewrite: ~23mb/s
> dm-crypt, CBC with my LRW patch: ~27mb/s
> dm-crypt, LRW with my LRW patch: ~27mb/s (slightly faster than CBC)
> 
> As you can see my LRW patches (actually it's the generic scatterwalker
> which is part of the LRW patch set) halves the gap to loop-aes. 

Actually I was using the built-in cryptoloop, not aes, I was just noting
that on a really slow CPU it's still usefully fast in my estimation.

> 
> I'm sure dm-crypt is never going to achieve the speed of loop-aes.
> That's just the price you pay, when you have to do things right and
> clean, so they get merged into main. Kernel developers are choosey
> customers, you know.

Yes, I delighted that cryptoloop is in the kernel. The dm-crypt is an
interesting method suitable for technically adept users who do all their
own sysadmin and need better crypto to protect something very valuable or
illegal.

But for a company trying to protect information on laptops from casual
laptop theves, the existing cryptoloop is fine, and the greater complexity
of dm-crypt isn't cost effective. Speed isn't an issue, ease of use and
avoiding training costs is.

> 
> [1] http://clemens.endorphin.org/patches/lrw/
> 
> -- 
> Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--=-fjc1Kbnlm7nutSy6fUMk
Content-Type: APPLICATION/PGP-SIGNATURE; NAME="signature.asc"
Content-ID: <Pine.LNX.3.96.1050120112048.15116F@gatekeeper.tmr.com>
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB7p+SW7sr9DEJLk4RAlsfAJ9cl/8iN9Thx7qiGQSS2FvCV7bgzACeKDak
dQJ5rdIeMY313KhP1nEVSEA=
=MSb+
-----END PGP SIGNATURE-----

--=-fjc1Kbnlm7nutSy6fUMk--
