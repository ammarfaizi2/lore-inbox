Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUCCWCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUCCWCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:02:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:65232 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261179AbUCCWB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:01:59 -0500
Date: Wed, 3 Mar 2004 14:01:35 -0800
From: Greg KH <greg@kroah.com>
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Schlemmer <azarah@gentoo.org>
Subject: Re: udev versus parallel-port Zip drive
Message-ID: <20040303220135.GA32662@kroah.com>
References: <40465460.1050600@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40465460.1050600@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 01:55:44PM -0800, walt wrote:
> I've been fiddling with Zip-drive support -- both USB and
> parallel-port.
> 
> When I compile everything as modules I find that the
> parallel-port driver for Zip drives (ppa) does not load
> automatically.  To make the parallel Zip drive work I
> need to do a 'modprobe ppa' manually, after which everything
> works as expected.
> 
> I can only imagine the complexity involved in figuring out
> what is attached to the parallel port at boot-time -- there
> must be thousands of possibilities to sort through.
> 
> My question, I suppose, is:  what are the chances that a
> parallel-port device can be automatically detected by udev
> and the appropriate module loaded?  Is this a pipe-dream?
> Or maybe it should already work and I'm just omitting some
> important steps?


udev does no device discovery.  Please, please, please, please remember
this.

udev has nothing to do with this issue.

Here's a little sign to print out for the next time someone tries to
bring this issue up:

	**********************************
	* udev does no device discovery! *
	**********************************

thanks,

greg k-h
