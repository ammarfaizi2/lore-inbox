Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTJGIa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 04:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTJGIa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 04:30:26 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:10398 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261885AbTJGIaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 04:30:18 -0400
Date: Tue, 7 Oct 2003 14:00:13 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031007083012.GE9036@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <OF6873DDE8.877C0EE8-ONC1256DB7.005F0935-C1256DB7.0060DEDC@de.ibm.com> <20031006174128.GA4460@kroah.com> <3F81ADC8.3090403@backtobasicsmgmt.com> <20031006181134.GA4657@kroah.com> <3F81B339.6040201@backtobasicsmgmt.com> <20031006183056.GA4714@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006183056.GA4714@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 06:42:29PM +0000, Greg KH wrote:
> On Mon, Oct 06, 2003 at 11:23:53AM -0700, Kevin P. Fleming wrote:
> > Greg KH wrote:
> > 
> > >The hotplug event points to the sysfs location of the kobject, that's
> > >all.  libsysfs then takes that kobject location and sucks up all of the
> > >attribute information for that kobject, which udev then uses to
> > >determine what it should do.
> > 
> > This sounds like a very different issue than what I thought you said 
> > originally. Your other message said a "find over the sysfs tree", 
> > implying some sort of tree-wide search for relevant information. In 
> > fact, the "find" is only for attributes in the directory owned by the 
> > kobject, right? Once they have been "found", they will age out of the 
> > dentry/inode cache just like any other search results.
> 
> They might, depending on the patch implementation.  And no, the issue
> isn't different, as we have to show the memory usage after all kobjects
> are accessed in sysfs from userspace, not just before, like some of the
> measurements are, in order to try to compare apples to apples.
> 

Well Greg, the aim of the patch is to save memory when the kobject is not
in use. I don't think it is a good idea to buy the same thing in  
600 bytes of RAM which is available for just 100 bytes.

I trying one more version which should not put any or minimum load on kobject 
when it is not in sysfs.

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
