Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWBSR4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWBSR4t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWBSR4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:56:49 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:43673
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932183AbWBSR4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:56:49 -0500
Date: Sun, 19 Feb 2006 09:56:23 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mundt <lethal@linux-sh.org>, zanussi@us.ibm.com,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060219175623.GA2674@kroah.com>
References: <20060219171748.GA13068@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219171748.GA13068@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that Pat isn't the sysfs maintainer anymore :)

On Sun, Feb 19, 2006 at 07:17:48PM +0200, Paul Mundt wrote:
> Now with relayfs integrated and the relay_file_operations exported for
> use by other file systems, I wonder what people think about adding in a
> sysfs attribute for setting up channel buffers.
> 
> The conventional relayfs doesn't make a lot of sense for the use cases
> where there are multiple devices to stream data from, particularly if
> they're already mapped out through the driver model. Rather than
> duplicating device enumeration, simply adding this as an attribute seems
> to work reasonably well.
> 
> Tom did some work on the rchan_callbacks for more easily implementing
> relay files in other file systems, and it would be nice to use this in a
> non-debug context, without duplicating device enumeration in multiple
> locations.

Looks good, I like it.  This properly handles the module owner stuff,
too, right?

And I agree with Christoph, with this change, you don't need a separate
relayfs mount anymore.

thanks,

greg k-h
