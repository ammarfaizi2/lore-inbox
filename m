Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWAXE7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWAXE7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 23:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWAXE7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 23:59:03 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:48064
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030335AbWAXE7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 23:59:02 -0500
Date: Mon, 23 Jan 2006 20:58:49 -0800
From: Greg KH <greg@kroah.com>
To: Dave Airlie <airlied@gmail.com>
Cc: airlied@linux.ie, Kay Sievers <kay.sievers@vrfy.org>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] cleanup of the drm sysfs code.
Message-ID: <20060124045849.GB22434@kroah.com>
References: <20060120233337.GA22848@kroah.com> <21d7e9970601211403g44ce4845yd03f12f64142ef36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970601211403g44ce4845yd03f12f64142ef36@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 11:03:16AM +1300, Dave Airlie wrote:
> > Kay pointed out today that the drm code creates a "dev" file in sysfs,
> > yet doesn't tell the driver core about it.  Normally this would be just
> > fine, as you are exporting the value in the proper style, but now there
> > are programs that are only watching the hotplug/uevent netlink messages
> > and not reading directly from sysfs to get this kind of information.
> > The patch below is a cleanup of the drm sysfs code, as much of the same
> > functionality that you want is already present in the driver core, so it
> > is not good to duplicate it.
> 
> Greg it looks fine to me, I'm LCA'ing at the moment, so if you can
> push it via your tree I'm fine with it, if you can let it sit in an
> -mm picked up tree for a bit I'd appreciate it, but we don't do much
> with sysfs anyways other than create the dev..

Ok, thanks.  I'll get it into the next few -mm releases, and as Linus is
also with you at linux.conf.au, I don't really worry about getting the
patch to him until he returns.

> I'm going to hopefully get around to the drm/fb merge layer in the
> next month so I'd prefer to start from a clean state..

Sounds good to me, I'll probably have the time to help out with this if
you want...

thanks,

greg k-h
