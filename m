Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWDRXTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWDRXTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWDRXTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:19:13 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:63117 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750791AbWDRXTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:19:11 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Kernel doesn't compile with CONFIG_HOTPLUG && !CONFIG_NET
Date: Wed, 19 Apr 2006 09:17:27 +1000
User-Agent: KMail/1.9.1
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
References: <200604190844.25476.ncunningham@cyclades.com> <20060418161614.321b61e7.akpm@osdl.org>
In-Reply-To: <20060418161614.321b61e7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2537405.LeBlm624UZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604190917.31393.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2537405.LeBlm624UZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

On Wednesday 19 April 2006 09:16, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> > --- 9904.patch-old/kernel/sysctl.c	2006-04-19 08:40:47.000000000 +1000
> > +++ 9904.patch-new/kernel/sysctl.c	2006-04-17 21:06:23.000000000 +1000
> > @@ -401,7 +401,7 @@ static ctl_table kern_table[] = {
> >  		.strategy	= &sysctl_string,
> >  	},
> >  #endif
> > -#ifdef CONFIG_HOTPLUG
> > +#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
>
> I've had this in -mm for a couple of weeks now but rmk points out that it's
> rather silly.  Because if you have CONFIG_HOTPLUG=y, CONFIG_NET=n then the
> kernel cannot deliver hotplug events to userspace..
>
> So perhaps CONFIG_HOTPLUG should depend upon CONFIG_NET or, better,
> CONFIG_NETLINK.
>
> Dunno.  I left this in Greg's lap, but he's hiding.

:) Ah okay. I guess he's been busy with those mini summits.

Regards,

Nigel

--nextPart2537405.LeBlm624UZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBERXOLN0y+n1M3mo0RAj5eAJ4vcp+2Pg+jbDUItz4N45gMfJFT+ACeNYy6
kb7tv1fM5l/p65gFglLxzYg=
=LdI5
-----END PGP SIGNATURE-----

--nextPart2537405.LeBlm624UZ--
