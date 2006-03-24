Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWCXPtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWCXPtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWCXPtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:49:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58776 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751130AbWCXPtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:49:10 -0500
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>, ian.pratt@cl.cam.ac.uk,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4423E853.1040707@garzik.org>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
	 <4421D943.1090804@garzik.org>
	 <1143202673.18986.5.camel@localhost.localdomain>
	 <4423E853.1040707@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Mar 2006 15:55:27 +0000
Message-Id: <1143215728.18986.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-03-24 at 07:38 -0500, Jeff Garzik wrote:
> > A pure SCSI abstraction doesn't allow for shared head scheduling which
> > you will need to scale Xen sanely on typical PC boxes.
> 
> Not true at all.  If you can do it with a block device, you can do it 
> with a SCSI block device.

I don't believe this is true. The complexity of expressing sequences of
command ordering between virtual machines acting in a co-operative but
secure manner isn't as far as I can see expressable sanely in SCSI TCQ
> 
> In fact, SCSI should make a few things easier, because the notion of 
> host+bus topology is already present, and notion of messaging is already 
> present, so you don't have to recreate that in a Xen block device 
> infrastructure.

Those are the easy bits. 

> > are also always full of bits people got wrong, often critical bits like
> > tagged queues and error sequences - things that break your journalled
> > file system.
> 
> This I'll grant you.

And every one you get wrong is a corruptor....

Alan

