Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVDYUf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVDYUf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVDYUcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:32:50 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:53161 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261165AbVDYU3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:29:06 -0400
Date: Mon, 25 Apr 2005 16:24:55 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>, Amit Gud <gud@eth.net>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, jgarzik@pobox.com,
       cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425202454.GE27771@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
	Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
	USB development list <linux-usb-devel@lists.sourceforge.net>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com> <20050425200825.GA3951@neo.rr.com> <20050425201949.GA24695@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425201949.GA24695@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 01:19:49PM -0700, Greg KH wrote:
> On Mon, Apr 25, 2005 at 04:08:25PM -0400, Adam Belay wrote:
> > I think this could be important for any type of device, so the power
> > management subsystem and driver core should handle it.  I'm not really
> > sure if it's useful in pci alone, as it lacks the necessary ordering and
> > coordination.
> 
> The driver core today _does_ handle this properly, and in the correct
> order.  I'm just allowing pci drivers access to that functionality, as
> today they can not take advantage of it.  That's all this patch does.

sorry, I didn't notice this after a quick glance :)

> +       drv->driver.shutdown = pci_device_shutdown,

Ok, great.  I understand.

> 
> > I'm currently developing an interface for quieting devices without turning
> > them off in my Power Management model.  Pavel seems to also have plans along
> > those lines:
> 
> <snip>

I think the intention here may have been to use PM_FREEZE via *suspend.  It
isn't currently supported though.

> 
> Great, then it will tie into the current driver model code, which will
> then call the proper pci driver code, and everyone will be happy :)
> 
> thanks,
> 
> greg k-h

Thanks,
Adam
