Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267638AbSLSXyQ>; Thu, 19 Dec 2002 18:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbSLSXyQ>; Thu, 19 Dec 2002 18:54:16 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:17024 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267638AbSLSXyP> convert rfc822-to-8bit; Thu, 19 Dec 2002 18:54:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Robert Love <rml@tech9.net>
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
Date: Fri, 20 Dec 2002 11:04:24 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212200850.32886.conman@kolivas.net> <200212201042.48161.conman@kolivas.net> <1040341995.2521.81.camel@phantasy>
In-Reply-To: <1040341995.2521.81.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212201104.28863.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>On Thu, 2002-12-19 at 18:42, Con Kolivas wrote:
>> I guess this explains why my variable timeslice thingy in -ck helps on the
>> desktop. Basically by shortening the timeslice it is masking the effect of
>> the interactivity estimator under load. That is, it is treating the
>> symptoms of having an interactivity estimator rather than tackling the
>> cause.
>
>You would probably get the same effect or better by setting
>prio_bonus_ratio lower (or off).
>
>Setting it lower will also give less priority bonus/penalty and not
>reinsert the tasks so readily into the active array.
>
>Something like the attached patch may help...
>
>	Robert Love

Thanks. That looks fair enough. My only concern is that io_load performance is 
worse with lower prio_bonus_ratio settings and io loads are the most felt.

I was thinking of changing what it varied. I was going to leave the timeslice 
fixed and use it to change the prio_bonus_ratio under load. Although that 
kind of defeats the purpose of having it in the first place since it is 
supposed to decide what is interactive under load?

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+Al6IF6dfvkL3i1gRAo6mAKColJKXyGNaa0dcwot4EvElpHqkawCeORLm
ZSyRVx1w76qWBEgkjbRZWmw=
=ckYA
-----END PGP SIGNATURE-----
