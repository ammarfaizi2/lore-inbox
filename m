Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTLIWwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 17:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTLIWwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 17:52:33 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:4998 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S263014AbTLIWwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 17:52:31 -0500
Date: Tue, 9 Dec 2003 23:47:18 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
cc: <linux-atm-general@lists.sourceforge.net>
Subject: Re: 2.4.22 with CONFIG_M686: networking broken
Message-ID: <Pine.LNX.4.30.0312092344360.17719-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

... the same bug is still present in kernel version 2.4.23.
As I know meanwhile, it only occurs on ATM/LANE network connections.

For more details about the problem, see the threads on

"2.4.22 with CONFIG_M686: networking broken"
http://testing.lkml.org/slashdot.php?mid=330251

and

"[2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT"
http://testing.lkml.org/slashdot.php?mid=331650

Regards,
               Peter Daum

In article <Pine.LNX.4.30.0309031227100.10173-100000@swamp.bayern.net> I
wrote:

> It seems, like kernel version 2.4.22 introduced some weird bug,
> that causes all kinds of network malfunctions, when the kernel is
> compiled with "CONFIG_M686".

> I am sorry, that I can't come up with a clearer error
> description, but the whole issue is pretty mysterious: there is
> no actual error occurring, but some networking functionality is so
> slow that it's for all practical purposes useless. The best test
> cases I could find are:

> - getting a file via ftp (e.g. wget ftp://...): Data rate over a
>   normally fast network connection is ~ 200 bytes /second, the
>   connection soon dies with a timeout

> - writing to a SMB share (provided, that samba is running on the
>   machine) is awfully slow and eventually aborted (Windows
>   complains about "network congestion")
>   reading via SMB works as usual ...

> I upgraded the kernel on a bunch of machines - on most of them, I
> had to immediately go back to the previous kernel because there
> were obvious problems; some machines, however, worked perfectly
> normal with the new kernel.

> I tried lots of different options until I eventually found out,
> that the single setting that makes all the difference is the
> processor type: Independently of any other settings, all kernels
> with "CONFIG_M686" exhibit these problems; when I change this to
> "CONFIG_MPENTIUM4" and recompile, everything seems to work.


