Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbSJOMvM>; Tue, 15 Oct 2002 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbSJOMvM>; Tue, 15 Oct 2002 08:51:12 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:4556 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S262617AbSJOMvL> convert rfc822-to-8bit; Tue, 15 Oct 2002 08:51:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20-pre10aa1 oops report (was Re: Linux-2.4.20-pre8-aa2 oops report. [solved])
Date: Tue, 15 Oct 2002 23:05:32 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <fd1cf102287.102287fd1cf@bigpond.com>
In-Reply-To: <fd1cf102287.102287fd1cf@bigpond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210152305.32641.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

> > this smells like a problem with one of your modules. Please make 100%
> > sure you use exactly the same .config for both 2.4.20pre10 and
> > 2.4.20pre10aa1 and please try to find which is the module that is
> > crashing the kernel after it's being loaded. Expect always different
> > kind of crashes and oopses. You can also try to turn on the slab
> > debugging option in the kernel hacking menu.

That precisely is the reason. The bad news is that system crashes when agpgart 
and radeon are compiled as modules, and the good news is that I am unable to 
crash it when they are not.

Mainline (2.4.20-pre10) is stable when agpgart and radeon are compiled as 
modules.

The problem is much easier to reproduce than I thought, just log in and log 
out of XFree86/Gnome few times (3 or more times in my case) is more than 
adequate to crash it.

Here is the .config which is stable in -aa1:
CONFIG_AGP=y
CONFIG_AGP_AMD=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_RADEON=y

Here is the .config which destabilises the -aa1 kernel:
CONFIG_AGP=m
CONFIG_AGP_AMD=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_RADEON=m

Unfortunately system just reboots without leaving oops information in the 
system logs. If you want I can try few older versions of -aa to find from 
when it started happening.

Thanks for your help.
-- 
Hari
harisri@bigpond.com

