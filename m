Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbUKHXRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbUKHXRR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 18:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUKHXRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 18:17:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:49883 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261288AbUKHXRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 18:17:14 -0500
Date: Mon, 8 Nov 2004 14:58:10 -0800
From: Greg KH <greg@kroah.com>
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH/RFC 1/4]device core changes
Message-ID: <20041108225810.GB16197@kroah.com>
References: <1099887071.1750.243.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099887071.1750.243.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 12:11:11PM +0800, Li Shaohua wrote:
> Hi,
> This is the device core change required. Add .platform_bind method for
> bus_type, so platform can do addition things when add a new device. A
> case is ACPI, we want to utilize some ACPI methods for physical devices.
> 1. Why doesn't use 'platform_notify'?
> Current device core has a 'platform_notify' mechanism, but it's not
> sufficient for this. Only sepcific bus type know how to parse dev.bus_id
> and know how to encode specific device's address into ACPI _ADR syntax.

I don't see why platform_notify is not sufficient.  This is the exact
reason it was added to the code.

> 2. Why adds new 'handle' in 'struct device'?
> 'Platform_data' is the best candidate, but a search shows some drivers
> have used it. We can remove 'handle' after the drivers changes their
> behavior.

No, fix the drivers.  Don't add something that you are going to remove
later.

thanks,

greg k-h
