Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266016AbRGSTl3>; Thu, 19 Jul 2001 15:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265933AbRGSTlS>; Thu, 19 Jul 2001 15:41:18 -0400
Received: from [209.250.58.142] ([209.250.58.142]:51974 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S266006AbRGSTlF>; Thu, 19 Jul 2001 15:41:05 -0400
Date: Thu, 19 Jul 2001 14:39:13 -0500
From: Steven Walter <srwalter@yahoo.com>
To: "Ryan C. Bonham" <Ryan@srfarms.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan Thunder K7 & 2 1.2Ghz Athlon MPs
Message-ID: <20010719143913.A9547@hapablap.dyn.dhs.org>
In-Reply-To: <19AB8F9FA07FB0409732402B4817D75A0389FF@FILESERVER.SRF.srfarms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <19AB8F9FA07FB0409732402B4817D75A0389FF@FILESERVER.SRF.srfarms.com>; from Ryan@srfarms.com on Thu, Jul 19, 2001 at 03:24:09PM -0400
X-Uptime: 2:18pm  up  2:10,  0 users,  load average: 1.08, 1.08, 1.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 19, 2001 at 03:24:09PM -0400, Ryan C. Bonham wrote:
> I get the following messages, I will paste dmesg.log at the bottom if you
> want to see it..
> mtrr: your CPUs had inconsistent fixed MTRR settings
> mtrr: probably your BIOS does not setup all CPUs
> 
>From what i gather that message can just be ignored, it stems from bios
> vendors not following specs, and Linux is just making corrections.. Am I
> right?

The bios really isn't doing anything wrong, more like its not doing
anything.  It probably just isn't setting the second CPU.  Linux, as far
as I know, will set up the second CPU for you, and it only letting you
know what's going on.

> agpgart: Maximum main memory to use for agp memory: 816M
> agpgart: Unsupported AMD chipset (device id: 700c), you might want to try
> agp_try_unsupported=1.
> agpgart: no supported devices found.
> 
> Ok, I understand the AMD chipset on this board is new, my question here is,
> how do I turn on agp_try_unsupported..  Patch the kernel?

Even easier; agp_try_unsupported is a kernel command line parameter.  If
you're using LILO, boot with the line "linux agp_try_unsupported=1" or
the like, or put "append="agp_try_unsupported=1"" in your lilo.conf
file.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
