Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVASIn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVASIn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVASIOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:14:48 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:48060 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261629AbVASH5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:57:00 -0500
Message-ID: <41EE12AB.9020604@kolivas.org>
Date: Wed, 19 Jan 2005 18:56:27 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>
Subject: Re: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt
 scheduling
References: <41ED08AB.5060308@kolivas.org> <87is5tx61a.fsf@sulphur.joq.us>
In-Reply-To: <87is5tx61a.fsf@sulphur.joq.us>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2B87AAE17D730F59B96DB18B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B87AAE17D730F59B96DB18B
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jack O'Quin wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
> 
>>This patch for 2.6.11-rc1 provides a method of providing real time
>>scheduling to unprivileged users which increasingly is desired for
>>multimedia workloads.
> 
> 
> I ran some jack_test3.2 runs with this, using all the default
> settings.  The results of three runs differ quite significantly for no
> obvious reason.  I can't figure out why the DSP load should vary so
> much.  
> 
> These may be bogus results.  It looks like a libjack bug sometimes
> causes clients to crash when deactivating.  I will investigate more
> tomorrow, and come up with a fix.
> 
> For comparison, I also made a couple of runs using the realtime-lsm to
> grant SCHED_FIFO privileges.  There was some variablility, but nowhere
> near as much (and no crashes).  I used schedtool to verify that the
> jackd threads actually have the expected scheduler type.

Thanks for those. If you don't know what to make of the dsp variation 
and the crashing then I'm not sure what I should make of it either. It's 
highly likely that my code still needs fixing to ensure it behaves as 
expected. Already one bug has been picked up in testing with respect to 
yield() so there may be others. By design, if you set iso_cpu to 100 it 
should be as good as SCHED_RR. If not, then the implementation is still 
buggy.

Cheers,
Con

--------------enig2B87AAE17D730F59B96DB18B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7hKrZUg7+tp6mRURAlz7AJ9nh95d6APpfiuEeEpAEnUuRTkAtQCcCMqp
gmYzPyR5lRiCjLFRuvhySjY=
=t+Zq
-----END PGP SIGNATURE-----

--------------enig2B87AAE17D730F59B96DB18B--
