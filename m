Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVKRPWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVKRPWc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVKRPWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:22:32 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:10803 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750834AbVKRPWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:22:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=G+RaW3xVWqn9HtQi1VRSC3UYMItzrfpvYGtdG8RppEirRiqp/TPD7MathOaW2na7OHfDRgE6kxS+438CUOtqx/dmJbooEgMi3xgVyY1+ppqeAJzu9asAkc/MR808SJjBLxAyKLV2WDSlEbMWtI09s75aEnx/ga5FVAGUspeFfG0=
Message-ID: <437DF0A8.6060409@gmail.com>
Date: Fri, 18 Nov 2005 16:18:00 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Daniel Walker <dwalker@mvista.com>, john cooper <john.cooper@timesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] Softlockup detected with linux-2.6.14-rt6
References: <4378B48E.6010006@gmail.com> <20051115153257.GA9727@elte.hu> <437A14FB.8050206@timesys.com> <20051115200010.GA13802@elte.hu> <Pine.LNX.4.64.0511151206000.29907@dhcp153.mvista.com> <437A7A58.8050209@gmail.com>
In-Reply-To: <437A7A58.8050209@gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Luca Falavigna ha scritto:
| Actually I am testing linux-2.6.14-rt13. If this problem come out again,
| I will notify you ASAP.

Unfortunately this soft lockup bug affects version 2.6.14-rt13 too :(
Stack traces are almost the same, except base addresses.

The bug was much harder to track down this time. Kernel detected a soft
lockup bug after about three days of uptime.

I noticed another strange behaviour. When I rebooted the machine
(actually pushing reset button, not CTRL+ALT+CANC or SysRq at all), it
became *very* slow. GRUB took up to five seconds to be fully loaded
(usualy it takes only a fraction of second) and the initial phase of
booting the kernel was about 4 times slower. Even after a power off this
behaviour was still present! Need more coffee?

Regards,
- --
					Luca

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQ33wppK+HIH6ZZ2zAQIYSQgAh7T0/a40F9ImNK4Ut7WvVxdLZn7Hekvn
8xBr2jSm5Vz4Ewiht1kZ+sXvAV98J8oDGBghQK8CVE+LdGnyFxncMH8sIlnOViq1
PAwVXYOI7FQzk0UX0FTfsVcsmGkqZk653HC/VRTfY+7xg0NKzUFTjwZg0pDmhkoC
yKg73Krr2Zx9N4JH5v2y9uFHhn3YC7mPmbO1mSsmF6WIcePLaY3+Um/FGkQZXr3b
ZDwAd8IQmbgiJiyO7sAgc6ydPWxjDzrlPTri7pFHERkJJKxQAan+rKxYdGO7e9C4
57iny6wa2C2sdmn8quL+ZXnmpgB7vNRroDZ1kg5Qm/1SiKjbvC5BqQ==
=RNUt
-----END PGP SIGNATURE-----

