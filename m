Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269277AbUJWAGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269277AbUJWAGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269252AbUJWAEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:04:35 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:58777 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269277AbUJWAD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:03:57 -0400
Message-ID: <41799FE0.1020403@kolivas.org>
Date: Sat, 23 Oct 2004 10:03:44 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alastair Stevens <alastair@altruxsolutions.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-ck1: swap mayhem under UT2004
References: <200410222346.32823.alastair@altruxsolutions.co.uk>
In-Reply-To: <200410222346.32823.alastair@altruxsolutions.co.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig41CDF542A8BAEE16608479DE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41CDF542A8BAEE16608479DE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alastair Stevens wrote:
> Con and others: I've been running 2.6.9-ck1 for a couple of days, and seem 
> to have hit on a major swapping issue....
> 
> My machine is a UP Athlon 2500+ with 512MB, and everything hums along 
> nicely under normal desktop usage.  But when launching UT2004, it just 
> crawls and jerks like hell.  At one point, it appeared to have frozen 
> completely, but I managed to switch to a text console to see what was 
> happening, and basically I'd hit a swap frenzy: kswapd was sucking 50% of 
> the CPU, fighting with the UT2004 process.
> 
> My RAM appeared to be almost "full", with no cache/buffers, but only a few 
> hundred K of swap was actually being used, and this wasn't changing.   
> The kswapd frenzy carried on for at least a couple of minutes; then 
> suddenly everything went smooth again and the game played perfectly from 
> then on.
> 
> This is definitely new behaviour; I've run every recent 2.6 kernel, with 
> and without the staircase scheduler patch (but not the full -ck), and 
> never had any problems before.  Yes, I'm running the dratted Nvidia 
> driver, but that's not the issue as it's been loaded with every other 
> kernel.  Switching back to 2.6.9-rc3 makes everything behave perfectly 
> again....
> 
> Any ideas?  Any more info required?

I've seen reports of this happening since 2.6.9 _even on mainline_. 
Something seems very sick with kswapd where it consumes massive amounts 
of cpu. Can you reproduce without any -ck patches? Others have already 
done so, but it seems to happen earlier with -ck.

Con

--------------enig41CDF542A8BAEE16608479DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBeZ/gZUg7+tp6mRURAhFCAJ9kQpWiMW9nJhZCltecYg5pOekwAACeL7Z0
T13ZVijDkBUkueOUd5+yVik=
=FPtR
-----END PGP SIGNATURE-----

--------------enig41CDF542A8BAEE16608479DE--
