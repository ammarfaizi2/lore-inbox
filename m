Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbULVB3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbULVB3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 20:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbULVB3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 20:29:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:215 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261936AbULVB3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 20:29:17 -0500
Date: Tue, 21 Dec 2004 17:29:06 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourcefoge.net.kroah.org,
       linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: My vision of usbmon
Message-ID: <20041221172906.3b9cbbbd@lembas.zaitcev.lan>
In-Reply-To: <20041222005726.GA13317@kroah.com>
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan>
	<20041222005726.GA13317@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2004 16:57:26 -0800, Greg KH <greg@kroah.com> wrote:

> It looks great, thanks for doing this work.  Let me know when you want
> it added to the kernel tree.

Thanks, Greg. There's a little tidbit in usbmon about which I wish you to
make a pronouncement explicitly:

+	/* XXX Is this how I pin struct bus? Ask linux-usb-devel */
+	kobject_get(&ubus->class_dev.kobj);
+	mbus->u_bus = ubus;
+	ubus->mon_bus = mbus;

Is this a good way to guarantee that mbus->u_bus won't be dangling?
This is used not just when someone pulls a PCMCIA card, but also
in case of plain rmmod ohci-hcd.

-- Pete
