Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWCRLau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWCRLau (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 06:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWCRLau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 06:30:50 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:60898 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751013AbWCRLat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 06:30:49 -0500
X-Sasl-enc: YRV6vVi74M6cthEwot0OtechyRU6JKCUuIaJ1hRRVm42 1142681443
Message-ID: <441BEF7D.4000605@imap.cc>
Date: Sat, 18 Mar 2006 12:31:09 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@pol.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: i810 framebuffer - BUG: sleeping function called from invalid
 context
References: <44186D30.4040603@imap.cc> <20060317031410.2479d8e1.akpm@osdl.org> <441ACCD5.6070404@pol.net>
In-Reply-To: <441ACCD5.6070404@pol.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4A501C0D6A32EB7DC17C6A30"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A501C0D6A32EB7DC17C6A30
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 17.03.2006 15:51, Antonino A. Daplas wrote:
> The console cursor can be called in atomic context.  Change memory
> allocation to use the GFP_ATOMIC flag in i810fb_cursor().

Thanks, that fixed it.

-- 
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
It is well known that a vital ingredient of success is not knowing
that what you're attempting can't be done. (Terry Pratchett)

--------------enig4A501C0D6A32EB7DC17C6A30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEG++FMdB4Whm86/kRAtQ9AJ9dqo38kRdVCVkYuDP9MkTF5xZwfACdHw5N
50qp8udXpHTVn+RdSvlHZmw=
=MBtx
-----END PGP SIGNATURE-----

--------------enig4A501C0D6A32EB7DC17C6A30--
