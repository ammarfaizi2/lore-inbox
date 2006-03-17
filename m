Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWCQPTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWCQPTO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 10:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWCQPTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 10:19:13 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:38580
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750803AbWCQPTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 10:19:13 -0500
Date: Fri, 17 Mar 2006 07:18:58 -0800
From: Greg KH <greg@kroah.com>
To: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
Cc: "Artem B. Bityutskiy" <dedekind@yandex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
Message-ID: <20060317151858.GA31318@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316165323.GA10197@kroah.com> <4419A426.9080908@yandex.ru> <20060316175858.GA7124@kroah.com> <4419A9B8.8060102@yandex.ru> <20060316182018.GA4301@kroah.com> <441A819F.7040305@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441A819F.7040305@oktetlabs.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 12:30:07PM +0300, Artem B. Bityutskiy wrote:
> Greg KH wrote:
> >decl_subsys() is in the sysfs.h header file, not the device.h file.
> >Just stay away from anything in there if you hate the driver core so
> >much :)
> Ok, I see, thank you. I do not hate it, it is just not appropriate for 
> me. I do not have any bus. My device is a virtual device, not a real one.

So, you should still use the driver core for virtual devices (we have
lots of virtual devices in the driver model today.)

Why are you not using it?  What kind of device do you have?  Why does it
not fit into any existing device model (platform, system, etc)?

thanks,

greg k-h
