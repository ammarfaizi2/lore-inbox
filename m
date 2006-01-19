Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWASJrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWASJrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWASJrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:47:40 -0500
Received: from h80ad24de.async.vt.edu ([128.173.36.222]:62115 "EHLO
	h80ad24de.async.vt.edu") by vger.kernel.org with ESMTP
	id S932585AbWASJrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:47:40 -0500
Message-Id: <200601190947.k0J9l4Cu029568@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16-rc1-mm1 - produce useful info for kzalloc with DEBUG_SLAB 
In-Reply-To: Your message of "Thu, 19 Jan 2006 10:58:13 +0200."
             <84144f020601190058s2e8e86a8ya761fcb4fdd8eeaa@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <200601190830.k0J8UG9Q008899@turing-police.cc.vt.edu>
            <84144f020601190058s2e8e86a8ya761fcb4fdd8eeaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137664022_3359P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 04:47:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137664022_3359P
Content-Type: text/plain; charset=us-ascii

On Thu, 19 Jan 2006 10:58:13 +0200, Pekka Enberg said:
> On 1/19/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> > The following patch makes a few minor changes so the CONFIG_DEBUG_SLAB
> > statistics report the actual caller for kzalloc() - otherwise its call to
> > kmalloc() just points at kzalloc().  Basically, we force __always_inline on
> > several routines, so the __builtin_return_address calls point where we
> > want them to point, even if gcc wouldn't otherwise do it.
> 
> Couldn't we use this [1] trick Steven came up with for this?
> 
>   1. http://article.gmane.org/gmane.linux.kernel/362494

I posted the basic idea of this patch back on Dec 18, Steven came up with
his stuff about 2 weeks later, and it's a bit too creative with its use of
the preprocessor for my tastes,  so I didn't retrofit the idea.

On the other hand, I'm not *that* attached to my solution - if somebody wants
to code a patch Steven's way and toss it to Andrew, they're welcome to do so,
and we'll let Andrew decide. ;)

--==_Exmh_1137664022_3359P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDz2AWcC3lWbTT17ARAss4AJ9I7/S1ulJZZ/DMer+g/U1e0tyhsACgqMDH
FUCdCfO8KfQGhzpoGCuBnuQ=
=YtXZ
-----END PGP SIGNATURE-----

--==_Exmh_1137664022_3359P--
