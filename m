Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbVALFC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbVALFC4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbVALFCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:02:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:25220 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263020AbVALFCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:02:41 -0500
Date: Tue, 11 Jan 2005 21:02:33 -0800
From: Greg KH <greg@kroah.com>
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]change 'struct device' -> platform_data to firmware_data
Message-ID: <20050112050233.GA976@kroah.com>
References: <1105498626.26324.14.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105498626.26324.14.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 10:57:06AM +0800, Li Shaohua wrote:
> Hi,
> struct device->platform_data is designed for ACPI, BIOS or other
> platform specific data, but some drivers misused the field which makes
> adding ACPI handle in device core impossible. Greg suggested me changing
> the name of the filed and so it breaks all such drivers, and then fix
> them. I'll try to fix some, but it would be great if the driver authors
> could do it.

No, the kernel has the "you break it, you fix it" rule.  And as you want
to use platform_data for something other than the drivers that are
currently using it for, you need to fix everyone else up before I can
accept such a change.

And yes, one could argue that those drivers are "doing the wrong thing",
but hey, they did it first, as no one else was using this field, and it
solved a need for them.  So you could successfully argue that they are
the correct ones here :)

thanks,

greg k-h
