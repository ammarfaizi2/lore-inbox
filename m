Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTJWIMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 04:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTJWIMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 04:12:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37274 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261696AbTJWIMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 04:12:38 -0400
Date: Mon, 20 Oct 2003 14:20:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Mock <kd6pag@qsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp in test8 fails with intel-agp and i830
Message-ID: <20031020122011.GR1659@openzaurus.ucw.cz>
References: <E1ABV7L-0001Os-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ABV7L-0001Os-00@penngrove.fdns.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    Pavel - I looked in intel_agp and placed printk+mdelay all over
>    agp_intel_resume(struct pci_dev *pdev), but something strange happened: I saw
>    those print outs during _suspend_ and not during resume - does that make any
>    sense?

They should be called both during suspend and during
resume. If they are not called during resume... Trace that
it looks like problem.

> I wasn't able to find anything that looked like suspend/resume support in
> 'drivers/char/drm/*', and i'm starting to wonder if DRI in general has any
> chance of working with software suspend.  After all, i think the X server 
> reaches in and hacks the hardware, so i don't understand how the DRM code 
> can manage to restore that state after being powered down, 'cause i don't 

Well, X should only hit hw when it owns the console,
that's why -test8 swsusp is doing console switch.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

