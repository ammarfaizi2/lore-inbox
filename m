Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSKATI3>; Fri, 1 Nov 2002 14:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265710AbSKATI3>; Fri, 1 Nov 2002 14:08:29 -0500
Received: from [198.92.195.114] ([198.92.195.114]:29701 "EHLO meetpoint.home")
	by vger.kernel.org with ESMTP id <S265708AbSKATI1>;
	Fri, 1 Nov 2002 14:08:27 -0500
Date: Fri, 1 Nov 2002 14:14:59 -0500 (EST)
From: Ken Ryan <newsryan@leesburg-geeks.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5] October 30, 2002
Message-ID: <Pine.LNX.4.21.0211011405370.2728-100000@meetpoint.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Given that, "scrubbing" RAM seems to be somewhat useless on a
>running system. The next write to the affected area will fix the
>ECC bits, that't what is supposed to clear up the condition. 

If a region of RAM isn't written to it won't help, and may accumulate
additional errors.  Kernel code, for instance, can then rot
away.  Scrubbing guarantees that all locations in memory get rewritten
periodically, so correctable errors are removed.

I first saw this when I was brought in to help on a design for a
spacecraft.  Even rad-hard devices (these weren't) will flip a bit in a
matter of hours due to background radiation.  Non-hardened memories can
get errors within minutes.  Scrubbing assured the system would only notice
once every few years (when too many bits get flipped in a word during the
scrub interval).

		Ken Ryan



