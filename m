Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTI3VmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTI3VmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:42:14 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:49541 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S261776AbTI3VmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:42:12 -0400
Subject: Re: 2.6.0-test6: a few __init bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030930212551.GA20709@kroah.com>
References: <1064872693.5733.42.camel@dooby.cs.berkeley.edu>
	<20030929221113.GB2720@kroah.com>
	<1064946634.5734.106.camel@dooby.cs.berkeley.edu>
	<20030930191117.GA20054@kroah.com>
	<1064956854.5733.233.camel@dooby.cs.berkeley.edu> 
	<20030930212551.GA20709@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Sep 2003 14:42:09 -0700
Message-Id: <1064958129.5264.237.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 14:25, Greg KH wrote:
> Hm, good point.  Can you think of a better place for this that would
> have helped you out?

Take two.  It might not have prevented me from reporting the potential
bug, but I would've known you'd thought about it, it might help future
developers, and it's unlikely to become dangerously wrong.  Thanks.

Best,
Rob

--- drivers/pci/quirks.c.orig	Tue Sep 30 14:17:40 2003
+++ drivers/pci/quirks.c	Tue Sep 30 14:39:48 2003
@@ -750,6 +750,9 @@
 
 /*
  *  The main table of quirks.
+ *
+ *  Note: any hooks for hotpluggable devices in this table must _NOT_
+ *        be declared __init.
  */
 
 static struct pci_fixup pci_fixups[] __devinitdata = {


