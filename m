Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264581AbTLKJZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbTLKJZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:25:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:36330 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264581AbTLKJZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:25:04 -0500
Date: Thu, 11 Dec 2003 01:23:11 -0800
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Message-ID: <20031211092311.GB5102@kroah.com>
References: <3FD64BD9.1010803@pacbell.net> <200312101702.16455.baldrick@free.fr> <20031210205320.GA8621@kroah.com> <200312110949.54929.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312110949.54929.baldrick@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 09:49:54AM +0100, Duncan Sands wrote:
> 
> Hi Greg, what I meant was: should I make my patch friendlier to rmmod by
> trying hard to drop the reference as soon as possible, though some code paths
> may have to hold on to it for a long time (cost: code complication), or is it OK
> to always hang onto the usb_device as long as one of the usbfs files is open
> (cost: rmmod may take a long or infinite time; advantages: simple, robust)?

If the file is open, keep the reference count.  If you were to try
anything else, it would just be to complex in the end.

It's ok to wait a long time on rmmod, that's a pretty unique situation.

thanks,

greg k-h
