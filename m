Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261329AbTDCQds>; Thu, 3 Apr 2003 11:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbTDCQds>; Thu, 3 Apr 2003 11:33:48 -0500
Received: from granite.he.net ([216.218.226.66]:33031 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id <S261329AbTDCQdr>;
	Thu, 3 Apr 2003 11:33:47 -0500
Date: Thu, 3 Apr 2003 08:37:57 -0800
From: Greg KH <greg@kroah.com>
To: Albert Cranford <ac9410@attbi.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
Message-ID: <20030403163757.GA4473@kroah.com>
References: <1049328958830@kroah.com> <3E8BD2D9.8050002@attbi.com> <20030403063359.GA1536@kroah.com> <3E8C31BE.5060000@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8C31BE.5060000@attbi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 08:06:06AM -0500, Albert Cranford wrote:
> Your right, nobody outside of sensors uses i2c-proc, but
> why not create a new i2c-sysfs.h in drivers/i2c locally
> and and adjust the couple of existing drivers.

What would i2c-sysfs.h be needed for?  All of the needed sysfs prototype
functions are already in device.h.

> We all know the application library is not going to have
> access to include/linux/include/i2c-xxxx.h anyhow.

It never did :)

> Later we can completely remove linux/include/linux/i2c-proc.h
> which the existing application library relies upon.

No userspace program should rely on kernel header files.
And I didn't take away the functionality that i2c-proc.h provided with
the list of devices supported and such.  Just the unused function
prototypes that dealt with the proc and sysctl interface.

thanks,

greg k-h
