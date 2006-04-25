Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWDYWlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWDYWlM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 18:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWDYWlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 18:41:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:64913 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751576AbWDYWlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 18:41:12 -0400
Date: Tue, 25 Apr 2006 15:39:58 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] class_device_add needs error checks
Message-ID: <20060425223958.GA30677@kroah.com>
References: <20060421134027.3198974e@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421134027.3198974e@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 01:40:27PM -0700, Stephen Hemminger wrote:
> +		if (atomic_read(&class_dev->kobj.kref.refcount))
> +			kobject_del(&class_dev->kobj);

Yeah, we can't do this, we should not be mucking around in the kref core
like this.

Are you having problems where class_device_add() should be failing and
it isn't?

Other than the above, the patch almost looked good :)

thanks,

greg k-h
