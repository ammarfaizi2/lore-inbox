Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWCMXij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWCMXij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWCMXij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:38:39 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:36002 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750770AbWCMXij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:38:39 -0500
References: <200603131908.00161.kernel@kolivas.org> <4415FCBA.7030100@bigpond.net.au>
Message-ID: <cone.1142293105.216069.5853.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH][3/4] sched: add above background load function
Date: Tue, 14 Mar 2006 10:38:25 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-5853-1142293105-0002";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-5853-1142293105-0002
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Peter Williams writes:

> Con Kolivas wrote:
>> +		if (weighted_cpuload(cpu) >= SCHED_LOAD_SCALE)
>> +			return 1;
> I think that you may need to take into account the contribution to the 
> load by your swap prefetching thread when it calls this function 
> otherwise it could cause an incorrect (from your point of view) positive 
> return value.  If the thread has a positive nice value this comment can 
> probably be ignored.

kprefetchd runs at nice 19.

Cheers,
Con


--=_mimegpg-kolivas.org-5853-1142293105-0002
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBEFgJxZUg7+tp6mRURAk7RAKCCF5DMn2EK1EUTxTPeFZYgQ2Y1eACgilYR
s/U7tRXiQnSQfLETXd8eyNk=
=CEmp
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-5853-1142293105-0002--
