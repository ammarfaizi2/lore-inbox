Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbTJFRok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263222AbTJFRoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:44:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:38349 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263136AbTJFRoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:44:32 -0400
Date: Mon, 6 Oct 2003 10:41:28 -0700
From: Greg KH <greg@kroah.com>
To: Christian Borntraeger <CBORNTRA@de.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006174128.GA4460@kroah.com>
References: <OF6873DDE8.877C0EE8-ONC1256DB7.005F0935-C1256DB7.0060DEDC@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6873DDE8.877C0EE8-ONC1256DB7.005F0935-C1256DB7.0060DEDC@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 07:38:06PM +0200, Christian Borntraeger wrote:
> Greg KH wrote:
> 
> > On Mon, Oct 06, 2003 at 02:29:15PM +0530, Maneesh Soni wrote:
> >> 
> >> 2.6.0-test6          With patches.
> >> -----------------
> >> dentry_cache (active)                2520                    2544
> >> inode_cache (active)         1058                    1050
> >> LowFree                      875032 KB               874748 KB
> > 
> > So with these patches we actually eat up more LowFree if all sysfs
> > entries are searched, and make the dentry_cache bigger?  That's not good
> > :(
> [...]
> > information for that kobject.  So I don't see any savings in these
> > patches, do you?
> 
> I do. As stated earlier, with 20000 devices on a S390 guest I have around 
> 350MB slab memory after rebooting. 
> With this patch, the slab memory reduces to 60MB. 

That's good.  But what happens after you run a find over the sysfs tree?
Which is essencially what udev will be doing :)

thanks,

greg k-h
