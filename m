Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268652AbUIAFfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268652AbUIAFfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 01:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268657AbUIAFfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 01:35:23 -0400
Received: from relay.pair.com ([209.68.1.20]:44553 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268652AbUIAFfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 01:35:15 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <41355F88.2080801@kegel.com>
Date: Tue, 31 Aug 2004 22:35:04 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: geert@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Getting kernel.org kernel to build for m68k?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,
I see from
http://linux-m68k-cvs.apia.dhs.org/~geert/linux-m68k-2.6.x-merging/
that you're merging patches back into Linus' kernel.  Great!

I noticed today that Linus's m68k kernel can't be built (at least with gcc-3.4.1).

The first problem I ran into,
   CC      arch/m68k/kernel/asm-offsets.s
   In file included from include/linux/spinlock.h:12,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/m68k/kernel/asm-offsets.c:12:
   include/linux/thread_info.h:30: error: parse error before '{' token
is solved already in the m68k tree.
(In particular,
the #ifndef __HAVE_THREAD_FUNCTIONS ... #endif in
http://linux-m68k-cvs.apia.dhs.org/c/cvsweb/linux/include/linux/thread_info.h?rev=1.5;content-type=text%2Fplain
probably solves it.)
There are other problems after that.

Any chance you could spend a bit of time sending Linus enough
patches for his kernel to build for m68k, if not run?
It would be helpful to my crosstool project (I'm adding a
"can this toolchain build the kernel" test, and it's a lot
easier if I can count on the kernel.org tree at least building).

Thanks,
Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
