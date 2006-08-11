Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWHKSZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWHKSZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 14:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWHKSZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 14:25:31 -0400
Received: from rtr.ca ([64.26.128.89]:35012 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932129AbWHKSZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 14:25:31 -0400
Message-ID: <44DCCB96.5080801@rtr.ca>
Date: Fri, 11 Aug 2006 14:25:26 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: cpufreq stops working after a while
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of my notebooks (Dell Latitude X1) has a 1.1GHz Pentium-M ULV processor.
This chip can change CPU speeds from 600 -> 800 -> 1100 Mhz.

I use speedstep-centrino with it, and after boot all is usually okay.
But after a few hours of operation, it stops shifting to the highest frequency
even under continuous 100% load (or not).  Eventually it gets stuck at 600Mhz
and stays there until I reboot.

Sometimes rebooting doesn't even restore it.

/sys/devices/system/cpu/cpu0/cpufreq is all very normal looking,
showing the available frequencies and other info.  All of the attribs
there look fine, except for "scaling_max_freq", which is what seems
to gradually get set smaller.  For instance, right now it is set to 800000,
and it won't let me change it (echo 11000000 > scaling_max_freq has no effect.

WHY?  And how can I fix it?

