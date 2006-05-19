Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWESRZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWESRZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWESRZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:25:48 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:63722 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751407AbWESRZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:25:47 -0400
Message-ID: <446DFE83.1030803@comcast.net>
Date: Fri, 19 May 2006 13:21:07 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stealing ur megahurts (no, really)
References: <446D61EE.4010900@comcast.net> <20060519101006.GL8304@mea-ext.zmailer.org>
In-Reply-To: <20060519101006.GL8304@mea-ext.zmailer.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Matti Aarnio wrote:
> On Fri, May 19, 2006 at 02:13:02AM -0400, John Richard Moser wrote:
> ...
>> On Linux we have mem= to toy with memory, which I personally HAVE used
>> to evaluate how various distributions and releases of GNOME operate
>> under memory pressure.  This is a lot more convenient than pulling chips
>> and trying to find the right combination.  This option was, apparently,
>> designed for situations where actual system memory capacity is
>> mis-detected (mandrake 7.2 and its insistence that a 256M memory stick
>> is 255M....); but is very useful in this application too.
>>
>> This brings the idea of a cpumhz= parameter to adjust CPU clock rate.
>> Obviously we can't do this directly, as convenient as this would be; but
>> the idea warrants some thought, and some thought I gave it.  What I came
>> up with was simple:  Adjust time slice length and place a delay between
>> time slices so they're evenly spaced.
> ...
>> Questions?  Comments?  Particular ideas on what would happen?
> 
> Modern machines have ability to be "speed controlled" - Perhaps
> they can cut their speed by 1/3 or 1/2, but run slower anyway
> in the name of energy conservation.
> 

Not fine grained enough.  1.8GHz desktop athlon 64 can run at 600MHz or
1.8GHz.  A laptop CPU may run at 2.0GHz, 1.4GHz, 600MHz, and 400MHz.

> 
> Another approach (not thinking on multiprocessor systems now)
> is to somehow gobble up system performance into some "hoarder"
> (highest scheduling priority, eats up 90% of time slices doing
> excellent waste of CPU resources..)

Possible, but could possibly create other issues.

> 
> Combine that with internal timer ticking at 1000 or 1024 Hz, and
> you do get fairly good approximation of a machine running at 1/10
> of its real speed.
> 
> Kernel IO tasks might skew statistics a bit, but that is another story.
> 

Yeah, also a thought.  With my approach you still had interrupts to
account for et al, since on a slow system we should still have <10uS
response time there.

> 
> In multiprocessor systems similar hoarders do work combined with
> CPU Affinity - one hoarder for each processor.
> 
> /Matti Aarnio
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRG3+gQs1xW0HCTEFAQKK0g/+OPCuhqnT+CC0hhcu3fEAcrW9KlAi1/P5
W1zkx1R3zxIsnDmByNigcRSRKdDPQw/qczWtyiQFT3oAr1P2wrYJhv7IsAc1UQ5n
v7xbQt9lXVIZMolpkoctP8Xdv2oINnHjQFbvKPyNINvigff7Ow5E9ADsi7igbfjG
NmHVWe6a8DhEs9SP1Q6HLkHGvaNSS8S7KXGgT2UlwWtx4AlQL7OLq8nhIgHDWtZq
ltw9NDDgLjG2CTeEW3TNMgDZ2QOE1nGRsk44b4En5+iGXW7d8cLa9HFkeDA6Skpz
6wf3R8XRRpxD9dKB7n4ex6Qq4YK45z4xSvHRsLKQTnxh9UMmeZpCaTjrGm+0abak
CLJXVmzvj20f3wB47J9kSOphdBAX5hQSso1d9V+YWh7WQ9Kkp0LSXyOWdZOAFzCX
Hlgxv9djmNic85IOdnvd++zKf/EeqHBz2/Mk6Fpb5+Sh6YfYrcHnqlFswCn5guR8
GxBXYR1toCT3eeDhbVJXD0oqgLSLh7SMwkDQhERj2nHTiBfmtUDO8er9NqZl6Yf/
AH3/HibLFYYNIAkNGsCxVJ8exoA/sz283kwtYVgG+qJzoMGQaqcBqLeIwd7mp0XX
CJYjENB3uGe6RoWUNHPYoAG68G7WgI9L9U2DRokXkAldX1Fc+u7Ed7GhWrgbisqK
sEDXdtnkMbg=
=FcTe
-----END PGP SIGNATURE-----
