Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTJGHj7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 03:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTJGHj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 03:39:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48571 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261806AbTJGHj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 03:39:57 -0400
Date: Tue, 7 Oct 2003 12:47:28 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Patrick Mochel <mochel@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031007071728.GD9036@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031006202656.GB9908@in.ibm.com> <Pine.LNX.4.44.0310061321440.985-100000@localhost.localdomain> <20031007043157.GA9036@in.ibm.com> <3F824E66.7020006@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F824E66.7020006@cyberone.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 03:25:58PM +1000, Nick Piggin wrote:
> 
> 
> >
> >Having backing store just for leaf dentries should be fine. But there is 
> >_no_ easy access for attributes. For this also I see some data change 
> >required as of now. The reasons are 
> >- not all kobjects belong to a kset. For example, /sys/block/hda/queue
> >- not all ksets have attribute groups
> > 
> >
> 
> queue and iosched might not be good examples as they are somewhat broken
> wrt the block device scheme. Possibly they will be put in their own kset,
> with /sys/block/hda/queue symlinked to them.
> 

Well here is more crap then...

kobjects corresponding to /sys/class/tty/* and /sys/class/net/* have the
same kset (i.e class_obj) but totally different attributes. There is no
way to find the attributes given a kobject belonging to lets say 
/sys/class/net/eth0 except through the hierarchy maintained in pinned sysfs 
dentries.


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
