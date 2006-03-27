Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWC0Cgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWC0Cgz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 21:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWC0Cgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 21:36:55 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:9896 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932151AbWC0Cgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 21:36:53 -0500
Date: Mon, 27 Mar 2006 13:36:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] create struct compat_timex and use it everywhere
Message-Id: <20060327133602.235ef0dc.sfr@canb.auug.org.au>
In-Reply-To: <20060323191819.GA13794@agluck-lia64.sc.intel.com>
References: <20060323164623.699f569e.sfr@canb.auug.org.au>
	<20060323185234.GA13486@agluck-lia64.sc.intel.com>
	<20060323190922.GA13695@agluck-lia64.sc.intel.com>
	<20060323191819.GA13794@agluck-lia64.sc.intel.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__27_Mar_2006_13_36_02_+1100_FiwfBqRa6_Ltoc=r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__27_Mar_2006_13_36_02_+1100_FiwfBqRa6_Ltoc=r
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Thu, 23 Mar 2006 11:18:19 -0800 "Luck, Tony" <tony.luck@intel.com> wrote:
>
> On Thu, Mar 23, 2006 at 11:09:22AM -0800, Luck, Tony wrote:
> > -	data8 sys_ni_syscall	/* adjtimex */
> > +	data8 sys32_adjtimex
>=20
> -ENOCOFFEE
>=20
> Of course that should be:
>=20
>=20
> diff --git a/arch/ia64/ia32/ia32_entry.S b/arch/ia64/ia32/ia32_entry.S
> index 95fe044..a32cd59 100644
> --- a/arch/ia64/ia32/ia32_entry.S
> +++ b/arch/ia64/ia32/ia32_entry.S
> @@ -334,7 +334,7 @@ ia32_syscall_table:
>  	data8 sys_setdomainname
>  	data8 sys32_newuname
>  	data8 sys32_modify_ldt
> -	data8 sys_ni_syscall	/* adjtimex */
> +	data8 compat_sys_adjtimex
>  	data8 sys32_mprotect	  /* 125 */
>  	data8 compat_sys_sigprocmask
>  	data8 sys_ni_syscall	/* create_module */


This patch is really just a matter for the ia64 tree, my patch was a cross
architecture consolidation.  Now that my patches are in Linus's tree, you
should just submit the above (as long as it works and is needed) via the
ia64 tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__27_Mar_2006_13_36_02_+1100_FiwfBqRa6_Ltoc=r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEJ0+XFdBgD/zoJvwRAnetAKCHsLDzNaj9UGD7dX+6A/7p8PJtJgCgh3mS
DSak3YcCSVCesWL+Ke6tbqo=
=F4O1
-----END PGP SIGNATURE-----

--Signature=_Mon__27_Mar_2006_13_36_02_+1100_FiwfBqRa6_Ltoc=r--
