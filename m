Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUJIGJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUJIGJb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 02:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUJIGHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 02:07:55 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:62873 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266547AbUJIFx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:53:26 -0400
Message-ID: <41677CBC.7050705@kolivas.org>
Date: Sat, 09 Oct 2004 15:53:00 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Preemption model (was Re: voluntary-preempt-2.6.9-rc3-mm3-T3)
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>	 <20041007105230.GA17411@elte.hu>	 <1097297824.1442.132.camel@krustophenia.net>	 <cone.1097298596.537768.1810.502@pc.kolivas.org>	 <1097299260.1442.142.camel@krustophenia.net>  <416775CD.70706@kolivas.org>	 <1097299886.1442.145.camel@krustophenia.net> <41677862.2020806@kolivas.org> <1097300995.1442.156.camel@krustophenia.net>
In-Reply-To: <1097300995.1442.156.camel@krustophenia.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5C38F097978EF73EB9E1190B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C38F097978EF73EB9E1190B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell wrote:
> On Sat, 2004-10-09 at 01:34, Con Kolivas wrote:
> 
>>Lee Revell wrote:
>>
>>>>>>>With VP and PREEMPT in general, does the scheduler always run the
>>>>>>>highest priority process, or do we only preempt if a SCHED_FIFO process
>>>>>>>is runnable?
>>>>>>
>>>>>>Always the highest priority runnable.
>>>>>>
>>>>>
>>>>>
>>>>>Hmm, interesting.  Would there be any advantage to a mode where only
>>>>>SCHED_FIFO tasks can preempt?  This seems like a much lighter way to
>>>>>solve the realtime problem.
>>>>
>>>>No, the linux scheduler has always been preemptible. PREEMPT and VP just 
>>>>allows it to preempt kernel code paths as well. It could be modified to 
>>>>do such a thing but apart from real time applications it would perform 
>>>>very badly overall.
>>>
>>>
>>>I am talking about a mode where we only allow a SCHED_FIFO process to
>>>preempt a kernel code path.  In every other case it works like !PREEMPT.
>>>
>>>This is apparently how kernel preemption worked on SVR4.
>>
>>Yes it could. If you ask nicely, Ingo might even throw in yet another 
>>config option in the kernel. It gets messy if multiple people start 
>>hacking on the same thing when it's under heavy development.
> 
> 
> Oh, I was not going to post a patch, I don't know the code nearly well
> enough at this point :-).  But it looks pretty straightforward.

I was talking about me ;-)

Cheers,
Con


--------------enig5C38F097978EF73EB9E1190B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBZ3y+ZUg7+tp6mRURAqWRAJ0erK1zSZN2hafZjCWL97GDUzOqZQCeIyd/
enxVtyvl/q1+7Dt9vE/QEYs=
=txQF
-----END PGP SIGNATURE-----

--------------enig5C38F097978EF73EB9E1190B--
