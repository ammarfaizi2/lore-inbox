Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUDGL3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 07:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUDGL3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 07:29:17 -0400
Received: from zero.aec.at ([193.170.194.10]:28170 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263057AbUDGL3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 07:29:16 -0400
To: Bryan Koschmann - GKT <gktnews@gktech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: amd64 questions
References: <1I8up-46J-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 07 Apr 2004 13:29:07 +0200
In-Reply-To: <1I8up-46J-3@gated-at.bofh.it> (Bryan Koschmann's message of
 "Wed, 07 Apr 2004 01:50:06 +0200")
Message-ID: <m3zn9o58n0.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Koschmann - GKT <gktnews@gktech.net> writes:

> I've spent the past week trying to find a full answer on amd64 support.
> Maybe I'm just not understanding it, but all I can find are debian howtos.

Debian seems to have some unique problems in the way they handle AMD64
compared to other distributions. I would not trust what you read
there, they make it much more complicated than it really is. The right
forum would have been discuss@x86-64.org

> I'm running 2.4.25 on slack 9.1. I was assuming I could simply recompile
> the kernel for the amd64, and then whatever other bits of software I
> wanted specifically to run at 64bit, but it's not seeming that way.

It's that way. You just need a 64bit capable cross compiler to compile
the kernel, which is not that difficult to build from sources. You can also
find binaries for that at 
ftp://ftp.suse.com/pub/suse/x86_64/supplementary/CrossTools/8.1-i386/
(usable with rpm2cpio on non RPM distributions). Then you can
cross compile the kernel in the normal way with 
make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-

A few programs (namely iptables and ipsec tools) need to be used
as 64bit programs because the 32bit emulation doesn't work for them.
ipchains works though.

> Should 2.4.25 be able to run 64bit, or are is it more of an all or nothing
> type thing?

2.4.25 supports 64bit just fine.

-Andi

