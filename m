Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265871AbUGHHQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUGHHQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbUGHHQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:16:33 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:20871 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265871AbUGHHMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 03:12:53 -0400
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net> <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org> <cone.1089268800.781084.4554.502@pc.kolivas.org> <40ECF278.7070606@yahoo.com.au>
Message-ID: <cone.1089270749.964538.4554.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, nigelenki@comcast.net,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: Autoregulate swappiness & inactivation
Date: Thu, 08 Jul 2004 17:12:29 +1000
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-4554-1089270749-0013";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-4554-1089270749-0013
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Nick Piggin writes:

> Con Kolivas wrote:
>> Andrew Morton writes:
>> 
>>> Con Kolivas <kernel@kolivas.org> wrote:
>>>
>>>>
>>>> > How about autoregulated swappiness, which seems to be very 
>>>> efficient at
>>>>  > its job?
>>>>
>>>>  It's been around for quite a while, and akpm has not expressed any 
>>>>  interest in it so I think this will only ever flounder in the -ck 
>>>> domain.
>>>
>>>
>>> Nobody sent me the patch.  And the
>>> justification/explanation/sales-brochure.  And the benchmarks...
>> 
>> 
>> Ah what the heck. They can only be knocked back to where they already are.
>> 
> 
> A few comments. I think making swappiness depend on the amount of
> swap you have used is not a good idea. I might be wrong though, but
> generally you should only make something *more* complex if you have
> a good rationale and good numbers (you have the later, Andrew might
> consider this enough). I especially don't like this sort of temporal
> dependancy either, because it makes things much harder to reproduce
> and think through.

Noted. The amount of swap hardly has any effect on the swappiness except 
when you're close to OOMing and it is harder to OOM with this in place.

> Secondly, can you please not mess with the exported sysctl. If you
> think your "autoswappiness" calculation is better than the current
> swappiness one, just completely replace it. Bonus points if you can
> retain the swappiness knob in some capacity.

I agree and would like them all removed, but people just love to leave the 
knobs in place. While I dont think the knobs should still be there either, 
I'm not reluctant to leave something that innocuous if the users want them.

> Numbers look good though. I'll get around to doing some tests soon.

Con

--=_mimegpg-pc.kolivas.org-4554-1089270749-0013
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7PPdZUg7+tp6mRURAn3CAJ9WGBTudRURnyuGDUtFF+gP15SJkACgkCVT
f0+UJBMgX2tHX+9IGDDRZts=
=tGoE
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-4554-1089270749-0013--
