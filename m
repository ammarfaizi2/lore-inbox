Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbTLJCK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTLJCJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:09:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:19678 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263299AbTLJCID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:08:03 -0500
Date: Tue, 9 Dec 2003 17:56:01 -0800
From: Greg KH <greg@kroah.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: "Mr. Mailing List" <mailinglistaddie@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: palm pilot broken in test 10
Message-ID: <20031210015601.GX2279@kroah.com>
References: <20031125101529.77057.qmail@web60202.mail.yahoo.com> <1069781651.3452.8.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069781651.3452.8.camel@mentor.gurulabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 10:34:12AM -0700, Dax Kelson wrote:
> On Tue, 2003-11-25 at 03:15, Mr. Mailing List wrote:
> > visor ttyUSB2: Handspring Visor / Palm OS converter
> > now disconnected from ttyUSB2
> > visor ttyUSB3: Handspring Visor / Palm OS converter
> > now disconnected from ttyUSB3
> > usbserial 4-2:1.0: device disconnected
> > 
> > 
> > worked several versions ago, then was broken, then
> > fixed,  and has been broken the last several versions.
> 
> I can confirm that there is a problem in test10. I have a Treo600 and
> plugging it in (and/or pressing the hotsync button) results in no
> autoloading of the visor module. If I manually modprobe the visor
> module, then when I connect/disconnect and/or press hotsync there is no
> activity viewable via "dmesg".
> 
> Greg, how can I troubleshoot this better for you?

I've posted some patches here that should fix this bug (a combo of a
sysfs patch, a kobject patch, and a usb-serial patch.)

thanks,

greg k-h
