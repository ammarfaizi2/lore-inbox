Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbULOSt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbULOSt3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbULOStW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:49:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:35516 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262447AbULOStC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:49:02 -0500
Date: Wed, 15 Dec 2004 10:48:50 -0800
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] add class_device to miscdevice
Message-ID: <20041215184850.GA9639@kroah.com>
References: <1100710140.5009.6.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100710140.5009.6.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 11:48:59AM -0500, Robert Love wrote:
> Greg, et al.
> 
> Currently misc_register() throws away the return from
> class_simple_device_add().  This makes it impossible to get to the
> class_device of the directories in /sys/class/misc and, for example,
> thus impossible to add attributes to those directories.
> 
> Attached patch adds a class_device structure to the miscdevice structure
> and assigns to it the value returned from class_simple_device_add() in
> misc_register(), thus caching the value and allowing us to f.e. later
> call class_device_create_file().
> 
> We need this for inotify, but I can see plenty of other misc. devices
> wanting this and consider it missing but required functionality.

Applied, will show up in the next -mm release.

thanks,

greg k-h
