Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUCJGiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 01:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUCJGiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 01:38:50 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:28321 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261468AbUCJGis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 01:38:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: evbug.ko
Date: Wed, 10 Mar 2004 01:38:36 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, "James H. Cloos Jr." <cloos@jhcloos.com>
References: <m3n06x4o0q.fsf@lugabout.jhcloos.org> <200403042238.13924.dtor_core@ameritech.net> <20040308213241.GE16396@kroah.com>
In-Reply-To: <20040308213241.GE16396@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403100138.41453.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 March 2004 04:32 pm, Greg KH wrote:
> On Thu, Mar 04, 2004 at 10:38:13PM -0500, Dmitry Torokhov wrote:
> > On Wednesday 03 March 2004 04:30 pm, James H. Cloos Jr. wrote:
> > > Any idea what might modprobe evbug.ko w/o operator intervention?
> > > 
> > 
> > It's new hotplug scripts. Put modules you do not want to be automatically
> > loaded even if they think they have hardware/facilities to bind to into
> > /etc/hotplug/blacklist
> > 
> > I, for example, have evbug, joydev, tsdev and eth1394 there.
> > 
> > Greg, any chance adding evbug to the default version of hotplug package?
> 
> Care to send me a patch for it?
> 
> thanks,
> 
> greg k-h
> 

Ok, here it is, against today's CVS..

--- admin/etc/hotplug/blacklist.orig	2004-03-10 00:51:59.000000000 -0500
+++ admin/etc/hotplug/blacklist	2004-03-10 00:53:30.000000000 -0500
@@ -18,3 +18,6 @@
 # At least 2.4.3 and later xircom_tulip doesn't have that conflict
 # xircom_tulip_cb
 dmfe
+
+#evbug is a debug tool and should be loaded explicitly
+evbug
