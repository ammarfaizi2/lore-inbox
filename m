Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUBETjR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266192AbUBETjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:39:16 -0500
Received: from fmr09.intel.com ([192.52.57.35]:38825 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S266829AbUBETi5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:38:57 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Date: Thu, 5 Feb 2004 11:38:44 -0800
Message-ID: <33561BB7A415E04FBDC339D5E149C6E26C38FE@orsmsx405.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Thread-Index: AcPsGZjROImzXgQCRJWTJFQhgl26twABc3+g
From: "King, Steven R" <steven.r.king@intel.com>
To: "Greg KH" <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Cc: <infiniband-general@lists.sourceforge.net>
X-OriginalArrivalTime: 05 Feb 2004 19:38:45.0891 (UTC) FILETIME=[AB51C530:01C3EC1F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We just use the kernel's spin_lock_irqsave(), so I don't know what
you're talking about.

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Thursday, February 05, 2004 10:55 AM
To: King, Steven R; linux-kernel@vger.kernel.org
Cc: infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
the linux kernel


On Thu, Feb 05, 2004 at 10:27:54AM -0800, King, Steven R wrote:
> Hi Greg,
> What exactly is wrong with spinlock?  Far as I know, it's been working
> bug-free on a variety of platforms for quite some time now.  The other
> abstractions such as atomic_t are for platform portability.

Again, compare them to the current kernel spinlocks and try to realize
why your implementation of spinlock_irqsave() will not work on all
platforms.

Come on, just use the kernel versions, there is no need to reinvent the
wheel all of the time, it just wastes everyones time (including mine...)

thanks,

greg k-h
