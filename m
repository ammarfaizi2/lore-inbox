Return-Path: <linux-kernel-owner+w=401wt.eu-S965324AbXAKHsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965324AbXAKHsz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 02:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbXAKHsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 02:48:55 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:19272 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965324AbXAKHsz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 02:48:55 -0500
Date: Thu, 11 Jan 2007 08:48:53 +0100 (MET)
From: Oliver Neukum <oneukum@suse.de>
Organization: Novell
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: null pointer deref in khubd
User-Agent: KMail/1.9.1
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0701101732160.5563-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0701101732160.5563-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701110853.26871.oneukum@suse.de>
X-RZG-AUTH: kN+qSWxTQH+Xqix8Cni7tCsVYhPCm1GP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Januar 2007 23:35 schrieb Alan Stern:
> > Apparently here: drivers/base/core.c:
> > 
> > void device_del(struct device * dev)
> > {
> >       struct device * parent = dev->parent;
> >       struct class_interface *class_intf;
> > 
> >       if (parent)
> >               klist_del(&dev->knode_parent);
> > 
> > The obvious change with this device is that usb_set_configuration() is never
> > called, but that should not matter.
> 
> No, I think you're barking up the wrong tree.

OK. Next time I'll ask about config options before going through working
code looking for a bug.

	Regards
		Oliver
