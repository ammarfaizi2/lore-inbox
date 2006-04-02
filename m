Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWDBWX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWDBWX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWDBWX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:23:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10972 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932427AbWDBWX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:23:26 -0400
Date: Mon, 3 Apr 2006 00:23:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: include/asm-arm/memory.h changes break zaurus sl-5500 boot
Message-ID: <20060402222314.GC12166@elf.ucw.cz>
References: <20060402210003.GA11979@elf.ucw.cz> <20060402220807.GD13901@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060402220807.GD13901@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 02-04-06 23:08:07, Russell King wrote:
> On Sun, Apr 02, 2006 at 11:00:03PM +0200, Pavel Machek wrote:
> > This reverts this (and one more) patch, and fixes boot on
> > collie. Without this patch, I get some fairly strange warnings about
> > shift bigger than page size in pfn_to_page().
> 
> Not surprising given this gem:
> 
> > -#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))
> 
> PAGE_OFFSET being 3GB - that's one hell of a shift value!

Unfortunately this is mainline now. Is there some better fix than
simply reverting the offending patches?
							Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
