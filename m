Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbULUVgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbULUVgH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 16:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbULUVgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 16:36:07 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:21638 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261859AbULUVgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 16:36:01 -0500
Message-ID: <41C89734.8020302@kolivas.org>
Date: Wed, 22 Dec 2004 08:35:48 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jesse <jessezx@yahoo.com>
Cc: Paulo Marques <pmarques@grupopie.com>, linux-kernel@vger.kernel.org
Subject: Re: Gurus, a silly question for preemptive behavior
References: <20041221190339.24215.qmail@web52605.mail.yahoo.com>
In-Reply-To: <20041221190339.24215.qmail@web52605.mail.yahoo.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3391ABC2449B215600E72F01"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3391ABC2449B215600E72F01
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

jesse wrote:
> Paulo:
>  
>    I already said in the messsage that my user space
> application has a low nice priority, i set it to 10.
> since my application has low priority compared to
> other user space applications, it is supposed to be
> interrupted. but it is not.

If your task is better priority the scheduler will make it preempt the 
worse priority task. It sounds to me like you are complaining that the 
worse priority task is still getting cpu? If so, you misunderstand 
priority - it orders tasks according to priority giving lower latency 
and preemptive behaviour to the better task, and gives _more_ cpu but 
not all the cpu. The cpu must still be shared, but with more cpu 
distributed to the better priority task. If you want your better 
priority task to get _all_ the cpu you have to use real time scheduling.

Cheers,
Con

P.S. Please dont top post when replying, it's hard to follow an email 
thread to see what you're replying to if you do that. These threads can 
get very long and confusing.

--------------enig3391ABC2449B215600E72F01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFByJc2ZUg7+tp6mRURAs2EAJ4njSxd3KglBqSXDbReYFRcLiaPiACdEMD7
5igfw4CYCB0qmAKkSbh4wQs=
=dP/y
-----END PGP SIGNATURE-----

--------------enig3391ABC2449B215600E72F01--
