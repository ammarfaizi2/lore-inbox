Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbUJ1X2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbUJ1X2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbUJ1X1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:27:08 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59410 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263072AbUJ1XYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:24:03 -0400
Date: Fri, 29 Oct 2004 01:23:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 traps.c: remove an unused function
Message-ID: <20041028232326.GJ3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from arch/i386/kernel/traps.c


diffstat output:
 arch/i386/kernel/traps.c |    9 ---------
 1 files changed, 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/arch/i386/kernel/traps.c.old	2004-10-28 22:32:02.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/arch/i386/kernel/traps.c	2004-10-28 22:32:13.000000000 +0200
@@ -400,15 +400,6 @@
 		die(str, regs, err);
 }
 
- -static inline unsigned long get_cr2(void)
- -{
- -	unsigned long address;
- -
- -	/* get the address */
- -	__asm__("movl %%cr2,%0":"=r" (address));
- -	return address;
- -}
- -
 static inline void do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgX9umfzqmE8StAARAp1cAJ9UWPsEY9whFKiV74mbCVdqZsWZKACeJCJU
RrA3RYIcl4e1HcwMnVz+9KA=
=6Rti
-----END PGP SIGNATURE-----
