Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbULEVzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbULEVzW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 16:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbULEVzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 16:55:22 -0500
Received: from gprs215-105.eurotel.cz ([160.218.215.105]:37760 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261407AbULEVwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 16:52:01 -0500
Date: Sun, 5 Dec 2004 22:49:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Add support to resume swsusp from initrd
Message-ID: <20041205214949.GH1012@elf.ucw.cz>
References: <1102279686.9384.22.camel@tyrosine> <20041205211230.GC1012@elf.ucw.cz> <1102281698.9384.29.camel@tyrosine> <20041205212940.GG1012@elf.ucw.cz> <1102282928.9384.35.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102282928.9384.35.camel@tyrosine>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > resume_device is set by swsusp_read, which requires name_to_dev_t to be
> > > working. At the point where that's called, the device driver hasn't been
> > > loaded and we don't have the information to get the dev_t. Once the
> > > driver has been loaded, name_to_dev_t has already been discarded (it's
> > > marked __init). So we need to set resume_device somehow.
> > 
> > What about move of resume_device setup somewhere sooner?
> 
> Ah - we could always set resume_device, even if there's nothing to
> resume. That way, it'd be set correctly for userspace later on. Ok, I
> think I can make that work.

Yes.

> > > Heh. Yes, that's no problem. A new bigdiff for -rc3 would be
> > > helpful.
> > 
> > Hmm, I'm still on 2.6.9, but this code did not change much. I'll
> > generate it.
> 
> Thanks!

It should be in the queue.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
