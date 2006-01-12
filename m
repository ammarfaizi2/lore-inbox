Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWALBc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWALBc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWALBc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:32:57 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24205 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964956AbWALBc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:32:56 -0500
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
From: Dave Hansen <haveblue@us.ibm.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       xen-devel@lists.xensource.com
In-Reply-To: <43C5A199.1080708@us.ibm.com>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>
	 <43C5A199.1080708@us.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 17:32:54 -0800
Message-Id: <1137029574.11331.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 19:23 -0500, Mike D. Day wrote:
> Greg KH wrote:
> 
> > Why is xen special from the rest of the kernel in regards to adding
> > files to sysfs?  What does your infrastructure add that is not currently
> > already present for everyone to use today?
> 
> I think it comes down to simplification for non-driver code, which is 
> admittedly not the mainstream use model for sysfs.

You might also want to take a good look at how things like ACPI do
exports in sysfs: in /sys/firmware.  Not that ACPI is a good example of
_anything_ :), but that is probably more compliant with the current
model than your own /sys/xen.

Do you have a definitive list of things that you want to export?  Are
they things that come and go, or are they static?  Do you want hotplug
events for them?  Some of those things may be better fit platform
devices.  Notice that ACPI has entries in /sys/firmware/acpi
and /sys/devices/system/acpi.

-- Dave

