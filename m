Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVEGH7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVEGH7l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 03:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbVEGH7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 03:59:41 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:64395 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262767AbVEGH7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 03:59:38 -0400
Date: Sat, 7 May 2005 03:55:36 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Stefan Smietanowski <stesmi@stesmi.com>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: /proc/cpuinfo format - arch dependent!
In-Reply-To: <427C3D8A.9080600@stesmi.com>
Message-ID: <Pine.GSO.4.33.0505070228400.19035-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2005, I wrote:
>> Hah.  Give me a minute to stop laughing...  I argued the same point almost
>> a decade ago.  Linus decided to be an ass and flat refused to ever export
>> numcpu (or any of the current day derivatives) which brought us to the
>> bullshit of parsing the arch dependant /proc/cpuinfo.
>
>Not to be a pain but how exactly would that interface look today
>in your eyes?
...

That's why I said, "or any of the current day derivatives".

Back when I first brought this up (8 years ago?), it was simple... numcpu
was it.  There weren't any virtual processors or multi-core critters.
CPU affinity, cpumasks, and sysfs weren't even dreams.

Today, things are more complicated... much more complicated.  However,
they've generally already been hashed out and handled in some fashion.
The kernel already knows how many cpus there are, how many are online,
which ones are virtual (at least to the point that the scheduler knows),
etc.  I'm not sure what difference multi-core chips really make as they're
just two+ cpus in the same package -- yes, that means all of them have to
be offline to physically remove the processor, but that's pretty hardcore,
specialized function to begin with.

The issue with detecting HT enabled processors came up shortly after
they became available and /proc/cpuinfo and associated apps were updated
accordingly.

My point is, and has always been, it's much faster and far more efficient
to have a "binary" view of what the kernel has always known than spinning
around in one's chair groking a wad of mostly meaningless ASCII text
engineered to make sense only to the eyeballs of humans.  Most of
/proc fits in this boat... with cpuinfo in the driver's seat.

(I won't launch into my oft repeated ASCII vs. binary /proc flamewar.
 We have 4GHz processors now, so nobody cares about being efficient
 despite about a 10x(+) speedup if the ascii middleman were taken out
 and shot.)

--Ricky


