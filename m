Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbUACVvq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUACVvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:51:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:392 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263909AbUACVvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:51:41 -0500
Date: Sat, 3 Jan 2004 13:47:50 -0800
From: Greg KH <greg@kroah.com>
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Technical udev question for Greg
Message-ID: <20040103214750.GB11061@kroah.com>
References: <3FF72A4C.2040404@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF72A4C.2040404@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 12:47:08PM -0800, walt wrote:
> Hi Greg,
> 
> I think I acidentally screwed up by running a script which ran MAKEDEV
> while udev was running.
> 
> Now /dev/.udev.tdb is very large and devices have strange permissions
> they didn't have before.

As udev didn't get called when runinng MAKEDEV, I don't see how the udev
database could have grown.

> All I want to do is delete all the extraneous devices in .udev.tdb
> and start over.  How do I do that?

	rm -rf /dev/*
	rm -f /dev/.udev.tdb
	/etc/init.d/udev start

That should do it.

greg k-h
