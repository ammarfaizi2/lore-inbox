Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbUB0RHQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUB0RG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:06:58 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:19639 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263053AbUB0REf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:04:35 -0500
Date: Fri, 27 Feb 2004 17:02:46 +0000
From: Dave Jones <davej@redhat.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: S390 block devs on !s390.
Message-ID: <20040227170246.GC15016@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040227135728.GA15016@redhat.com> <403F7431.80608@backtobasicsmgmt.com> <20040227165826.GA9352@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227165826.GA9352@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 04:58:26PM +0000, Dave Jones wrote:

 >  > even a higher level one) with "if ARCH_S390"? All that does is add a 
 >  > "depends ARCH_S390" to everything in the file, but it would sure be a 
 >  > lot easier to maintain.
 > 
 > Sure, you force a bool to y if ARCH=S390 at the top.
 > That would work. Probably.

Or even easier..
(Seems to do the right thing on x86 and make menuconfig ARCH=s390

		Dave

--- linux-2.6.3/drivers/s390/block/Kconfig~	2004-02-27 17:00:07.000000000 +0000
+++ linux-2.6.3/drivers/s390/block/Kconfig	2004-02-27 17:00:27.000000000 +0000
@@ -1,3 +1,5 @@
+if ARCH_S390
+
 comment "S/390 block device drivers"
 	depends on ARCH_S390
 
@@ -62,3 +64,5 @@
 	  ioctl functions specific to the dasd driver.
 	  This is only needed if you want to use applications written for
 	  linux-2.4 dasd channel measurement facility interface.
+
+endif
