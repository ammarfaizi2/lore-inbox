Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVCARB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVCARB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVCARB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:01:29 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:56761 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261975AbVCARBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:01:15 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: disallow modular framebuffers
Date: Tue, 1 Mar 2005 08:59:59 -0800
User-Agent: KMail/1.7.2
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <20050301024118.GF4021@stusta.de>
In-Reply-To: <20050301024118.GF4021@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503010859.59487.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 28, 2005 6:41 pm, Adrian Bunk wrote:
> Hi,
>
> while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and
> FB_SAVAGE_ACCEL=m are currently broken) I asked myself:
>
> Do modular framebuffers really make sense?
>
> OK, distributions like to make everything modular, but all the
> framebuffer drivers I've looked at parse driver specific options in
> their *_setup function only in the non-modular case.

That sounds like it should be fixed.

> And most framebuffer drivers contain a module_exit function.
> Is there really any case where this is both reasonable and working?

I'd like to see them stay modular if it's not too much trouble.  It makes 
things easier to debug and test, for one thing.  I also think setups with 
multiple framebuffers but w/o consoles on any of them are somewhat common, 
meaning the fb drivers can be easily loaded and unloaded if the fb devices 
aren't in use.

Jesse
