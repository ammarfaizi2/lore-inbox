Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTLLSx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 13:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTLLSx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 13:53:59 -0500
Received: from mail.linuxtv.org ([212.84.236.4]:33694 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261775AbTLLSx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 13:53:57 -0500
Date: Fri, 12 Dec 2003 19:53:57 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Greg KH <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11: i2c-dev.h for userspace
Message-ID: <20031212185357.GB32169@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Greg KH <greg@kroah.com>, sensors@stimpy.netroedge.com,
	linux-kernel@vger.kernel.org
References: <20031212145652.GA30747@convergence.de> <20031212175656.GA2933@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212175656.GA2933@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 09:56:57AM -0800, Greg KH wrote:
> On Fri, Dec 12, 2003 at 03:56:52PM +0100, Johannes Stezenbach wrote:
> > 
> > I had some trouble compiling a userspace application
> > which uses the I2C device interface (the DirectFB
> > Matrox driver). Apparently some stuff has been removed
> > from i2c-dev.h
> 
> Yes it has.  Do not use the kernel headers in your userspace
> application.  If you need this interface, use the updated i2c-dev.h that
> is in the lmsensors release.  That is the proper file.

I think you create a mess here. Other drivers have usable
API include files in /usr/include/linux, why are i2c.h and i2c-dev.h
special?

While I can understand why the ioctl wrappers have been removed
from the kernel include file i2c-dev.h I fail to see the logic
in having a different i2c-dev.h for userspace, or generally breaking
the kernel includes for userspace.

It seems to me that there is no package that I could install to make
the correct i2c-dev.h available for userspace programs, and the only
way to fix the DirectFB Matrox driver so it compiles with 2.4 and
2.6 kernel headers is to copy the correct i2c-dev.h into the
DirectFB source tree.

I think that sucks.


Johannes
