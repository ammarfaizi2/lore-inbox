Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbUKBPK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbUKBPK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUKBN66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:58:58 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:15555 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261570AbUKBMta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:49:30 -0500
Message-ID: <41878249.7040104@kolivas.org>
Date: Tue, 02 Nov 2004 23:49:13 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove interactive credit
References: <418707CD.1080903@kolivas.org> <20041102123746.GB15290@elte.hu> <41878057.9000302@kolivas.org> <20041102124648.GF15290@elte.hu>
In-Reply-To: <20041102124648.GF15290@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB74312968A5DC2F463ED192F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB74312968A5DC2F463ED192F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>>>remove interactive credit
>>>
>>>we could try this in -mm, but it obviously needs alot of testing first. 
>>>Do you have any particular workload in mind where the fairness win due
>>>to this revert would/should be significant?
>>
>>Since I created this variable in the first place I can say with quite
>>some certainty that the size of the advantage is miniscule. Whereas
>>clearly the design introduces special case mistreatment of only one
>>type of task. It's an addition to the interactivity code I've often
>>looked at and regretted doing.
> 
> 
> yeah, i know, it was the only piece of code from your earlier -Oint
> scheduler-fixup series i almost didnt ack. But now it's in and testing
> needs to cross at least one stable kernel boundary before it can be
> taken out again. (unless a patch is an obvious or important fix.)

I've been extensively testing it at this end and recommend giving it a 
good -mm run. I'm reasonably sure it's related to some of the 
disproportionate cpu usage reports we've seen with some of those bash 
script examples (can't recall the details now so I'll need to chase them 
up). If I didn't suspect it was an issue I wouldn't be keen to undo 
something either.

Con

--------------enigB74312968A5DC2F463ED192F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBh4JJZUg7+tp6mRURAhBpAJ0T0pml3/MmpJsRKNzgyzraBk18jgCfTJ36
0Ott42ivCzOgg80E024ztSk=
=Eoc7
-----END PGP SIGNATURE-----

--------------enigB74312968A5DC2F463ED192F--
