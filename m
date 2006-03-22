Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932728AbWCVVIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbWCVVIl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbWCVVIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:08:41 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:17564
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932728AbWCVVIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:08:40 -0500
Date: Wed, 22 Mar 2006 13:08:20 -0800
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: [PATCH] Try 2, Fix release function in IPMI device model
Message-ID: <20060322210820.GA12518@kroah.com>
References: <20060322204501.GA21213@i2.minyard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322204501.GA21213@i2.minyard.local>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 02:45:01PM -0600, Corey Minyard wrote:
> Ok, one more try.  Russell, I assume you mean to use
> platform_device_alloc(), which seems to do what you suggested.
> And I assume the driver_data is the way to store whatever you
> need, instead of using the container_of() macro.
> 
> Arjun, Russell, thanks for the info.
> 
> Now the patch...
> 
> Arjun van de Ven pointed out that the changeover to the driver model
> in the IPMI driver had some bugs in it dealing with the release
> function and cleanup.  Then Russell King pointed out that you can't
> put release functions in the same module as the unregistering code.

Yes you can, you just have to properly set up the module attribute
owners and it will work just fine.

thanks,

greg k-h
