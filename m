Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVAKW3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVAKW3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVAKW2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:28:15 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:11498 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262915AbVAKW1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:27:37 -0500
Message-ID: <41E45288.5020608@kolivas.org>
Date: Wed, 12 Jan 2005 09:26:16 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050110212019.GG2995@waste.org> <200501111305.j0BD58U2000483@localhost.localdomain> <20050111191701.GT2940@waste.org> <20050111125008.K10567@build.pdx.osdl.net> <20050111205809.GB21308@elte.hu> <20050111131400.L10567@build.pdx.osdl.net> <20050111212719.GA23477@elte.hu> <20050111141319.P10567@build.pdx.osdl.net>
In-Reply-To: <20050111141319.P10567@build.pdx.osdl.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE5782DABCBF1F772C4716737"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE5782DABCBF1F772C4716737
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:
> * Ingo Molnar (mingo@elte.hu) wrote:
> 
>>you are right, i forgot about kernel threads. If they are nice -10 on
>>Jack's system too then they are within striking range indeed, especially
>>since they are typically idle and if then they are active for short
>>bursts of time and get the maximum boost. Jack, could you renice these
>>to -5, to make sure they dont interfere?
> 
> 
> Yup, their bursty nature makes them seem a likely culprit.
> 
> 
>>btw., why are these at nice -10? workqueue.c sets nice value to -5
>>normally.
> 
> 
> Heh, I was just wondering the same thing.
> 
> BTW, grepping set_user_nice shows a few more possible culprits.
> One more reason that there may be value in promoting the audio app to
> rt scheduling.

They were nice -10. I changed them to nice -5 recently in -mm and that 
just got commited to -bk post 2.6.10

Cheers,
Con

--------------enigE5782DABCBF1F772C4716737
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5FKIZUg7+tp6mRURAjeGAJ9c5reSeynnamnzC1PVmdKBAY5nLgCfdcaj
ARWKmPsDDT+c19o6Px2BnOs=
=yKUc
-----END PGP SIGNATURE-----

--------------enigE5782DABCBF1F772C4716737--
