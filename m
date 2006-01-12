Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWALJ6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWALJ6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWALJ6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:58:53 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:44961 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1030344AbWALJ6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:58:53 -0500
In-Reply-To: <1137029574.11331.11.camel@localhost.localdomain>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <1137029574.11331.11.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <00466d4b0eb7fe1603cd7f54448d37ff@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, "Mike D. Day" <ncmike@us.ibm.com>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
Date: Thu, 12 Jan 2006 10:04:30 +0000
To: Dave Hansen <haveblue@us.ibm.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Jan 2006, at 01:32, Dave Hansen wrote:

> Do you have a definitive list of things that you want to export?  Are
> they things that come and go, or are they static?  Do you want hotplug
> events for them?  Some of those things may be better fit platform
> devices.  Notice that ACPI has entries in /sys/firmware/acpi
> and /sys/devices/system/acpi.

This is a good set of questions. We have about half dozen files in 
/proc/xen right now. One is an obvious canididate to stick in /dev, as 
it has primarily an ioctl() interface. The remainder are static, are 
read-only or read-write with ascii text, and we don't want hotplug 
events and other baggage.

Maybe making these attributes of a Xen system device makes sense. Are 
there examples in the kernel of other subsystems/modules with a similar 
miscellaneous set of files?

  -- Keir

