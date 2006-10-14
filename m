Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422844AbWJNUsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422844AbWJNUsf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 16:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422841AbWJNUsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 16:48:35 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:22983 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030404AbWJNUse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 16:48:34 -0400
Message-ID: <45314D20.7060904@comcast.net>
Date: Sat, 14 Oct 2006 16:48:32 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Driver model.. expel legacy drivers?
References: <200610141854.k9EIs2CN005765@laptop13.inf.utfsm.cl>
In-Reply-To: <200610141854.k9EIs2CN005765@laptop13.inf.utfsm.cl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Horst H. von Brand wrote:
> John Richard Moser <nigelenki@comcast.net> wrote:
> 
> [...]
> 
>> I've mapped the growth of the .tar.bz2 archives in kilobytes since
>> 2.6.0, they show an erratic pattern but a strong overall linear growth
>> pattern.  This means the actual size of the kernel is polynomial and
>> integrates crudely to:
>>
>>    18.59x^2+133.1x+32600
>>
>> For x == minor (i.e. 2.6.0 == 0; 2.6.18 == 18).  This produces a level
>> of error; however, I've graphed the error and it seems to be off by no
>> more than 400k ever and show a horizontal trend (i.e. overall accurate);
>> however I'll have to apply the same prediction to future kernel versions
>> to get a good picture.
> 
> Hum... perhaps going against time (not minor) is better?
> 

I think revisions have an average time between them that follows a
general linear trend.  {1 4 3 1 0 2 2 3} is a general linear trend; a
line between these points best dividing half above and half below is
horizontal.  *The assertion that revision numbers are linearly
correlated to time is a conjecture; I have not verified this
mathematically.*

> You could also include the whole 2.5.x set (at least since git became
> common) for a larger series...

Perhaps, but that was a heavy development period and I want to avoid
lurking variables; otherwise I'd have included 2.4's whole series too.
I know this is a lost cause in 2.6, what with things like devfs or OSS
dropping and ALSR getting merged in at random times....

> 
> [...]
> 
>> My math predicts that 2.6.57 (+39) will be 100M (in approximately 7
>> years if you assume 1 kernel release every 2 months); 2.6.92 (+35) will
>> breech 200M; 2.6.117 (+25) will breech 300M; and 2.6.138 (+21)) will
>> breech 400M.  That should suffice for predictions over the next 20 years
>> based on this crude model.
> 
> I'd trust your curve for, say, 5 minors. Not more. The quadratic term is
> rather hard to justify in any case... linear growth (== new drivers at a
> (roughly) constant rate, a (roughly) constant number of people actively
> working on the kernel with constant productivity, ...) I give you easily.

(ax^2 + bx + c)d/dx == 2ax + b

I didn't eye the curve as quadratic; I eyed it as a gentle curve.  I
took the differences and looked for a trend specifically because I know
a linear growth trend (polynomial degree 1) indicates a quadratic trend
(polynomial degree 2).

As I said, I don't have enough samples.  I only used 16 of the 19
samples I have to generate the function above; I would like upwards of
30 before claiming any useful trend.

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRTFDnws1xW0HCTEFAQLLHA//WxyEu7Tzh/Lt6RAWL3qA1xHHm2E2WWBc
bUCq4ONuXheZ9rdQM0VHdLIdkPNvkFPtBXSugEIPCIMDSjR8+z1U+kv96Od96Gb0
TfSLMGIUnVzdhAHzwTo35vfPrQb3dIVA4j+3dgMHX0e+OEWDeHhHsAWSjgkwqhe4
OQ6SvCZVIxV2nFTJ3MkbNqITVBNmWy4cy16L3H6GiiQl/q3tg71Dochcn83ySNlc
9NCP4igLVlfjThNCK8pJtDoZX887oCFB/npSOSiwKQKciAlMooAgmDRTh55pa7D4
XD+Lilxwp/jFXbtv/9HdoETeN7kZLcVYbGfMosDvwxl5g2smzCLWEv5qvUCs3lDQ
gh4knxGF59Vupou+irI9L+1FC3irJcS92x3ITFQwwTRT3rZ5hVMPIBaxovWN2oVY
U0InH4VhLY+yWADL3BkWEi/pNQ2YxiXw5VdSDHMitBHEczOyE2emAkVTBvuGl/wP
v2iDVHJU9A1IMsN0EG+C+hpOR4kqIU/WT/aLAC3JwUKb+RTFadgRdYs6/ca++2ks
iFwA55Dd20iQ3p/uCwXMvugWAGwo+tPXHIBJy3RSnPkL4r/CaA1RwC7Gn/EDqgeA
w2jO6hYcKKX91MEFpfvqUjNx5Oq4gHf/20rLQi7kMW12LVkVDmKZe840KETSt3Wb
O8MAMIs894s=
=6G+v
-----END PGP SIGNATURE-----
