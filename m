Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269726AbUJAH0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269726AbUJAH0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 03:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269724AbUJAH0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 03:26:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:4530 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269726AbUJAH0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 03:26:13 -0400
Date: Thu, 30 Sep 2004 23:52:09 -0700
From: Greg KH <greg@kroah.com>
To: Michael Hunold <hunold-ml@web.de>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Message-ID: <20041001065209.GA9561@kroah.com>
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com> <41545421.5080408@web.de> <20040924200503.652ccf8e.khali@linux-fr.org> <415481B4.10804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415481B4.10804@web.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 10:21:08PM +0200, Michael Hunold wrote:
> >Also, how does this proposal interact with the work on the i2c classes?
> >Although the classes carry more information than a simple flag or a
> >complete separation, both were/may be introduced to achieve the same
> >goal, isn't it?
> 
> Partly, yes.
> 
> The .class approach is necessary to have a finer grained access control 
> by the i2c-core regarding bus classes, ie. not the client drivers have 
> to check if the bus should be probed (for example dcc drivers on a dvb 
> bus). This is useful in general.
> 
> If we have a PCI card where we exactly know what we are doing, we can 
> use the NO_PROBE flag to effectively block any probing and can use the 
> proposed interface to manually connect the clients.

But why?  The .class feature can accomplish this too.  Just create a new
class for this type of adapter and device.  Then only that device will
be able to be connected to that adapter, just like you want to have
happen, right?

thanks,

greg k-h
