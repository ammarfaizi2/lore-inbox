Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270624AbUJUBor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270624AbUJUBor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270684AbUJUBlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:41:11 -0400
Received: from fmr12.intel.com ([134.134.136.15]:16589 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S270529AbUJUBkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:40:35 -0400
Subject: Re: [ACPI] RE: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
From: Li Shaohua <shaohua.li@intel.com>
To: David Brownell <david-b@pacbell.net>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200410201002.58172.david-b@pacbell.net>
References: <200410201002.58172.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1098322408.6132.44.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 09:33:28 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 01:02, David Brownell wrote:
> On Tuesday 19 October 2004 20:51, Dmitry Torokhov wrote:
> > On Tuesday 19 October 2004 04:11 am, Li, Shaohua wrote:
> > > A final solution is device core adds an ACPI layer. That is we can
> link
> > > ACPI device and physical device. This way, the PCI device can know
> which
> > > ACPI is linked with it, so the PCI API can use specific ACPI
> method. 
> 
> The driver model core has platform_notify hooks for device add/remove,
> and ACPI should kick in that way ... they might well need tweaks
> though.
The platform_notify information isn't enough to find an ACPI device for
a physical device. To find an ACPI device, the bus information and
device information is needed. Only the specific bus knows the meaning of
an device's id, so I think the bus type should provide a callback to
interpret device id.

Thanks,
Shaohua

