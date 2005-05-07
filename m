Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVEGDmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVEGDmG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 23:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVEGDmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 23:42:05 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:46474 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262651AbVEGDlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 23:41:52 -0400
Date: Fri, 6 May 2005 23:37:51 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Nico Schottelius <nico-kernel@schottelius.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: /proc/cpuinfo format - arch dependent!
In-Reply-To: <20050419121530.GB23282@schottelius.org>
Message-ID: <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Nico Schottelius wrote:
>When I wrote schwanz3(*) for fun, I noticed /proc/cpuinfo
>varies very much on different architectures.

Yep, and it has been this way since the begining of time.

>So that one at least can count the cpus on every system the same way.

Hah.  Give me a minute to stop laughing...  I argued the same point almost
a decade ago.  Linus decided to be an ass and flat refused to ever export
numcpu (or any of the current day derivatives) which brought us to the
bullshit of parsing the arch dependant /proc/cpuinfo.

Short of a kernel module to export the kernel variables, that's the only
damned way to find the number of cpus in a Linux system.  I was bitched at
by other Distributed.net developers years ago for adding this sort of code
to count up the cpus under linux -- at the time, libc/glibc's sysconf()
didn't support getting cpu info under linux.  Today, glibc's sysconf()
parses /proc/cpuinfo.

>If so, who would the one I should contact and who would accept / verify
>a patch doing that?

Linus has already spoken.  Don't waste your time. (unless he's willing to
rethink this whole stupidity.)

Beyond counting cpus, each arch is reporting very different things, so
combining them into one general format really doesn't make sense.  The
notion of putting all that info in sysfs space isn't bad except it takes
up a lot more memory.

--Ricky


