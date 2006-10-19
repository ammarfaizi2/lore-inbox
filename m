Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946137AbWJSPyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946137AbWJSPyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946138AbWJSPyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:54:33 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:59090 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1946137AbWJSPyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:54:32 -0400
Date: Thu, 19 Oct 2006 08:55:28 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [PATCH] Add device addition/removal notifier
Message-Id: <20061019085528.45a5771e.randy.dunlap@oracle.com>
In-Reply-To: <1161244591.10524.45.camel@localhost.localdomain>
References: <1161244591.10524.45.camel@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 17:56:31 +1000 Benjamin Herrenschmidt wrote:

> Index: linux-cell/include/linux/device.h
> ===================================================================
> --- linux-cell.orig/include/linux/device.h	2006-10-19 17:43:58.000000000 +1000
> +++ linux-cell/include/linux/device.h	2006-10-19 17:44:24.000000000 +1000
> @@ -427,6 +427,22 @@ extern int (*platform_notify)(struct dev
>  
>  extern int (*platform_notify_remove)(struct device * dev);
>  
> +/**
> + * Device notifiers. Get notified of addition/removal of devices
> + * and possibly other events in the future. Replacement for the
> + * platform "fixup" functions. This is a low level hook provided
> + * for the platform to initialize private parts of struct device,
> + * like firmware related links. Add is called before the device is
> + * added to a bus (and thus the driver probed) and Remove is called
> + * afterward.
> + */

That's not kernel-doc, so please don't begin it with "/**".

---
~Randy
