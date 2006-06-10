Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWFJCpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWFJCpt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 22:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWFJCpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 22:45:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:10901 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932255AbWFJCps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 22:45:48 -0400
X-Authenticated: #2308221
Date: Sat, 10 Jun 2006 04:45:40 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Christian Trefzer <ctrefzer@gmx.de>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: acpi dock test-drive
Message-ID: <20060610024540.GA7681@hermes.uziel.local>
References: <20060609144326.GA6093@hermes.uziel.local> <1149871538.4542.7.camel@whizzy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <1149871538.4542.7.camel@whizzy>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi Kristen,

On Fri, Jun 09, 2006 at 09:45:38AM -0700, Kristen Accardi wrote:
> What you are describing sounds like the bug I just fixed :).  Can you
> please try 2.6.17-rc6-mm1 to see if this works any better?  I believe it
> should resolve both the oops and the fact that your devices behind the
> pci bridge are not found.  Thanks very much for continuing to test the
> patches.

after adding acpi-dock-driver-acpi_get_device_fix.patch the Oops is
truly gone, although the current behaviour seems dangerous to me. AFAIR
the undock button causes the disk to spin down and the backlight to be
turned off e.g. when the boot manager is displayed and power management
controlled entirely by the bios. What I got now was an endless loop that
caused everything including sysrq keys to be all but interactive, but
what bothers me more is the rythmic noise from the hard disk. It sounds
as if it was attempting a spin-down, barely audible, and only for a
fraction of a second. This happens about 1.5 times per second, and if
this is what I guess it is, it won't prolong the disk's life : /

Devices behind the PCI bridge are not yet discovered as well. Guess I'd
have to build a debug kernel some time soon. Dmesg dumps will have to
wait until "tomorrow", it's 4:45am and I feel like a dead piece of meat.


Thanks for your work!

Chris

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iQIVAwUBRIoyU12m8MprmeOlAQIljRAAjK1D2DlvRd2XKAAWcawg787wYwac2TVO
ZBRpFV1Xaalv8IWeXEFGUPcevjdxbasR881216ULYLNI4Drp80ajid0CVz+dS3Q4
sWW9ZXYkvp32bEBYOr/N21DpGw3lPZSiRuZjw42I0SYWQYBI9TVm8ItwrVsIlH8+
lECs7wyKlL68wiFNkJ61z/WGn+S/4/zpuQxR4TJWj/e2DZf6h5iOoiohLBnE+qZC
SuO60LpgsLC4Ok4R7vTy7WJV1bD1cW6jl1PO3xAUZKeRshCuqwCmPGqLIPDr2fyF
UyWq9+csm1DfItRqLa/GIFMpynyiX+FYGQZjUn8+pyvaWlXHAzjuF2dMImBUdaQw
vMhrJwgrbTPD1gdbRbA0Q6Jxt8+Xmsjyv8KGFZgTNvw60A0NL7jerI8ZQiIvg6ef
xqdJyeDdfKH8MrPut8LmgBoZbgTZRMmDanZvhIi+1S2WnNi2/uQ2/P68fXDxqCRz
j7lWJwolgjPCdiXAodNiAg1wcmd/t4HCvWNmJ4nQCDixFXguUg0k3N31o1EhTFDu
qF96Qn/O9Vbk/8Ww2j19LZp2geej+ogWUZBo4RlhReEQnLpgFnCsJoJ9oW98fFuf
/dbkP0UVJygYzhiKk6FKeEfAjcIeIXp1FAeT/D082Hnbs6RC/XTL3Bnc28NJU3eh
9H0FQQrVvyM=
=aT0m
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

