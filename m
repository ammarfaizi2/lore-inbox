Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269602AbUJLKkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbUJLKkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUJLKkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:40:52 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:24523 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269604AbUJLKkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:40:25 -0400
Message-ID: <416BB494.8040007@kolivas.org>
Date: Tue, 12 Oct 2004 20:40:20 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ankit Jain <ankitjain1580@yahoo.com>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: Difference in priority
References: <20041012092804.73700.qmail@web52906.mail.yahoo.com>
In-Reply-To: <20041012092804.73700.qmail@web52906.mail.yahoo.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig36776DFAD1BEC5AD63DD8CCF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig36776DFAD1BEC5AD63DD8CCF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ankit Jain wrote:
> Sorry but iu could not get why are you adding and
> subtracting this 60 in priorities. that corelation i
> had also got but could not understrand whats this 60?
> and also what is this dynamic priority? hows different
> from normal priority

Dynamic priority is the current priority the scheduler has allocated to 
a task. It uses it to decide which task to go next; the lower the number 
the better it's priority so it goes first. The subtracting 100 and 60 is 
just what the userspace tools do to represent an obviously complicated 
value.

Please don't top post. It makes it hard to respond appropriately and 
follow email threads.

Cheers,
Con
> 
> thanks
> 
> ankit
>  --- Con Kolivas <kernel@kolivas.org> wrote: 
> 
>>Con Kolivas wrote:
>>
>>>Ankit Jain wrote:
>>>
>>>
>>>>hi
>>>>
>>>>if somebody knows the difference b/w /PRI of both
>>>>these commands because both give different
>>
>>results
>>
>>>>ps -Al
>>>>& top
>>>>
>>>>as per priority rule we can set priority upto
>>
>>0-99
>>
>>>>but top never shows this high priority
>>>
>>>
>>>Priority values 0-99 are real time ones and
>>
>>100-139 are normal 
>>
>>>scheduling ones. RT scheduling does not change
>>
>>dynamic priority while 
>>
>>>running wheras normal scheduling does (between
>>
>>100-139). top shows the 
>>
>>>value of the current dynamic priority in the PRI
>>
>>column as the current 
>>
>>>dynamic priority-100. If you have a real time task
>>
>>in top it shows as a 
>>
>>>-ve value. ps -Al seems to show the current
>>
>>dynamic priority+60.
>>
>>That should read dynamic priority-60 in the PRI
>>column.



--------------enig36776DFAD1BEC5AD63DD8CCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBa7SWZUg7+tp6mRURAjklAJ9jFdjyaqOF2rgMSsFuhrLgxgqu7gCcD6Kd
a1JnvZSqlvELp9sLkeZQrCo=
=IoK2
-----END PGP SIGNATURE-----

--------------enig36776DFAD1BEC5AD63DD8CCF--
