Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272120AbRHVVGx>; Wed, 22 Aug 2001 17:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272119AbRHVVGm>; Wed, 22 Aug 2001 17:06:42 -0400
Received: from [209.202.108.240] ([209.202.108.240]:42256 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S272122AbRHVVGb>; Wed, 22 Aug 2001 17:06:31 -0400
Date: Wed, 22 Aug 2001 17:06:31 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (comments requested) adding finer-grained timing to PPC
  add_timer_randomness()
In-Reply-To: <3B841CC3.E7040002@nortelnetworks.com>
Message-ID: <Pine.LNX.4.33.0108221702300.12521-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Chris Friesen wrote:

> I'd like some comments on the following patch.
>
> This patch is designed to add finer-grained timing (similar to the i386 timing)
> to add_timer_randomness().  The only tricky bit is that the PPC601 doesn't
> support the timebase registers.  Accordingly, I've added a flag to the PPC port
> that is used to keep track of whether or not the processor supports the timebase
> register.
>
> Is there a better way to keep track of this information?  i386 has a struct with
> useful information stored, but it doesn't look like PPC does.
>
> Thanks,
>
> Chris

>From the patch:

--- linux-2.2.19-clean/arch/ppc/kernel/setup.c  Sun Mar 25 11:31:49 2001
+++ linux-2.2.19/arch/ppc/kernel/setup.c        Wed Aug 22 16:34:51 2001
  ...
+extern int have_timebase = 1;
  ...
--- linux-2.2.19-clean/include/asm-ppc/processor.h      Sun Mar 25 11:31:08 2001
+++ linux-2.2.19/include/asm-ppc/processor.h    Wed Aug 22 16:34:51 2001
  ...
+extern int have_timebase;
  ...

Hrmm...

Am I missing something, or should at least one of these not be extern?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>








