Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVDYUZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVDYUZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVDYUY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:24:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:31941 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261160AbVDYUUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:20:17 -0400
Date: Mon, 25 Apr 2005 13:19:49 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>, Pavel Machek <pavel@ucw.cz>,
       Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425201949.GA24695@kroah.com>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com> <20050425200825.GA3951@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425200825.GA3951@neo.rr.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 04:08:25PM -0400, Adam Belay wrote:
> I think this could be important for any type of device, so the power
> management subsystem and driver core should handle it.  I'm not really
> sure if it's useful in pci alone, as it lacks the necessary ordering and
> coordination.

The driver core today _does_ handle this properly, and in the correct
order.  I'm just allowing pci drivers access to that functionality, as
today they can not take advantage of it.  That's all this patch does.

> I'm currently developing an interface for quieting devices without turning
> them off in my Power Management model.  Pavel seems to also have plans along
> those lines:

<snip>

Great, then it will tie into the current driver model code, which will
then call the proper pci driver code, and everyone will be happy :)

thanks,

greg k-h
