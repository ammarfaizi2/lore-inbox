Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUHMQMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUHMQMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUHMQMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:12:55 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:47331 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266143AbUHMQMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:12:50 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though sysfs)
Date: Fri, 13 Aug 2004 09:11:29 -0700
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
References: <20040813155312.98961.qmail@web14929.mail.yahoo.com>
In-Reply-To: <20040813155312.98961.qmail@web14929.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408130911.29626.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 13, 2004 8:53 am, Jon Smirl wrote:
> What should the API for this look like? We could add a VGA={0/1}
> attribute to all the VGA devices in sysfs.
>
> But then how do you:
> 1) list all of the conflicting VGA devices in a domain?
> 2) turn off all the VGA devices in a domain?
>
> We could build a bus like directory structure in /sys/class
>
> /sys/class/vga/domain1/vga1/(device/driver/enable)
> /sys/class/vga/domain1/vga2/(device/driver/enable)
> /sys/class/vga/domain2/vga1/(device/driver/enable)
> /sys/class/vga/domain2/vga2/(device/driver/enable)
>
> Then add an enable attribute in the domain directories that would shut
> off all of the subdevices.
>
> /sys/class/vga/domain1/enable
> /sys/class/vga/domain2/enable
>
> But the vga driver is not going to be attached to a device. Is there an
> easy way to build this is sysfs?

Maybe we need a display driver class?  Could we reuse the dri drivers for that 
purpose?

Jesse
