Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267437AbUG2VGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267437AbUG2VGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267425AbUG2VFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:05:51 -0400
Received: from gprs214-254.eurotel.cz ([160.218.214.254]:18305 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265287AbUG2VDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:03:14 -0400
Date: Thu, 29 Jul 2004 23:02:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: David Brownell <david-b@pacbell.net>,
       Alexander Gran <alex@zodiac.dnsalias.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fixing usb suspend/resuming
Message-ID: <20040729210256.GC18623@elf.ucw.cz>
References: <200405281406.10447@zodiac.zodiac.dnsalias.org> <40F962B6.3000501@pacbell.net> <200407190927.38734@zodiac.zodiac.dnsalias.org> <200407202205.37763.david-b@pacbell.net> <20040729083543.GG21889@openzaurus.ucw.cz> <1091103438.2703.13.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091103438.2703.13.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Plus, some PCI drivers (ide disk?) want to do different thing on S3 and swsusp:
> > it does not make much sense to spindown before swsusp.
> 
> Regarding the spinning down before suspending to disk, I have a patch in
> my version that adds support for excluding part of the device tree when
> calling drivers_suspend. I take the bdevs we're writing the image
> to,

Well, its more complicated, I believe. You can't just leave those
devices running, because they could DMA and damage the image... So you
need something like

suspend_fast_ill_resume_you_soon().

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
