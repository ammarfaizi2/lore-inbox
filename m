Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264220AbTEOTzl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264222AbTEOTzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:55:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:9110 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264220AbTEOTzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:55:39 -0400
Date: Thu, 15 May 2003 13:10:27 -0700
From: Greg KH <greg@kroah.com>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-ID: <20030515201027.GA10502@kroah.com>
References: <20030514211222.GA10453@bougret.hpl.hp.com> <3EC2BDEC.6020401@pobox.com> <20030514233235.GA11581@bougret.hpl.hp.com> <20030515071317.GB6497@kroah.com> <20030515172446.GD17496@bougret.hpl.hp.com> <20030515174648.GA9549@kroah.com> <20030515195516.GA18244@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515195516.GA18244@bougret.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 12:55:16PM -0700, Jean Tourrilhes wrote:
> On Thu, May 15, 2003 at 10:46:48AM -0700, Greg KH wrote:
> > On Thu, May 15, 2003 at 10:24:46AM -0700, Jean Tourrilhes wrote:
> > > 	Manuel Estrada sent me a proposal for that.
> > 
> > I provided some feedback to him that I think will make his proposal work
> > for almost everyone.  Hopefully he has the time to implement it :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> 	I read that thread and I don't agree with some of your
> unrealistic requirements.

If you think that having a common firmware interface for any kind of
device for 2.5 is unrealistic, then this is going to be a very short
discussion.

<2.4 is here for a long time ramble snipped>

> 	So, my question for you is :
> 	o how do you plan to make it work with 2.4.X.

In short, I don't care how you do it for 2.4.x.  Do it like the
bluetooth usb drivers do it, that's a good place to start with.  Or do
it like the usb drivers that do firmware download from userspace, that's
also a good way to do this for 2.4.  So for 2.4 you have a lot of
different options on how to do this, _because_ we don't have the
goodness of sysfs and the driver model there.

For 2.5 do it the way I proposed, that way _all_ devices in the kernel
have a single way to have firmware downloaded to them, which will result
in peace and harmony for many years to come, during which we will gaze
thoughtfully back on the anarchistic ways of 2.4 and laugh at how
foolish we were then.

thanks,

greg k-h
