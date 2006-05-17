Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWEQSph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWEQSph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWEQSph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:45:37 -0400
Received: from pool-71-254-71-216.ronkva.east.verizon.net ([71.254.71.216]:31942
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750909AbWEQSph (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:45:37 -0400
Message-Id: <200605171844.k4HIiPd1028516@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Martin Peschke <mp3@de.ibm.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       arjan@infradead.org, James.Smart@emulex.com,
       James.Bottomley@steeleye.com, ltt-dev@shafik.org
Subject: Re: [RFC] [Patch 0/8] statistics infrastructure
In-Reply-To: Your message of "Wed, 17 May 2006 14:28:08 EDT."
             <20060517182808.GL17707@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <446A0F77.70202@de.ibm.com> <y0msln8wooo.fsf@ton.toronto.redhat.com> <200605172005.44588.ak@suse.de>
            <20060517182808.GL17707@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147891464_4166P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 14:44:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147891464_4166P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 May 2006 14:28:08 EDT, "Frank Ch. Eigler" said:
> I am not suggesting a single solution for all needs.  I wanted to
> focus only one aspect: the marking of those points in the kernel where
> something probeworthy occurs with hooks.  The different tools would
> still gather and disseminate their data in their own favorite.  The
> main difference from the status quo is agreeing on and reusing a
> common pool of hooks.

The problem is that the "common pool" ends up being a very wide swamp
very fast.  The last few times I've needed any instrumentation in the
kernel, I was chasing slab leaks, and didn't need precise timing or
latency measurements.  On the other hand, the RT guys probably don't
care all that much about slab events, but need timing and latency.
Then there's other guys that don't care about slab, timing, or latency,
but do care about some other events.

So under your plan, all 3 groups now use a "common pool" that includes
slap, timing, latency, and other stuff - and nobody's using more than
1/3 of it, but paying the performance penalty for the 2/3 unused hooks....



--==_Exmh_1147891464_4166P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEa28IcC3lWbTT17ARAuSJAJ4v4MX1Ty0Rz8/ptuTZWk32VFPfrQCeK/CE
RLg32TUjv8vWSvmcUN2IGOI=
=AL5b
-----END PGP SIGNATURE-----

--==_Exmh_1147891464_4166P--
