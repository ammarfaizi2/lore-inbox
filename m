Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264191AbUFBVRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbUFBVRs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbUFBVRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:17:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22146 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264175AbUFBVRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:17:38 -0400
Date: Wed, 2 Jun 2004 23:17:14 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040602211714.GB29687@devserv.devel.redhat.com>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 02, 2004 at 02:13:13PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 2 Jun 2004, Ingo Molnar wrote:
> > 
> > If the NX feature is supported by the CPU then the patched kernel turns
> > on NX and it will enforce userspace executability constraints such as a
> > no-exec stack and no-exec mmap and data areas. This means less chance
> > for stack overflows and buffer-overflows to cause exploits.
> 
> Just out of interest - how many legacy apps are broken by this? I assume 
> it's a non-zero number, but wouldn't mind to be happily surprised.

based on execshield in FC1.. about zero.

> 
> And do we have some way of on a per-process basis say "avoid NX because
> this old version of Oracle/flash/whatever-binary-thing doesn't run with
> it"?

yes those aren't compiled with the PT_GNU_STACK elf flag and run with the
stack executable just fine. GCC will also emit a "make the stack executable"
flag when it emits code that puts stack trampolines up.
That all JustWorks(tm).
--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAvkPZxULwo51rQBIRAnJmAJ9T9M8CcRytG9s5am9w48GroUYD/wCgmbfQ
FhW8eiuEig2R/vdijTkSfS8=
=PeVO
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
