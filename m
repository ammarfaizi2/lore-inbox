Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWCFVo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWCFVo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWCFVo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:44:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57303 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932375AbWCFVo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:44:58 -0500
Date: Mon, 6 Mar 2006 22:44:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Zabolotny <zap@homelink.ru>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
Message-ID: <20060306214426.GA4701@elf.ucw.cz>
References: <1141571334.6521.38.camel@localhost.localdomain> <440B89AB.3020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440B89AB.3020203@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 06-03-06 09:00:27, Antonino A. Daplas wrote:
> Richard Purdie wrote:
> > At present, the backlight class presents two attributes to sysfs,
> > brightness and power. I'm a little confused as to whether these
> > attributes are currently doing the right things.
> > 
> > Taking brightness, at any one time we have several different brightness
> > values:
> > 
> > * User requested brightness (echo y > /sys/class/backlight/xxx/brightness)
> > * Driver determined brightness which accounts for things like FB 
> >   blanking, low battery backlight limiting (an example from corgi_bl), 
> >   user requested power state, device suspend/resume.
> > 
> > The solution might be to have brightness always return the user
> > requested value y and have a new attribute returning the brightness as
> > determined by the driver once it accounts for all the factors it needs
> > to consider. Naming of such an attribute is tricky - "driver_brightness"
> > perthaps?
> 
> Why not just agree on a normal range of values (ie, 0-255), and let the
> driver "denormalize" them?  Thus, a driver that has only 2 levels of
> brightness, will treat 0-127 as 0 and 128-255 as 1, and will return only
> two possible values 0 and 255.

Does not work... how do you set minimum brightness with backlight on
(so that text is visible)?
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
