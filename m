Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263112AbVFXFQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbVFXFQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 01:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbVFXFQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 01:16:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:1977 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263112AbVFXFP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 01:15:58 -0400
Date: Thu, 23 Jun 2005 22:12:29 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@digitalimplant.org>
Subject: [RFC] bind and unbind drivers from userspace through sysfs
Message-ID: <20050624051229.GA24621@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the internal infrastructure of the driver model
reworked so the locks aren't so global and imposing, it's possible to
bind and unbind drivers from devices from userspace with only a very
tiny ammount of code.

In reply to this email, are two patches, one that adds bind and one that
adds unbind functionality.  I've added these to my trees and should show
up in the next -mm releases.  Comments appreciated.

Oh, and yes, we still need a way to add new device ids to drivers from
sysfs, like PCI currently has.  I'll be working on that next.

Even so, with these two patches, people should be able to do things that
they have been wanting to do for a while (like take over the what driver
to what device logic in userspace, as I know some distro installers
really want to do.)

thanks,

greg k-h
