Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbUKBM5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbUKBM5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbUKBM4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:56:18 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:45735 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262491AbUKBMxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:53:11 -0500
Message-ID: <41878318.8020801@kolivas.org>
Date: Tue, 02 Nov 2004 23:52:40 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add requeue task
References: <418707E5.90705@kolivas.org> <20041102124252.GE15290@elte.hu>
In-Reply-To: <20041102124252.GE15290@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE1B0246C0EE66071D479A0CA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE1B0246C0EE66071D479A0CA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>add requeue task
> 
> 
> ack for this bit, but please split this one out:
> 
> | Change the granularity code to requeue tasks at their best priority
> | instead of changing priority while they're running. This keeps tasks 
> | at their top interactive level during their whole timeslice.
> 
> this is a behavioral change and should go into the 'possible negative
> effect on interactivity' bucket. (of course it could very likely have a
> positive effect as well - the bucket is just to separate the risks.)

Actually I'd like to say I did it for positive effect to counter the 
change that occurred with dropping interactive credit. That was what I 
found in my testing, and I'd like them both to go together into -mm.

Con

--------------enigE1B0246C0EE66071D479A0CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBh4MYZUg7+tp6mRURAoMBAJ9lqNboLJeKgze1mkh92G58nzcgvQCZAZGg
KURFkDqPtj/3aCAFHwsOBoc=
=hy2h
-----END PGP SIGNATURE-----

--------------enigE1B0246C0EE66071D479A0CA--
