Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVGLEgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVGLEgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 00:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVGLEdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 00:33:50 -0400
Received: from smtp3.oregonstate.edu ([128.193.0.12]:57275 "EHLO
	smtp3.oregonstate.edu") by vger.kernel.org with ESMTP
	id S262351AbVGLEd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 00:33:27 -0400
Message-ID: <42D347F3.9090705@engr.orst.edu>
Date: Mon, 11 Jul 2005 21:32:51 -0700
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][help?] Radeonfb acpi resume
References: <42D19EE1.90809@engr.orst.edu> <42D19FEE.1040306@engr.orst.edu> <20050711151156.GA2001@elf.ucw.cz> <42D2BF5D.2030703@engr.orst.edu> <20050711185604.GA1997@elf.ucw.cz>
In-Reply-To: <20050711185604.GA1997@elf.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig46E933B9318C715ACDF51801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46E933B9318C715ACDF51801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Hi!
> 
> 
>>>>Aww crap, thunderbird screwed up the white space...
>>>>
>>>>A usable version of the patch is attached, or here is a link:
>>>>http://dev.gentoo.org/~marineam/files/patch-radeonfb-2.6.12
>>>
>>>
>>>Wrong indentation in acpi_vgapost; I remember there was better patch
>>>to fix this out there.
>>
>>Ok, I'll go through and fix any coding style problems.  I've only seen
>>older versions of this same patch, but if there is a better way I'd love
>>to hear it.  I'll google around a little more just in case.
> 
> 
> It *was* version of the same patch, but it had codingstyle fixed, IIRC.

Ok, thats an easy fix then :-)
> 
> 
>>>Anyway, are you sure machine you have can't be fixed by any methods
>>>listed in Doc*/power/video.txt? I guess they are preferable to
>>>acpi_vgapost...
>>
>>Actually, this is one of the metholds listed in video.txt. Take a look
>>at #7 ;-).  I just tried acpi_sleep=s3_bios to see what that does, but
>>just caused an instant reboot on resume.  The only other solutions that
>>works is to disable the frame buffer and use X or some other app to do
>>the job as listed in #5 and #6, but something in kernel like this patch
>>is required to be able to use the framebuffer.
> 
> 
> I'd say that disabling framebuffer and going #5 or #6 is still
> prefered, but given nice patch, I'll probably accept it. Oh, and do
> note that (7) is listed near just one notebook.
> 
> 								Pavel

Well, before the patch is ever concidered for the mainline I think
the issue with acquire_console_sem() causing the resume process to
stop and wait for a key press would have to be addressed.

This option could be listed for more notebooks with radeon cards,
for example mine is an Dell Inspiron 8500.


-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------enig46E933B9318C715ACDF51801
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC00gOiP+LossGzjARAuvyAKDNQ6sMULjkWXD6J5QudM7cbc4TiwCfY7u6
AaaVz+Wot7c+wWbiqytXJVQ=
=CrkZ
-----END PGP SIGNATURE-----

--------------enig46E933B9318C715ACDF51801--
