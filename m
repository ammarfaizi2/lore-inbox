Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVGHEss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVGHEss (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 00:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVGHEsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 00:48:47 -0400
Received: from bay20-f22.bay20.hotmail.com ([64.4.54.111]:65112 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262614AbVGHEsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 00:48:40 -0400
Message-ID: <BAY20-F22F887E749670F2B2BB7DDC4DB0@phx.gbl>
X-Originating-IP: [65.64.155.98]
X-Originating-Email: [jonschindler@hotmail.com]
In-Reply-To: <200507072104.26034.rjw@sisk.pl>
From: "Jon Schindler" <jonschindler@hotmail.com>
To: rjw@sisk.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops with dual core athlon 64 (quick question)
Date: Fri, 08 Jul 2005 00:48:31 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 08 Jul 2005 04:48:32.0328 (UTC) FILETIME=[4ABF1C80:01C58378]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael,

Thanks a lot for the quick reply and patch.  I have tested the patch tonight 
and things are looking good so far.  For the first time since I upgraded 
from my single core athlon 64 3500+ my cpu fan isn't a tornado.  Also, my 
CPU frequency isn't pegged at full throttle 24/7 (it's dropping down to 1000 
Mhz at idle as it should).  This is a good sign that your patch did fix the 
cpufreq driver in addition to the oopses I've been experiencing.

Thanks again for the patch, I'll let you know if the oopses reappear, but so 
far things are looking very good.

Jon

>From: "Rafael J. Wysocki" <rjw@sisk.pl>
>To: "Jon Schindler" <jonschindler@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Kernel Oops with dual core athlon 64 (quick question)
>Date: Thu, 7 Jul 2005 21:04:25 +0200
>
>Hi,
>
>On Thursday, 7 of July 2005 18:41, Jon Schindler wrote:
> > Hi Rafael,
> > I looked at the patch and noticed that it's changing a file inside
> > linux-2.6.12-rc6/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
> > So, basically, it's modifying the powernow driver in the i386 arch
> > directory, but shouldn't that file be in "arch/x86_64/....", or am I 
>missing
> > something?
>
>Yes. :-)
>
> > I'm compiling the kernel for x86_64, so will my 64 bit kernel
> > use this file even though it's in the i386 directory?
>
>Yes, it will.  x86-64 uses some sources from i386 directly, including
>cpufreq (they would be identical anyway).
>
>Greets,
>Rafael
>
>
>--
>- Would you tell me, please, which way I ought to go from here?
>- That depends a good deal on where you want to get to.
>		-- Lewis Carroll "Alice's Adventures in Wonderland"
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


