Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSLJQHW>; Tue, 10 Dec 2002 11:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSLJQHW>; Tue, 10 Dec 2002 11:07:22 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:41478 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S262394AbSLJQGw>; Tue, 10 Dec 2002 11:06:52 -0500
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
From: Antonino Daplas <adaplas@pol.net>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210140301.GC26361@suse.de>
References: <1039522886.1041.17.camel@localhost.localdomain>
	<20021210131143.GA26361@suse.de>
	<1039538881.2025.2.camel@localhost.localdomain> 
	<20021210140301.GC26361@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039547210.1071.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 00:08:22 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 19:03, Dave Jones wrote:
> On Tue, Dec 10, 2002 at 09:47:24PM +0500, Antonino Daplas wrote:

> 
> btw, iirc you were the guy who wanted agpgart initialised sooner
> due to the way the i810 framebuffer worked ?
> How much sooner are we talking ? What puzzles me, is looking
> at the link order in the makefiles, agpgart should already be
> getting initialised before the framebuffer code, but doesn't
> seem to be for reasons unknown..

Tried it with framebuffer console off, same results. Moved agp before vt
in char/Makefile, same. Even manually calling agp_init() doesn't work
because what's really needed is agp_intel_init(). 

Anyway, I guess I'll stick to what I'm doing right now, periodically do
an inter_module_get("drm_agp") until it becomes available.

Tony

