Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVASWSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVASWSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVASWQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:16:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:15612 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261946AbVASWOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:14:34 -0500
Date: Wed, 19 Jan 2005 13:42:49 -0800
From: Greg KH <greg@kroah.com>
To: Hannes Reinecke <hare@suse.de>
Cc: dtor_core@ameritech.net, Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] remove input_call_hotplug (Take#2)
Message-ID: <20050119214249.GC4151@kroah.com>
References: <41EE651E.1060201@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EE651E.1060201@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 02:48:14PM +0100, Hannes Reinecke wrote:
> Hi Dmitry,
> 
> attached is the reworked patch for removing the call to 
> call_usermodehelper from input.c
> I've used the 'phys' attribute to generate the device names, this way we 
> don't need to touch all drivers and the patch itself is nice and small.

The main problem of this is the input_dev structures are created
statically, right?  Because of this, the release function really doesn't
work out correctly I think....

Other than that this looks a lot better.

Hm, you're still generating hotplug events with this patch of the
"input_device" type, right?

thanks,

greg k-h
