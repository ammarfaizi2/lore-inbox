Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315335AbSDXCmL>; Tue, 23 Apr 2002 22:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315361AbSDXCmK>; Tue, 23 Apr 2002 22:42:10 -0400
Received: from boo-mda02.boo.net ([216.200.67.22]:6930 "EHLO boo-mda02.boo.net")
	by vger.kernel.org with ESMTP id <S315335AbSDXCmJ> convert rfc822-to-8bit;
	Tue, 23 Apr 2002 22:42:09 -0400
Message-Id: <3.0.6.32.20020423224811.007ce440@boo.net>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Tue, 23 Apr 2002 22:48:11 -0400
To: linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: Re: [PATCH] page coloring for 2.4.18 kernel
In-Reply-To: <1019598814.1465.254.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:53 PM 4/23/02 -0400, Robert Love wrote:

>On Tue, 2002-04-23 at 17:51, Dieter Nützel wrote:
>
>> Page coloring for 2.4.18+ isn't preempt save?
>> 
>> It gave ~10% speedup for memory intensive apps on my single  1 GHz Athlon II 
>> SlotA (0,18µm, L2 512K) but look the system hard from time to time. Nothing 
>> in the logs.
>> 
>> I've changed the patch for 2.4.19-pre7 + vm3 + latest rml-O(1) + preempt.
>
>Beats me.  Some of the implementations of page colouring I have seen are
>not even SMP-safe.
>
>"Don't do that"

While I haven't tested on an SMP system, the patch should at least be
SMP safe. As for preempt-safe, I noticed in Dieter's previous tests that
the free list had been sufficiently fragmented that there were no high-
order groups of pages left available. Could this cause a problem?

I can't track this list carefully enough to apply and test all the patches
mentioned.

jasonp
