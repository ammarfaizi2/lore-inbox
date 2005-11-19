Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVKSAmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVKSAmD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 19:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVKSAmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 19:42:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:27048 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751133AbVKSAmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 19:42:01 -0500
Date: Fri, 18 Nov 2005 16:25:48 -0800
From: Greg KH <greg@kroah.com>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] EDAC and /sys/devices/system
Message-ID: <20051119002548.GA27269@kroah.com>
References: <20051118223744.88496.qmail@web50110.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118223744.88496.qmail@web50110.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 02:37:44PM -0800, Doug Thompson wrote:
> Well, I have been playing now with the sysdev class of
> APIs for installing objects into /sys/devices/system.
> Unforturnately, the capabilities of that do not
> provide me with what I was wanting for EDAC.
> 
> What I was wanting was an extra directory called
> 'edac'. In that directory was to be various types of
> edac devices (memory controller and PCI Parity to
> start)
> 
> In the directory /sys/devices/system:
> 
> edac/mc/mc0/<attr and controls>
> edac/mc/mc1/<attr and controls>
> edac/mc/<attr and controls>
> 
> and
> 
> edac/pci/<attr and controls>
> 
> This would allow for future edac components.
> 
> What I found out was that /sys/devices/system doesn't
> allow for nested subsystems. At least not from what I
> have read.

Why?  It should work just fine, you might need to export a variable that
isn't global, right?  It shouldn't be more complex than that.

thanks,

greg k-h
