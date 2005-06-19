Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVFSF7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVFSF7n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 01:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVFSF7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 01:59:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:7339 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261965AbVFSF7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 01:59:32 -0400
Date: Sat, 18 Jun 2005 22:59:24 -0700
From: Greg KH <greg@kroah.com>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recursive call to platform_device_register deadlocks
Message-ID: <20050619055924.GA14674@kroah.com>
References: <42B43226.20703@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B43226.20703@hp.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 10:39:34AM -0400, Jamey Hicks wrote:
> 
> We could restructure the toplevel driver so that it does not call 
> platform_device inside its probe function.  An alternative would be to 
> add a pointer to a vector of subdevices to platform_device and have it 
> register the subdevices after it has probed the toplevel device.  Do you 
> have any recommendations?

Use the -mm kernel, this should be allowed in that release, due to a
rework of the driver core logic in this area.  Can you test this out and
verify this?

thanks,

greg k-h
