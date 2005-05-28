Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVE1Rv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVE1Rv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 13:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVE1RvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 13:51:25 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:41995 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261172AbVE1RvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 13:51:04 -0400
Date: Sat, 28 May 2005 19:46:41 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "John W. M. Stevens" <john@betelgeuse.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel Crash - Machine Exception Interpretation?
Message-ID: <20050528174641.GI18600@alpha.home.local>
References: <20050528143746.GA3612@morningstar.betelgeuse.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050528143746.GA3612@morningstar.betelgeuse.us>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 28, 2005 at 08:37:46AM -0600, John W. M. Stevens wrote:
> Summary: Kernel crashes aprox. every 36 hours.
> 
> Description: Machine locks up, or crashes way to often.  The latest crash
> 	produced log output that hinted at the problem, but I don't know
> 	how to interpret what I'm seeing.

Often symptoms of flaky hardware, insufficiently cooled CPU or defective RAM.

> 	The crashes can be quite severe.  The previous one wiped out my /usr
> 	partition.

Disk corruption may be caused by one of the troubles above. However, you
should not have lost everything, usually, playing long with fsck allows
you to retrieve most of your data.

 
> 	May 27 21:42:06 morningstar kernel: CPU 1: Machine Check Exception: 0000000000000004
> 	May 27 21:42:07 morningstar kernel: Bank 0: e200000000000175
> 	May 27 21:42:07 morningstar kernel: Bank 2: b60020000000011a at 000000000bf16280May 27 21:42:07 morningstar kernel: Kernel panic: CPU context corrupt

This is the most important part. You must pass to to "parsemce" which will
tell you what's wrong. You can find it on codemonkey.org.uk (google will
direct you to the right site).

 
> 	processor       : 0
> 	vendor_id       : AuthenticAMD
> 	cpu family      : 6
> 	model           : 6
> 	model name      : AMD Athlon(tm) MP 2000+
(...)

> 	processor       : 1
> 	vendor_id       : AuthenticAMD
> 	cpu family      : 6
> 	model           : 6
> 	model name      : AMD Athlon(tm) Processor

You have a dual-athlon MB, I too have one (ASUS A7M266D), and encountered
stability problems during last summer because the temperature was getting
high in the case when I slowed down my fans to keep them quiet. The RAM
can get very hot too. Perhaps one of your fans does not spin fast enough
because of dust ? You may have a problem with the power supply too, since
those CPUs suck a lot of power. Anyway, your report clearly is a problem
with hardware, I would advice to make a lot of backups.

Regards,
Willy

