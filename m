Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUB2KLb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 05:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUB2KLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 05:11:31 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:46859 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262029AbUB2KL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 05:11:28 -0500
Date: Sun, 29 Feb 2004 11:11:39 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org, greg@kroah.com,
       jamagallon@able.es, PrakashKC@gmx.de, akpm@osdl.org
Subject: Re: 2.6.3-mm4
Message-Id: <20040229111139.25d69d8d.khali@linux-fr.org>
In-Reply-To: <40419A15.8030108@matchmail.com>
References: <20040225185536.57b56716.akpm@osdl.org>
	<403E82D8.3030209@gmx.de>
	<20040225185536.57b56716.akpm@osdl.org>
	<20040227001115.GA2627@werewolf.able.es>
	<20040227004602.GB15075@kroah.com>
	<1077870909.403f013dd04b6@imp.gcu.info>
	<403F898A.2000801@matchmail.com>
	<20040227205922.6405eff7.khali@linux-fr.org>
	<40419A15.8030108@matchmail.com>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Working from the premise that there is a current (old-style with
> mostly chip dependent code), libsensors has 2.4 /proc support, and
> each specific release supports one of 2.6.[0123]...

Correct, that's mostly that.

> I'm glad I'm not the maintainer of libsensors for a distribution. 
> Since you have effectively pushed the compatibility work to them. 
> Just think of angry customer complaints about this. :(

Again, this is a temporary situation. I'm struggling for a better
future, at the cost of a slightly chaotic present, admittedly.

That said, I think that most packaging systems support that kind of
dependency. Since we clearly advertise the correct combinations of
lm_sensors and Linux kernel, they should be able to handle it quite
nicely (although I admit it has to represent some work for them).

The compatibility problems brought by libsensors are not new. From the
very beginning, each new version of lm_sensors had kernel modules,
libsensors and sensors program that mostly only worked well together. It
wasn't to the point of what we are experiencing today, of course,
because things were mostly (but not always) backward compatible. Still,
supporting each and every new driver or "kind" of chip would require
upgrading to new libsensors and sensors program. This is precisely what
I want to avoid with my proposal.

> Since there is going to be an effective libsensors-new library with
> chip independent code, I suggest you put the compat code into the old
> library.

Note that there is no effective plan for such a library as of today. I
am "simply" defining an interface such that writing such a library will
be possible. I don't think I have the skills to write it at the moment,
but I have no doubt that people will do (I'm in particular thinking to
the gkrellm folks who neved liked the old library and wouldn't use it at
all, at the cost of frequent compatibility issues). That said, if nobody
seems to go on working on it within a reasonable amount of time, it's
likely that I will learn what I need to know to do it myself, since I'm
so interested in seeing it exist.

I do not plan to spend time to provide compatibility with early 2.6
kernels. First, because it would bloat the current libsensors even more.
Second, because I believe that these kernels will stop being used within
a few months or even weeks.

Distributions or individuals running 2.6 kernels these days know pretty
well that things are not fully stabilized yet. Granted, the sensors area
seems to be the more unstable realm of them all at the moment. But I
just don't think that people need to have, say, a 2.6.1 and a 2.6.3
kernel running perfectly on their system. We never had any request in
that direction so far. What they most likely want is to have a 2.4 and a
2.6 kernel working, and we do provide this compatibility.

If you really believe that we have to support all early 2.6 kernel
releases and are able to write a not-too-bloated patch for libsensors
that does this, we'll consider applying it. But it's unlikely that any
of us will want to spend time on such a patch.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
