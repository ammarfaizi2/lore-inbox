Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTJFSbf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbTJFSbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:31:34 -0400
Received: from mail.kroah.org ([65.200.24.183]:27865 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262378AbTJFSbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:31:18 -0400
Date: Mon, 6 Oct 2003 11:30:56 -0700
From: Greg KH <greg@kroah.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Christian Borntraeger <CBORNTRA@de.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006183056.GA4714@kroah.com>
References: <OF6873DDE8.877C0EE8-ONC1256DB7.005F0935-C1256DB7.0060DEDC@de.ibm.com> <20031006174128.GA4460@kroah.com> <3F81ADC8.3090403@backtobasicsmgmt.com> <20031006181134.GA4657@kroah.com> <3F81B339.6040201@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F81B339.6040201@backtobasicsmgmt.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 11:23:53AM -0700, Kevin P. Fleming wrote:
> Greg KH wrote:
> 
> >The hotplug event points to the sysfs location of the kobject, that's
> >all.  libsysfs then takes that kobject location and sucks up all of the
> >attribute information for that kobject, which udev then uses to
> >determine what it should do.
> 
> This sounds like a very different issue than what I thought you said 
> originally. Your other message said a "find over the sysfs tree", 
> implying some sort of tree-wide search for relevant information. In 
> fact, the "find" is only for attributes in the directory owned by the 
> kobject, right? Once they have been "found", they will age out of the 
> dentry/inode cache just like any other search results.

They might, depending on the patch implementation.  And no, the issue
isn't different, as we have to show the memory usage after all kobjects
are accessed in sysfs from userspace, not just before, like some of the
measurements are, in order to try to compare apples to apples.

thanks,

greg k-h
