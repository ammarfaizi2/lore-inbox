Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267989AbUHGAUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267989AbUHGAUx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 20:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267996AbUHGAUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 20:20:53 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37343 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267989AbUHGAUv (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 20:20:51 -0400
Message-Id: <200408070020.i770Kh1Q020598@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.0.4+dev
To: linux@horizon.com
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop? 
In-Reply-To: Your message of "Fri, 06 Aug 2004 12:52:36 -0000."
             <20040806125236.24348.qmail@science.horizon.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040806125236.24348.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1068642062P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Aug 2004 20:20:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1068642062P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <700.1091838017.1@turing-police.cc.vt.edu>

On Fri, 06 Aug 2004 12:52:36 -0000, linux@horizon.com said:

> But if you're using PAE, you've got > 4G of RAM, so there's no need to
> be clever trying to avoid HIGHMEM options.

Poking around in arch/i386/mm/init.c finds this:

#ifdef CONFIG_X86_PAE
int nx_enabled = 0;

static void __init set_nx(void)
{
        unsigned int v[4], l, h;

        if (cpu_has_pae && (cpuid_eax(0x80000000) > 0x80000001)) {

I could certainly see somebody wanting to use the NX stuff with only 2G of RAM.....

--==_Exmh_-1068642062P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBFCBbcC3lWbTT17ARAra5AKCs+VxE41BPcGXPMxJCAdiHCVxdsACg71KM
+r7fDI4RePfkHXb6DinDBOY=
=Wc6S
-----END PGP SIGNATURE-----

--==_Exmh_-1068642062P--
