Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVAVARF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVAVARF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVAVAJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:09:47 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:27791 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262610AbVAVAHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:07:08 -0500
Message-ID: <41F19907.2020809@kolivas.org>
Date: Sat, 22 Jan 2005 11:06:31 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: "Jack O'Quin" <joq@io.com>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt 
                    scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>             <873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>             <87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>             <87oefkd7ew.fsf@sulphur.joq.us>          <10752.195.245.190.93.1106211979.squirrel@195.245.190.93> <65352.195.245.190.94.1106240981.squirrel@195.245.190.94>
In-Reply-To: <65352.195.245.190.94.1106240981.squirrel@195.245.190.94>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig13958CFC4AE1A91AC70F0DC8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig13958CFC4AE1A91AC70F0DC8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rui Nuno Capela wrote:
> OK. Here goes my fresh and newly jack_test4.1 test suite. It might be
> still rough, as usual ;)

Thanks

Here's fresh results on more stressed hardware (on ext3) with 
2.6.11-rc1-mm2 (which by the way has SCHED_ISO v2 included). The load 
hovering at 50% spikes at times close to 70 which tests the behaviour 
under iso throttling.


==> jack_test4-2.6.11-rc1-mm2-fifo.log <==
Number of runs  . . . . . . . :(    1)
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :    41
Delay Count (>spare time) . . :     0
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :     0   usecs
Cycle Maximum . . . . . . . . : 10968   usecs
Average DSP Load. . . . . . . :    44.3 %
Average CPU System Load . . . :     4.9 %
Average CPU User Load . . . . :    17.1 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.0 %
Average CPU IRQ Load  . . . . :     0.0 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :  1689.9 /sec
Average Context-Switch Rate . : 19052.6 /sec
*********************************************
Delta Maximum . . . . . . . . : 0.00000
*********************************************

==> jack_test4-2.6.11-rc1-mm2-iso.log <==
Number of runs  . . . . . . . :(    1)
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :     2
Delay Count (>spare time) . . :     0
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :     0   usecs
Cycle Maximum . . . . . . . . :  1282   usecs
Average DSP Load. . . . . . . :    50.5 %
Average CPU System Load . . . :    11.2 %
Average CPU User Load . . . . :    17.6 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.0 %
Average CPU IRQ Load  . . . . :     0.0 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :  1688.8 /sec
Average Context-Switch Rate . : 18985.1 /sec
*********************************************
Delta Maximum . . . . . . . . : 0.00000
*********************************************

==> jack_test4-2.6.11-rc1-mm2-normal.log <==
Number of runs  . . . . . . . :(    1)
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :   325
Delay Count (>spare time) . . :     0
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :     0   usecs
Cycle Maximum . . . . . . . . :  4726   usecs
Average DSP Load. . . . . . . :    50.0 %
Average CPU System Load . . . :     5.1 %
Average CPU User Load . . . . :    18.7 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.0 %
Average CPU IRQ Load  . . . . :     0.1 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :  1704.5 /sec
Average Context-Switch Rate . : 18875.2 /sec
*********************************************
Delta Maximum . . . . . . . . : 0.00000
*********************************************

Full data and pretty pictures:
http://ck.kolivas.org/patches/SCHED_ISO/iso2-benchmarks/

Cheers,
Con

--------------enig13958CFC4AE1A91AC70F0DC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8ZkHZUg7+tp6mRURAqKeAJ9BYD9HVnxG4lvxmq583d3jGZaxpQCfSdN0
8lMkSL5VMwJzN0W+JDyJm8M=
=i28O
-----END PGP SIGNATURE-----

--------------enig13958CFC4AE1A91AC70F0DC8--
