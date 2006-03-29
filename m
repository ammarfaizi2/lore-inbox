Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWC2Xho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWC2Xho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWC2Xhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:37:43 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:52159 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751278AbWC2Xhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:37:42 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Date: Thu, 30 Mar 2006 09:36:16 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
References: <20060329220808.GA1716@elf.ucw.cz> <20060329144746.358a6b4e.akpm@osdl.org> <20060329150950.A12482@unix-os.sc.intel.com>
In-Reply-To: <20060329150950.A12482@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart25418762.Vyl80jxFUJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603300936.22757.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart25418762.Vyl80jxFUJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 30 March 2006 09:09, Ashok Raj wrote:
> On Wed, Mar 29, 2006 at 02:47:46PM -0800, Andrew Morton wrote:
> > Pavel Machek <pavel@ucw.cz> wrote:
> > > HOTPLUG_CPU is needed on normal PCs, too -- it is neccessary for
> > > software suspend.
> >
> > OK, this will get ugly.  APICs are involved.
>
> I guess you need only on systems that support >1 cpu right? I doubt you
> will need it on a system that cannot run with the config-generic-arch on.
> although we use bigsmp when hotplug is turned on, all we really end up is
> using flat physical mode instead of using logical mode.
>
> I still havent understood why this wont work. Choosing
> CONFIG_X86_GENERICARCH shouldnt break anything AFAICT.
>
> Pavel, you could use CONFIG_HOTPLUG_CPU, just need to enable
> X86_GENERICARCH now. Is there a reason you think that wont work? I wish we
> would revert it for a strong reason that we know will not make hotplug wo=
rk
> on certain systems because of this choise not that we currently have X86_=
PC
> now, and are unwiling to change the config.
>
> (PS: the word bigsmp although sounds like some large NR_CPUS, its just
> using a mode that permits the system to work from 1 .. >8 cpus. So there =
is
> really nothing determental to selecting this.)

So if you have a single core x86, you want X86_PC, and if you have HT or SM=
P,=20
you want GENERICARCH? If so, could this be done via selects or depends or a=
t=20
least defaults in Kconfig?

Regards,

Nigel

--nextPart25418762.Vyl80jxFUJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEKxn2N0y+n1M3mo0RAnyYAKCF2eEAfkkFMddgoPUqjRmPwEpR7ACglv5t
CFWZT3R68pkOIh5/MsJZRhM=
=Qx3S
-----END PGP SIGNATURE-----

--nextPart25418762.Vyl80jxFUJ--
