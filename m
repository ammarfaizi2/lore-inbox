Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261823AbTCTTWN>; Thu, 20 Mar 2003 14:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbTCTTWN>; Thu, 20 Mar 2003 14:22:13 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6660 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261823AbTCTTWM>;
	Thu, 20 Mar 2003 14:22:12 -0500
Date: Thu, 20 Mar 2003 20:32:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, ak@suse.de
Subject: Re: share COMPATIBLE_IOCTL()s across architectures
Message-ID: <20030320193212.GA312@elf.ucw.cz>
References: <20030319232157.GA13415@elf.ucw.cz> <20030319.160130.112180221.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319.160130.112180221.davem@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    This patche moves common COMPATIBLE_IOCTLs to
>    include/linux/compat_ioctl.h, enabling pretty nice cleanups:
> 
> Please be careful.  For anything non-trivial there can be major
> differences between compat layers.

I'm trying to be carefull. How common are ioctls that are
COMPATIBLE_IOCTL(foo) on one arch, but not on another? So far I tried
to decide, and mostly decided that one architecture was simply
missing...

> I say this now because eventually I want this compat stuff
> to support multiple-compilations, using some COMPAT_NAME(foo)
> macro scheme and some Makefile hackery.

Well, if I'm a little more carefull, all I will change will be order
of fields in that ioctl32_start table. Should I aim for that?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
