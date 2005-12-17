Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVLQVUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVLQVUP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVLQVUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:20:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:12457 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932069AbVLQVUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:20:13 -0500
Date: Sat, 17 Dec 2005 16:20:12 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [2.6 patch] fix the EMBEDDED menu
In-reply-to: <20051214221702.GH7124@flint.arm.linux.org.uk>
X-X-Sender: nico@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0512171614040.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051214191006.GC23349@stusta.de>
 <20051214140531.7614152d.akpm@osdl.org>
 <20051214221702.GH7124@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2005, Russell King wrote:

> I believe there are instances where ARM fails if CC_OPTIMIZE_FOR_SIZE 
> is not set. Luckily we have assertions in the generated assembly to 
> flag these as assembly errors when they happen, rather than silently 
> continuing to build.

Actually that gcc problem was unrelated to -Os vs -O2.  I was able to 
produce a test case that triggered the bug even with -Os at the time.  
It is true that, for the kernel, using -Os made the gcc bug more 
unlikely, but it could have happened regardless.  This particular gcc 
bug was fixed quite a while ago so using either -O2 and -Os on ARM 
should be fine (especially since we fail the compilation if a bad 
compiler triggers the bug).


Nicolas
