Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWEITvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWEITvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWEITvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:51:25 -0400
Received: from ns1.suse.de ([195.135.220.2]:36028 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750996AbWEITvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:51:25 -0400
Date: Tue, 9 May 2006 12:49:48 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device hotplug driver.
Message-ID: <20060509194948.GB671@kroah.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085200.826853000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085200.826853000@sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:00:33AM -0700, Chris Wright wrote:
> +#ifdef XEN_XENBUS_PROC_INTERFACE
> +#include <xen/xen_proc.h>
> +#endif

Oh, you all never define this anywhere in the series, so anything
protected by it should be removed.

And I sure hope you don't have a xen_proc.h file anywhere, we do not
need any new non-process files going into /proc...

thanks,

greg k-h
