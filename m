Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264806AbTIDJUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbTIDJUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:20:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59344 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264806AbTIDJT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:19:59 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Peter Daum <gator@cs.tu-berlin.de>
Subject: Re: 2.4.22 with CONFIG_M686: networking broken
Date: Thu, 4 Sep 2003 11:20:57 +0200
User-Agent: KMail/1.5
References: <Pine.LNX.4.30.0309031227100.10173-100000@swamp.bayern.net>
In-Reply-To: <Pine.LNX.4.30.0309031227100.10173-100000@swamp.bayern.net>
Cc: peter_daum@t-online.de (Peter Daum), <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309041120.57233.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


AFAIR local APIC is enabled by default for CONFIG_M686
and it is not for CONFIG_MPENTIUM4.

If you are using local APIC please try with "noapic" boot option
or recompile kernel without local APIC support.

This is just a guess...

--bartlomiej

On Wednesday 03 of September 2003 13:08, Peter Daum wrote:
> Hi,
>
> It seems, like kernel version 2.4.22 introduced some weird bug,
> that causes all kinds of network malfunctions, when the kernel is
> compiled with "CONFIG_M686".
>
> I am sorry, that I can't come up with a clearer error
> description, but the whole issue is pretty mysterious: there is
> no actual error occurring, but some networking functionality is so
> slow that it's for all practical purposes useless. The best test
> cases I could find are:
>
> - getting a file via ftp (e.g. wget ftp://...): Data rate over a
>   normally fast network connection is ~ 200 bytes /second, the
>   connection soon dies with a timeout
>
> - writing to a SMB share (provided, that samba is running on the
>   machine) is awfully slow and eventually aborted (Windows
>   complains about "network congestion")
>   reading via SMB works as usual ...
>
> I upgraded the kernel on a bunch of machines - on most of them, I
> had to immediately go back to the previous kernel because there
> were obvious problems; some machines, however, worked perfectly
> normal with the new kernel.
>
> I tried lots of different options until I eventually found out,
> that the single setting that makes all the difference is the
> processor type: Independently of any other settings, all kernels
> with "CONFIG_M686" exhibit these problems; when I change this to
> "CONFIG_MPENTIUM4" and recompile, everything seems to work.
>
> (By the way: the affected machines have "Pentium Pro" or "Pentium
> II" processors - is it safe to run a kernel compiled for "Pentium
> IV" on such boxes?)
>
> Regards,
>                  Peter Daum

