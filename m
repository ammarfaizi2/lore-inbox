Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVAVGvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVAVGvj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 01:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVAVGvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 01:51:36 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:59308 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262672AbVAVGvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 01:51:03 -0500
Message-ID: <41F1F7AF.7000105@kolivas.org>
Date: Sat, 22 Jan 2005 17:50:23 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: "Jack O'Quin" <joq@io.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt 
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>	<87oefkd7ew.fsf@sulphur.joq.us>	<10752.195.245.190.93.1106211979.squirrel@195.245.190.93>	<65352.195.245.190.94.1106240981.squirrel@195.245.190.94>	<41F19907.2020809@kolivas.org> <87k6q6c7fz.fsf@sulphur.joq.us> <41F1F735.1000603@kolivas.org>
In-Reply-To: <41F1F735.1000603@kolivas.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigECF8E1315D0899472B529708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigECF8E1315D0899472B529708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> Jack O'Quin wrote:
> 
>> Con Kolivas <kernel@kolivas.org> writes:
>>
>>
>>> Here's fresh results on more stressed hardware (on ext3) with
>>> 2.6.11-rc1-mm2 (which by the way has SCHED_ISO v2 included). The load
>>> hovering at 50% spikes at times close to 70 which tests the behaviour
>>> under iso throttling.
>>
>>
>>
>> What version of JACK are you running (`jackd --version')?
>>
>> You're still getting zero Delay Max.  That is an important measure.
> 
> 
> Ok updated jackd
> 
> Here's an updated set of runs. Not very impressive even with SCHED_FIFO, 
> but the same from both policies.
> 
> ==> jack_test4-2.6.11-rc1-mm2-fifo.log <==
> Number of runs  . . . . . . . :(    1)
> *********************************************
> Timeout Count . . . . . . . . :(    0)
> XRUN Count  . . . . . . . . . :   404
> Delay Count (>spare time) . . :     0
> Delay Count (>1000 usecs) . . :     0
> Delay Maximum . . . . . . . . : 261254   usecs
> Cycle Maximum . . . . . . . . :  2701   usecs
> Average DSP Load. . . . . . . :    52.4 %
> Average CPU System Load . . . :     5.1 %
> Average CPU User Load . . . . :    18.1 %
> Average CPU Nice Load . . . . :     0.0 %
> Average CPU I/O Wait Load . . :     0.0 %
> Average CPU IRQ Load  . . . . :     0.0 %
> Average CPU Soft-IRQ Load . . :     0.0 %
> Average Interrupt Rate  . . . :  1699.3 /sec
> Average Context-Switch Rate . : 19018.9 /sec
> *********************************************
> Delta Maximum . . . . . . . . : 0.00000
> *********************************************
> 
> ==> jack_test4-2.6.11-rc1-mm2-iso.log <==
> Number of runs  . . . . . . . :(    1)
> *********************************************
> Timeout Count . . . . . . . . :(    0)
> XRUN Count  . . . . . . . . . :   408
> Delay Count (>spare time) . . :     0
> Delay Count (>1000 usecs) . . :     0
> Delay Maximum . . . . . . . . : 269804   usecs
> Cycle Maximum . . . . . . . . :  2449   usecs
> Average DSP Load. . . . . . . :    52.6 %
> Average CPU System Load . . . :     5.0 %
> Average CPU User Load . . . . :    17.8 %
> Average CPU Nice Load . . . . :     0.0 %
> Average CPU I/O Wait Load . . :     0.1 %
> Average CPU IRQ Load  . . . . :     0.0 %
> Average CPU Soft-IRQ Load . . :     0.0 %
> Average Interrupt Rate  . . . :  1699.2 /sec
> Average Context-Switch Rate . : 19041.0 /sec
> *********************************************
> Delta Maximum . . . . . . . . : 0.00000
> *********************************************

Bah stupid me. Both of those are SCHED_NORMAL.

Ignore those, and I'll try again.

Con

--------------enigECF8E1315D0899472B529708
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8fevZUg7+tp6mRURAtXMAJwMI3hbwUESfWiizmgSf1JvJHVb7gCdHud9
El3qWAB5fKOFpGrVvob6SHU=
=kjIN
-----END PGP SIGNATURE-----

--------------enigECF8E1315D0899472B529708--
