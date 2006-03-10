Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422671AbWCJBp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbWCJBp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbWCJBp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:45:27 -0500
Received: from hc652af58.dhcp.vt.edu ([198.82.175.88]:11150 "EHLO
	hc652af58.dhcp.vt.edu") by vger.kernel.org with ESMTP
	id S1752159AbWCJBp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:45:27 -0500
Message-Id: <200603100145.k2A1jMem005323@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Carlos Munoz <carlos@kenati.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can I link the kernel with libgcc ? 
In-Reply-To: Your message of "Thu, 09 Mar 2006 17:44:16 PST."
             <4410D9F0.6010707@kenati.com> 
From: Valdis.Kletnieks@vt.edu
References: <4410D9F0.6010707@kenati.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1141955122_3357P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 09 Mar 2006 20:45:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1141955122_3357P
Content-Type: text/plain; charset=us-ascii

On Thu, 09 Mar 2006 17:44:16 PST, Carlos Munoz said:
> I'm writing an audio driver and the hardware requires floating point 
> arithmetic.  When I build the kernel I get the following errors at link 
> time:

Tough break, that.  You sure you can't figure a way to either push the
floating point out to userspace, or do funky fixed-point math instead?

> These symbols are coming from gcc. What I would like to do is link the 
> kernel with libgcc to solve this errors. I'm looking at the kernel 
> makefiles and it doesn't seem obvious to me how to do it.

You can't find it because you can't do it.  It isn't as simple as linking
against libgcc - there's lots of other issues that make floating point
in the kernel Really Really Hard (for starters, it means you need to save
and restore the FP state across interrupts and scheduling within the kernel).

>                                                            Does anyone
> know how I can link the kernel with libgcc, or point me in the right 
> direction ?

The right direction - either push it to userspace, or find a way to do it
with fixed point math.

--==_Exmh_1141955122_3357P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEENoycC3lWbTT17ARAgTMAJ9LitwJ4woEQnLV9TRF8LowCC7D7QCg9Y3z
j35tMl6NV6XfBYe4YxNGqcc=
=0YAl
-----END PGP SIGNATURE-----

--==_Exmh_1141955122_3357P--
