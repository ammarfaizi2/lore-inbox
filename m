Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWHPSny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWHPSny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWHPSny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:43:54 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48257 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750744AbWHPSnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:43:53 -0400
Subject: Re: How to avoid serial port buffer overruns?
From: Lee Revell <rlrevell@joe-job.com>
To: Raphael Hertzog <hertzog@debian.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060816104559.GF4325@ouaza.com>
References: <20060816104559.GF4325@ouaza.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 14:44:28 -0400
Message-Id: <1155753868.3397.41.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 12:45 +0200, Raphael Hertzog wrote:
> (Please CC me when replying)
> 
> Hello,
> 
> While using Linux on low-end (semi-embedded) hardware (386 SX 40Mhz, 8Mb
> RAM), I discovered that Linux on that machine would suffer from serial
> port buffer overruns quite easily if I use a baudrate high enough (I start
> loosing bytes at >19200 bauds and I would like to make it reliable up to 
> 115 kbauds). I check if overruns are happening with
> /proc/tty/driver/serial ("oe" field).
> 
> Back when I was using the 2.4 kernel, I reduced dramatically the frequency
> of overruns by using the "low latency" and "preemptible kernel" patch [1]. But
> it still happened sometimes at 115 kbauds if the system was a bit loaded
> (with disk I/O for example).
> 
> Now I switched to stock 2.6 and while the stock kernel improved in
> responsiveness, it still isn't enough by default (even with
> CONFIG_PREEMPT=y and CONFIG_HZ=1000). So I wanted to try the "rt" patch of
> Ingo Molnar and Thomas Gleixner, but the patched kernel doesn't boot (see
> bug report in a separate mail on this list).

Does the serial performance seem to have regressed from 2.4 to 2.6?  I
am chasing a similar issue with a serial MIDI card (supported by the bog
standard 8250 serial driver) that drops notes under 2.6 but works with
2.4.  I don't have details yet, but it sounds like a similar problem.

Lee

