Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263270AbUKUH0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbUKUH0x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 02:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbUKUH0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 02:26:53 -0500
Received: from pop.gmx.net ([213.165.64.20]:52908 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263270AbUKUH0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 02:26:50 -0500
X-Authenticated: #8922711
From: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Kernel thoughts of a Linux user
Date: Sat, 20 Nov 2004 11:31:12 +0100
User-Agent: KMail/1.6.82
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411201131.12987.gjwucherpfennig@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Nov 18, 2004 at 06:59:27PM +0100, Gerold J. Wucherpfennig wrote:
> > 
> > - Make sysfs optional and enable to publish kernel <-> userspace data
> > especially the kernel's KObject data across the kernel's netlink interface 
as
> > it has been summarized on www.kerneltrap.org. This will avoid the
> > deadlocks sysfs does introduce when some userspace app holds an open file
> > handle of an sysfs object (KObject) which is to be removed. An importrant 
side 
> > effect for embedded systems will be that the RAM overhead introduced by 
sysfs
> > will vaporize.
> 
> What RAM overhead?  With 2.6.10-rc2 the memory footprint of sysfs has
> been drasticly shrunk.

Sorry I my kernel knowledge only consists of kerneltrap.org news :-(
I didn't knew that.
 
> 
> What deadlocks are you referring to?
> 


I don't know if it are deadlocks, please read last years article from lwn:
http://lwn.net/Articles/36850/


> And the netlink interface for hotplug events is already present in the
> latest kernel.

I don't know much about netlink. But sysfs --> libsysfs --> hal --> dbus
seems to be a lot of an overhead. Maybe create an in-kernel queue
for hardware information requests and publish the hardware information
with netlink would be a little less overhead??? Just a though...

