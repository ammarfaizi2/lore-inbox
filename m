Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVBGD2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVBGD2M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 22:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVBGD2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 22:28:12 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:47502 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261341AbVBGD1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 22:27:53 -0500
Message-ID: <4206E01E.6060408@kolivas.org>
Date: Mon, 07 Feb 2005 14:27:26 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Werner Almesberger <wa@almesberger.net>,
       linux <linux-kernel@vger.kernel.org>,
       abiss-general@lists.sourceforge.net
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>	<87oefkd7ew.fsf@sulphur.joq.us> <41EF48BA.50709@kolivas.org>	<20050207000922.B25338@almesberger.net> <87acqhnj6h.fsf@sulphur.joq.us>
In-Reply-To: <87acqhnj6h.fsf@sulphur.joq.us>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7E0824471F5C70C3791EE8B4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E0824471F5C70C3791EE8B4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jack O'Quin wrote:
> Werner Almesberger <wa@almesberger.net> writes:
> 
> 
>>[ Cc:s trimmed, added abiss-general ]
>>
>>Con Kolivas wrote:
>>
>>>Possibly reiserfs journal related. That has larger non-preemptible code 
>>>sections.
>>
>>If I understand your workload right, it should consist mainly of
>>computation, networking (?), and disk reads.
> 
> 
> The jack_test3.2 is basically a multiprocess realtime audio test.  A
> fair amount of computation, signifcant task switch overhead, but
> most I/O is to the sound card.
> 
> There's some disk activity starting clients and probably some other
> system activity in the background.
> 
> 
>>I don't know much about ReiserFS, but in some experiments with ext3,
>>using ABISS, we found that a reader application competing with best
>>effort readers would experience worst-case delays of dozens of
>>milliseconds.
>>
>>They were caused by journaled atime updates. Mounting the file
>>system with "noatime" reduced delays to a few hundred microseconds
>>(still worst-case).
> 
> 
> Interesting. Worth a try to verify.  Con was seeing a 6msec delay
> every 20 seconds.  This was devastating to the test, which tries to
> run a full realtime audio cycle every 1.45msec.

They already were mounted noatime :(

Con

--------------enig7E0824471F5C70C3791EE8B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCBuAlZUg7+tp6mRURAksUAJ4zE38vwg0PA1ze4fIwH4ZDKnkvFwCbBqPR
uLbipre8x6oN5VMzMVpdUAw=
=569b
-----END PGP SIGNATURE-----

--------------enig7E0824471F5C70C3791EE8B4--
