Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVGGQod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVGGQod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 12:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVGGQnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 12:43:03 -0400
Received: from bay103-dav2.bay103.hotmail.com ([65.54.174.74]:24360 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261329AbVGGQkR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 12:40:17 -0400
Message-ID: <BAY103-DAV217585FF946492DCAC9FFC4D80@phx.gbl>
X-Originating-IP: [65.54.174.200]
X-Originating-Email: [jonschindler@hotmail.com]
From: "Jon Schindler" <jonschindler@hotmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: <linux-kernel@vger.kernel.org>
References: <BAY20-F42FDD187485A266D3988B6C4D80@phx.gbl> <200507071129.38714.rjw@sisk.pl>
Subject: Re: Kernel Oops with dual core athlon 64 (quick question)
Date: Thu, 7 Jul 2005 11:41:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 07 Jul 2005 16:40:10.0717 (UTC) FILETIME=[8A8E78D0:01C58312]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,
I looked at the patch and noticed that it's changing a file inside 
linux-2.6.12-rc6/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
So, basically, it's modifying the powernow driver in the i386 arch 
directory, but shouldn't that file be in "arch/x86_64/....", or am I missing 
something?  I'm compiling the kernel for x86_64, so will my 64 bit kernel 
use this file even though it's in the i386 directory?

Thanks,

Jon

----- Original Message ----- 

From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Jon Schindler" <jonschindler@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, July 07, 2005 4:29 AM
Subject: Re: Kernel Oops with dual core athlon 64


> Hi,
>
> On Thursday, 7 of July 2005 07:58, Jon Schindler wrote:
>> The dmesg is below.  After I get this Oops, I am unable to use my (PS/2)
>> keyboard, and had to ssh to my machine in order to save a copy of dmesg
>> before rebooting the machine.  I've seen a couple of other users of dual
>> core machings having this problem.  The suggestion so far has been to 
>> remove
>> the binary nvidia driver and repoducde the bug.  So, I went ahead and
>> removed the nvidia driver and used the deprecated nv driver that comes 
>> with
>> X11 and I still have this issue.  Does anyone have any ideas what might 
>> be
>> causing this?  Thanks in advance for the help.  I don't know my way 
>> around
>> the kernel, but I do have experience with C and should be able to apply 
>> any
>> SMP patches if you want me to test it
>
> It seems to be a cpufreq issue.  You can try to apply the attached patch 
> from
> Mark Langsdorf.
>
> Greets,
> Rafael
>
>
> -- 
> - Would you tell me, please, which way I ought to go from here?
> - That depends a good deal on where you want to get to.
> -- Lewis Carroll "Alice's Adventures in Wonderland"
> 
