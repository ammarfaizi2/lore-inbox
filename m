Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265897AbUGHH6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUGHH6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbUGHH6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:58:40 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:16268 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265897AbUGHH6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 03:58:37 -0400
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net> <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org> <cone.1089268800.781084.4554.502@pc.kolivas.org> <20040708001027.7fed0bc4.akpm@osdl.org>
Message-ID: <cone.1089273505.418287.4554.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: nigelenki@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Autoregulate swappiness & inactivation
Date: Thu, 08 Jul 2004 17:58:25 +1000
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-4554-1089273505-0014";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-4554-1089273505-0014
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Andrew Morton writes:

> Con Kolivas <kernel@kolivas.org> wrote:
>>
>>  Ah what the heck. They can only be knocked back to where they already are.
> 
> hm.  You get an eGrump for sending two patchs in one email.  Surprisingly
> nice numbers though.
> 
> How come vm_swappiness gets squared?  That's the mysterious "bias
> downwards", yes?  What's the theory there?

No real world feedback mechanism is linear. As the pressure grows the 
positive/negative feedback grows exponentially.

> Please define this new term "application pages"?

errm it's fuzzy to say the least. It's the closest I can come to 
representing what end users understand as "non-cached" pages.

> Those si_swapinfo() and si_meminfo() calls need to come out of there.

I'm game. I had the idea but not the skill. Anyone wanna help me with that?

> A diff against Documentation/filesystems/proc.txt will be needed sometime,
> please.

Ok. I'll try and put together one patch that does the lot.

Con


--=_mimegpg-pc.kolivas.org-4554-1089273505-0014
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7P6hZUg7+tp6mRURAs66AJ9au33KuKauNHMDjPxn5m7/WyxpFACfS3dU
fomkenoRPToSDeNNfp4+coI=
=cSYm
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-4554-1089273505-0014--
