Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264807AbSJaKbq>; Thu, 31 Oct 2002 05:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264813AbSJaKbq>; Thu, 31 Oct 2002 05:31:46 -0500
Received: from mta04bw.bigpond.com ([139.134.6.87]:36079 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S264807AbSJaKbo> convert rfc822-to-8bit; Thu, 31 Oct 2002 05:31:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20pre11aa1
Date: Thu, 31 Oct 2002 21:47:42 +1100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021018145204.GG23930@dualathlon.random> <20021023143515.GE1912@dualathlon.random> <200210260003.06285.harisri@bigpond.com>
In-Reply-To: <200210260003.06285.harisri@bigpond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210312147.42836.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

On Saturday 26 October 2002 00:03, Srihari Vijayaraghavan wrote:
> The resulting kernel is very stable and it does not crash.
>
> Then I tried patches [01]* and the extra patches (20_apm-o1-sched-1,
> 20_rcu-poll-7, 20_sched-o1-fixes-5, 21_o1-A4-aa-1), I couldn't compile
> the kernel.

The current status is:

[0]* - compiles fine - works fine
[01]* - couldn't compile
[012]* - compiles fine - crashes

So I believe either 1* or 2* patches are introducing the issue.

In the mean time I had an opportunity to test -aa on a nice IBM NetVista 
computer, whose configuration is as follows:

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory 
Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics 
Controller] (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 02)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 
02)
01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet 
Controller (rev 01)

I can easily reproduce the same issue on that computer too (of course I am 
using CONFIG_AGP_I810 for agpgart support and CONFIG_DRM_I810 for i810 
display card support).

I think this eliminates the doubt on DRM support of Radeon (or i810 for that 
matter), and the issue appears very specific to agpgart in general.

Anyway I guess we are very close to the problem, if someone helps me to 
compile -aa with [01]* patches I think we can pinpoint the issue I suspect.

Thanks for your help and support.
-- 
Hari
harisri@bigpond.com

