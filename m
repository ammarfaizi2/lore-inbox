Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269192AbUIHWzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269192AbUIHWzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 18:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269194AbUIHWzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 18:55:21 -0400
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:35836 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S269192AbUIHWy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 18:54:29 -0400
Date: Wed, 8 Sep 2004 17:54:31 -0500
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ISA DMA
Message-Id: <20040908175431.5872dda0.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <413F7960.8070500@drzeus.cx>
References: <413F7960.8070500@drzeus.cx>
X-Mailer: Sylpheed version 0.9.12cvs7 (GTK+ 1.2.10; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__8_Sep_2004_17_54_31_-0500_M.IqQFWsR/h5MnG6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__8_Sep_2004_17_54_31_-0500_M.IqQFWsR/h5MnG6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Uttered Pierre Ossman <drzeus-list@drzeus.cx>, spake thus:

> I've been trying to figure out how other drivers do it but I can't see 
> what I'm missing. And the documentation doesn't cover ISA DMA.

Allocate your DMA buffer area by OR'ing in the "GFP_DMA" flag.  This
keeps your DMA buffer below the magical 16MB limit.  Also be sure to
use "virt_to_bus()" to convert the kernel buffer address into one
that you can give to the DMA engine.

HTH.

--Signature=_Wed__8_Sep_2004_17_54_31_-0500_M.IqQFWsR/h5MnG6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBP42r/0ydqkQDlQERAiGuAKCbHAeISDfqulA/nYMxvRuAnnQl3gCfaL9U
uMEMYUxG2nLdspikjDCQW/w=
=IXfv
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Sep_2004_17_54_31_-0500_M.IqQFWsR/h5MnG6--
