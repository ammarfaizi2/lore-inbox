Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752466AbWCFXFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbWCFXFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbWCFXFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:05:21 -0500
Received: from tim.rpsys.net ([194.106.48.114]:37050 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1752466AbWCFXFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:05:20 -0500
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060307000718.0e8b8be3.zap@homelink.ru>
References: <1141571334.6521.38.camel@localhost.localdomain>
	 <440B89AB.3020203@gmail.com>
	 <1141634729.6524.14.camel@localhost.localdomain>
	 <20060307000718.0e8b8be3.zap@homelink.ru>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 23:05:07 +0000
Message-Id: <1141686307.6524.98.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 00:07 +0300, Andrew Zabolotny wrote: 
> On Mon, 06 Mar 2006 08:45:28 +0000
> Richard Purdie <rpurdie@rpsys.net> wrote:
> 
> > * the user supplied power sysfs attribute
> > * the user supplied brightness sysfs attribute
> > * the current FB blanking state
> > * any other driver specific factors
> As far I see the only real concern here is the console blanking. So why
> not make it just another device state flag, which doesn't influence the
> 'power' attribute and which isn't visible from user space (what for?).
> And the 'real' power state will be computed as "blank && power"
> attributes. The entire logic could be hidden in backlight.c so that no
> driver will have to be modified for this. Maybe a 'hw_power' or such
> would be needed to see the 'real' hardware state (and possibly
> modify, if you really really want to).
> 
> Is there any need for a broader-range solution here?

You've ignored the "driver specific factors" and one of the drivers
already has such a thing (borgi_bl's low battery backlight limiting).

My driver_brightness is really a more generic version of your "hw_power"
which allows other factors to be taken into consideration as well. We
may as well have the broader-range solution as it costs us nothing.

(I don't expect each factor to be visible to userspace, just the end
result).

Richard

