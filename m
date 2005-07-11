Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVGKSyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVGKSyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVGKSwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:52:10 -0400
Received: from smtp1.oregonstate.edu ([128.193.0.11]:6540 "EHLO
	smtp1.oregonstate.edu") by vger.kernel.org with ESMTP
	id S262025AbVGKSuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:50:25 -0400
Message-ID: <42D2BF5D.2030703@engr.orst.edu>
Date: Mon, 11 Jul 2005 11:50:05 -0700
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][help?] Radeonfb acpi resume
References: <42D19EE1.90809@engr.orst.edu> <42D19FEE.1040306@engr.orst.edu> <20050711151156.GA2001@elf.ucw.cz>
In-Reply-To: <20050711151156.GA2001@elf.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig734858B8294184BD34DEA4B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig734858B8294184BD34DEA4B0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks for the reply,

Pavel Machek wrote:
> Hi!
> 
> 
>>Aww crap, thunderbird screwed up the white space...
>>
>>A usable version of the patch is attached, or here is a link:
>>http://dev.gentoo.org/~marineam/files/patch-radeonfb-2.6.12
> 
> 
> Wrong indentation in acpi_vgapost; I remember there was better patch
> to fix this out there.
Ok, I'll go through and fix any coding style problems.  I've only seen
older versions of this same patch, but if there is a better way I'd love
to hear it.  I'll google around a little more just in case.

> 
> Anyway, are you sure machine you have can't be fixed by any methods
> listed in Doc*/power/video.txt? I guess they are preferable to
> acpi_vgapost...
Actually, this is one of the metholds listed in video.txt. Take a look
at #7 ;-).  I just tried acpi_sleep=s3_bios to see what that does, but
just caused an instant reboot on resume.  The only other solutions that
works is to disable the frame buffer and use X or some other app to do
the job as listed in #5 and #6, but something in kernel like this patch
is required to be able to use the framebuffer.

> 
> If not... indent it acording to the coding style and drop "phony
> return code" (it is unneeded, anyway, right?) and try again. (Oh and
> Cc me ;-).
> 								Pavel

Ok, I'll try it without. I don't know if it's needed or not, that code
is untouched from Ole Rohne's origional version.

-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------enig734858B8294184BD34DEA4B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC0r9miP+LossGzjARAgV1AJ9rK7s4E0wg48hMNzNHusZCb86u/wCguw7I
rQXiTw5f2SpvmvRzmjqjdIM=
=wnH2
-----END PGP SIGNATURE-----

--------------enig734858B8294184BD34DEA4B0--
