Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945973AbWGOC5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945973AbWGOC5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 22:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945979AbWGOC5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 22:57:22 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:23749
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1945973AbWGOC5V (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 22:57:21 -0400
Message-Id: <200607150255.k6F2tS2R008742@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: andrea@cpushare.com
Cc: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
In-Reply-To: Your message of "Fri, 14 Jul 2006 01:11:18 +0200."
             <20060713231118.GA1913@opteron.random>
From: Valdis.Kletnieks@vt.edu
References: <20060629192121.GC19712@stusta.de> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060712210545.GB24367@opteron.random> <1152741776.22943.103.camel@localhost.localdomain> <20060712234441.GA9102@opteron.random> <20060713212940.GB4101@ucw.cz>
            <20060713231118.GA1913@opteron.random>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152932128_4275P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Jul 2006 22:55:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152932128_4275P
Content-Type: text/plain; charset=us-ascii

On Fri, 14 Jul 2006 01:11:18 +0200, andrea@cpushare.com said:
> On Thu, Jul 13, 2006 at 09:29:41PM +0000, Pavel Machek wrote:
> > Actually random delays are unlike to help (much). You have just added
> > noise, but you can still decode original signal...
> 
> You're wrong, the random delays added to every packet will definitely
> wipe out any signal.

I call shenanigans on that.

Take a look at the NTP userspace code, which has some very nice code to
filter network jitter. 

In fact, the best you can do here is to reduce the effective bandwidth
the signal can have, as Shannon showed quite clearly.

And even 20 years ago, the guys who did the original DoD Orange Book
requirements understood this - they didn't make a requirement that covert
channels (both timing and other) be totally closed down, they only made
a requirement that for higher security configurations the bandwidth of
the channel be reduced below a specified level...

--==_Exmh_1152932128_4275P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEuFkgcC3lWbTT17ARAmYWAKDt0neuNKr0dHAnF0ZrH3d8+PrXUgCgnofO
9giIAEMI/kiBelybXwOh3I0=
=DRX1
-----END PGP SIGNATURE-----

--==_Exmh_1152932128_4275P--
