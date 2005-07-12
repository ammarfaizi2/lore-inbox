Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVGLNts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVGLNts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVGLNsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:48:06 -0400
Received: from smtp2.oregonstate.edu ([128.193.4.8]:62116 "EHLO
	smtp2.oregonstate.edu") by vger.kernel.org with ESMTP
	id S261431AbVGLNpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:45:51 -0400
Message-ID: <42D3C82A.3010407@engr.orst.edu>
Date: Tue, 12 Jul 2005 06:39:54 -0700
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@linux.kernel.org
Subject: Re: [PATCH][help?] Radeonfb acpi resume
References: <42D19EE1.90809@engr.orst.edu> <E1DsHSJ-0006kr-00@chiark.greenend.org.uk>
In-Reply-To: <E1DsHSJ-0006kr-00@chiark.greenend.org.uk>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB221B5DACFE91309C0C81FDB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB221B5DACFE91309C0C81FDB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Matthew Garrett wrote:
> Micheal Marineau <marineam@engr.orst.edu> wrote:
> 
> 
>>+	if (pdev->dev.power.power_state != 4)
>>+	{
>>+		pci_restore_state (pdev);
>>+		acpi_vgapost (pdev->devfn);
>>+	}
> 
> 
> Please *don't* make this unconditional. There's no guarantee that the
> video BIOS is postable after initial system boot. A boot-time parameter
> to enable it seems reasonable, but in general we're likely to stand a
> much better chance getting it working in userspace.

A kernel parameter seems reasonable, I assume that pci_restore_state
shoule remain unconditional right?  Userspace works just fine if
the frame buffer is not used, but it has to be done in kernel when
using a frame buffer.


-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------enigB221B5DACFE91309C0C81FDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC08gwiP+LossGzjARAt3kAJ0f06PoNtQ4r/grBBwy5h97B8EjiACdG6RV
wGrNat+k5op1S92Lsu9OF5Q=
=egT/
-----END PGP SIGNATURE-----

--------------enigB221B5DACFE91309C0C81FDB--

