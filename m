Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263987AbTJFSLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbTJFSLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:11:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:1493 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263987AbTJFSLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:11:53 -0400
Date: Mon, 6 Oct 2003 11:11:34 -0700
From: Greg KH <greg@kroah.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Christian Borntraeger <CBORNTRA@de.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006181134.GA4657@kroah.com>
References: <OF6873DDE8.877C0EE8-ONC1256DB7.005F0935-C1256DB7.0060DEDC@de.ibm.com> <20031006174128.GA4460@kroah.com> <3F81ADC8.3090403@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F81ADC8.3090403@backtobasicsmgmt.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 11:00:40AM -0700, Kevin P. Fleming wrote:
> Greg KH wrote:
> 
> >
> >That's good.  But what happens after you run a find over the sysfs tree?
> >Which is essencially what udev will be doing :)
> >
> 
> This sounds like an opportunity to improve the udev<->sysfs 
> interaction. Does the hotplug event not give udev enough information 
> to avoid this "find" search?

The hotplug event points to the sysfs location of the kobject, that's
all.  libsysfs then takes that kobject location and sucks up all of the
attribute information for that kobject, which udev then uses to
determine what it should do.

Unless we want to pass all attribute information through hotplug, which
we do not.

Do you have any suggestions?

thanks,

greg k-h
