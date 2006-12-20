Return-Path: <linux-kernel-owner+w=401wt.eu-S1030292AbWLTTcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWLTTcZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWLTTcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:32:24 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:36857 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030292AbWLTTcX (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:32:23 -0500
Message-Id: <200612201926.kBKJQoqN020967@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu
Subject: Re: [PATCH 0/5][time][x86_64] GENERIC_TIME patchset for x86_64
In-Reply-To: Your message of "Tue, 19 Dec 2006 20:20:39 EST."
             <20061220011707.25341.6522.sendpatchset@localhost>
From: Valdis.Kletnieks@vt.edu
References: <20061220011707.25341.6522.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1166642810_3391P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Dec 2006 14:26:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1166642810_3391P
Content-Type: text/plain; charset=us-ascii

On Tue, 19 Dec 2006 20:20:39 EST, john stultz said:
> 	I didn't hear any objections (or really, any comments) on my 
> last release, so as I mentioned then, I want to go ahead and push this 
> to Andrew for a bit of testing in -mm. Hopefully targeting for 
> inclusion in 2.6.21 or 2.6.22.

Am running it on a Dell Latitude D820 (Core2 T7200 cpu).  I had to un-do
4 conflicting patches in -rc1-mm1 and then it applied and ran clean, I still
need to look at re-merging them:

hpet-avoid-warning-message-livelock.patch
clockevents-i386-hpet-driver.patch
get-rid-of-arch_have_xtime_lock.patch
x86_64-mm-amd-tsc-sync.patch

It *looks* like all the pieces are there except a few lines of Kconfig
magic to wire up the dynticks/NO_HZ stuff - or did I miss something crucial?

--==_Exmh_1166642810_3391P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFiY56cC3lWbTT17ARAjbSAJ9gIiEwUW6RFg3c9o4zuwwC/AFSKwCdFRv6
snWQu6MTeeRgHdFAZkbQsWw=
=Ryt4
-----END PGP SIGNATURE-----

--==_Exmh_1166642810_3391P--
