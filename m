Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVAWEwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVAWEwe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVAWEwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:52:34 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:33757 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261221AbVAWEvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:51:25 -0500
Message-ID: <41F32D32.7050007@kolivas.org>
Date: Sun, 23 Jan 2005 15:50:58 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt 
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>	<87oefkd7ew.fsf@sulphur.joq.us>	<10752.195.245.190.93.1106211979.squirrel@195.245.190.93>	<65352.195.245.190.94.1106240981.squirrel@195.245.190.94>	<41F19907.2020809@kolivas.org> <87k6q6c7fz.fsf@sulphur.joq.us>	<41F1F735.1000603@kolivas.org> <41F1F7AF.7000105@kolivas.org>	<41F1FC1D.10308@kolivas.org> <87wtu55i3x.fsf@sulphur.joq.us>	<41F2F7C1.70404@kolivas.org> <87r7kcu9tt.fsf@sulphur.joq.us>	<41F32832.50100@kolivas.org> <87acr03g8e.fsf@sulphur.joq.us>
In-Reply-To: <87acr03g8e.fsf@sulphur.joq.us>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig018D96D6B9338855593DC64A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig018D96D6B9338855593DC64A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jack O'Quin wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
> 
>>Jack O'Quin wrote:
>>[snip lots of valid points]
>>
>>>suggest some things to try.  First, make sure the JACK tmp directory
>>>is mounted on a tmpfs[1].  Then, try the test with ext2, instead of
>>
>>Looks like the tmpfs is probably the biggest problem. Here's SCHED_ISO
>>with just the /tmp mounted on tmpfs change - running on a complete
>>desktop environment with a 2nd exported X seession and my wife
>>browsing the net and emailing at the same time.
>>
>>All invalid runs removed and just this one posted here:
>>http://ck.kolivas.org/patches/SCHED_ISO/iso2-benchmarks/
>>
>>How's that look?
> 
> 
> Excellent!  
> 
> Sorry I didn't warn you about that problem before.  JACK audio users
> generally know about it, but there's no reason you should have.
> 
> So, that was run with ext3?

Yes I think I mentioned before this is a different machine than the 
pentiumM one. It's a P4HT3.06 with on board i810 sound and ext3 (which 
explains the vastly different DSP usage). The only "special" measure 
taken for jackd was to use the latest jackd code and the tmpfs mount you 
suggested. Looks like the number of steps to convert a modern "standard 
setup" desktop to a low latency one on linux aren't that big after all :)

Cheers,
Con

--------------enig018D96D6B9338855593DC64A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8y00ZUg7+tp6mRURAuwFAJ9P1nM1uxbGQiPUAFOAT2VfGGxy3ACZATWx
b9ApatR4ShIcxlJi5u4ki+A=
=5YDx
-----END PGP SIGNATURE-----

--------------enig018D96D6B9338855593DC64A--
