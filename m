Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUCCMtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 07:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUCCMsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 07:48:30 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:40124 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262483AbUCCMoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 07:44:14 -0500
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl>
	<200402292130.55743.mmazur@kernel.pl>
	<c1tk26$c1o$1@terminus.zytor.com>
	<200402292221.41977.mmazur@kernel.pl> <yw1xn0711sgw.fsf@kth.se>
	<40434BD7.9060301@nortelnetworks.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 01 Mar 2004 19:10:31 +0100
In-Reply-To: <40434BD7.9060301@nortelnetworks.com> (Chris Friesen's message
 of "Mon, 01 Mar 2004 09:42:31 -0500")
Message-ID: <m37jy4cuaw.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> writes:

> For current kernels, the "official" method is to have cleaned up
> copies of the kernel headers shipped with glibc and placed in
> /usr/include/linux and /usr/include/asm.

Not sure about it being "official".
It may make sense if it's a distribution - many users don't install
kernel sources. Still, from a technical point of view, it should be
a straight copy of kernel includes - we don't want to maintain two
separate sets, do we?

>  The "real" headers will
> often work, but not always,

Then they should be fixed.
I.e. parts for internal kernel use should be wrapped with #ifdef __KERNEL__.
Personally I consider every kernel header which prevents successful
user space compilation buggy.

> To complicate things, if you add new stuff to the kernel (new ioctl
> commands, etc.) then your app needs to either link against the "real"
> headers, or else duplicate the definitions.
>
> Its kind of a mess.

Precisely. This is why we need just one header set.

> In an ideal world there would be clean "userspace" headers shipped
> with the kernel, and the kernel would then use those headers plus the
> kernel-only stuff.

Not sure about it. How is it different from clean "kernel" headers
shipped (obviously) with the kernel?


The "non-problem" here is, IMHO, that the cleaning of kernel headers
is quite trivial, and thus nobody is interested :-)
-- 
Krzysztof Halasa, B*FH
