Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUHFVeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUHFVeh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268311AbUHFVct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:32:49 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:8321 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268306AbUHFVa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:30:58 -0400
Date: Fri, 6 Aug 2004 23:30:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Solving suspend-level confusion
Message-ID: <20040806213034.GJ30518@elf.ucw.cz>
References: <200408031928.08475.david-b@pacbell.net> <1091586381.3189.14.camel@laptop.cunninghams> <1091587985.5226.74.camel@gaston> <1091587929.3303.38.camel@laptop.cunninghams> <1091592870.5226.80.camel@gaston> <1091593555.3191.48.camel@laptop.cunninghams> <1091595125.5227.96.camel@gaston> <1091595258.3303.74.camel@laptop.cunninghams> <1091595811.5226.105.camel@gaston> <1091745102.2530.24.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091745102.2530.24.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That's where the whole confusion is indeed... and why we need to make
> > that clear. The IDE driver will sleep the disk for 3 and keep it spinning
> > for 4
> 
> Okay. So that leaves me calling device_suspend(4) when I want to quiesce
> the driver but not spin down and device_suspend(3) when I want to power
> down. Does that sound right? It sounds hairy to me. (Do other drivers
> treat 3 and 4 in the same way?)

This really needs to be cleaned up properly. What you do is pretty
much okay, but we need to switch to enums or char * or something and
kill the confusion.
								Pavel 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
