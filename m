Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVF2SID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVF2SID (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVF2SIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:08:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:49038 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262333AbVF2SHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:07:43 -0400
Date: Wed, 29 Jun 2005 11:03:13 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 05/16] IB uverbs: core implementation
Message-ID: <20050629180313.GC25066@kroah.com>
References: <2005628163.lUk0bfpO8VsSXUh5@cisco.com> <2005628163.jfSiMqRcI78iLMJP@cisco.com> <20050629002709.GB17805@kroah.com> <52slz1drlq.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52slz1drlq.fsf@topspin.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 10:01:53AM -0700, Roland Dreier wrote:
>     Greg> This is no longer needed with the class device interface in
>     Greg> the kernel today.  Please use the new api (basically just
>     Greg> set dev_t in the class_device, and you get this for free.)
> 
> Here's a patch that applies on top of this patch set that fixes this:
> 
> 
> Greg KH pointed out that with the new class device code, we can just
> set class_dev.devt instead of having our own show_dev() function.
> 
> Signed-off-by: Roland Dreier <rolandd@cisco.com>

Nice, thanks for doing this.  You also get better userspace support as
now the MAJOR and MINOR environment variables are set for the hotplug
event when you create this device.

Which, if Kay is correct, will make udev even faster...

thanks,

greg k-h
