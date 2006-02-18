Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWBRSAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWBRSAl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 13:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWBRSAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 13:00:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13442 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932103AbWBRSAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 13:00:41 -0500
Date: Sat, 18 Feb 2006 19:00:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Mittendorfer <delist@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [swsusp] not enough memory
Message-ID: <20060218180029.GH1776@elf.ucw.cz>
References: <20060218005814.6548092d.delist@gmx.net> <20060218151115.GC5658@openzaurus.ucw.cz> <20060218185759.248208f9.delist@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218185759.248208f9.delist@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 18-02-06 18:57:59, Richard Mittendorfer wrote:
> Also sprach Pavel Machek <pavel@suse.cz> (Sat, 18 Feb 2006 16:11:16
> +0100):
> > On Sat 18-02-06 00:58:14, Richard Mittendorfer wrote:
> > > If I end all apps but the XServer it works. I've allready added some
> > > more swapspace, but that didn't help. So, how much memory will I
> > > need for a successful suspend or better (since i can't stuff any
> > > more into  it) is there a way to minimize the amount needed?
> > 
> > 128MB should be enough for you. 
> 
> Swap? 128M was my first attempt -- OOM when the box was heavily loaded.
> IIRC no effect on swsusp - there are 64M Ram + 2M Video + Kernel + X?. 
> The reason I did it were some google results talking about free pages.
> There were some solutions talking about adding swap.
>  
> (Ram? Would be the way to go, but it's fully loaded.)

RAM. No ammount of swap will help you.

> > Or try modifying try_to_free memory
> > routine to retry shrink_all_mem few more times, with schedule()  in
> > between...
> 
> Uhh. I don't think this will be a good idea /me ha[ck|rm]ing good ol'
> linux source. ;-)

It should be easy. It is quite hard to loose much data this way ;-).

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
