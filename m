Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUAMAF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbUAMAF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:05:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:1494 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262540AbUAMAFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:05:23 -0500
Date: Mon, 12 Jan 2004 16:05:14 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restrict class names to valid file names
Message-ID: <20040113000514.GA4848@kroah.com>
References: <20040112151357.5c9702b7.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112151357.5c9702b7.shemminger@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 03:13:57PM -0800, Stephen Hemminger wrote:
> It is possible to name network devices with names like "my/bogus" or "." or ".."
> which leaves /sys/class/net/ a mess.  Since other subsystems could have the same
> problem, it made sense to me to enforce some restrictions in the class device
> layer.
> 
> A lateer patch fixes the network device registration path because the
> sysfs registration takes place after the register_netdevice call has taken place.

Heh, so you will have already "scrubbed" the name before you submit it
to the driver core?  If so, why add this patch?

thanks,

greg k-h
