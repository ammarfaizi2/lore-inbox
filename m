Return-Path: <linux-kernel-owner+w=401wt.eu-S1030247AbXAKKe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbXAKKe1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbXAKKe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:34:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37234 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030247AbXAKKe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:34:27 -0500
Date: Thu, 11 Jan 2007 11:34:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: null pointer deref in khubd
Message-ID: <20070111103406.GA5943@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0701101732160.5563-100000@iolanthe.rowland.org> <200701110853.26871.oneukum@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200701110853.26871.oneukum@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2007-01-11 08:48:53, Oliver Neukum wrote:
> Am Mittwoch, 10. Januar 2007 23:35 schrieb Alan Stern:
> > > Apparently here: drivers/base/core.c:
> > > 
> > > void device_del(struct device * dev)
> > > {
> > >       struct device * parent = dev->parent;
> > >       struct class_interface *class_intf;
> > > 
> > >       if (parent)
> > >               klist_del(&dev->knode_parent);
> > > 
> > > The obvious change with this device is that usb_set_configuration() is never
> > > called, but that should not matter.
> > 
> > No, I think you're barking up the wrong tree.
> 
> OK. Next time I'll ask about config options before going through working
> code looking for a bug.

Can we delete that config option for 2.6.20? (And sorry for a crappy report).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
