Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWCYKDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWCYKDV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 05:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWCYKDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 05:03:21 -0500
Received: from ozlabs.org ([203.10.76.45]:50581 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751116AbWCYKDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 05:03:20 -0500
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Chris Wright <chrisw@sous-sol.org>,
       xen-devel@lists.xensource.com,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org,
       ian.pratt@cl.cam.ac.uk, linux-kernel@vger.kernel.org
In-Reply-To: <1143215728.18986.15.camel@localhost.localdomain>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
	 <4421D943.1090804@garzik.org>
	 <1143202673.18986.5.camel@localhost.localdomain>
	 <4423E853.1040707@garzik.org>
	 <1143215728.18986.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 21:03:11 +1100
Message-Id: <1143280992.8228.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 15:55 +0000, Alan Cox wrote:
> On Gwe, 2006-03-24 at 07:38 -0500, Jeff Garzik wrote:
> > > A pure SCSI abstraction doesn't allow for shared head scheduling which
> > > you will need to scale Xen sanely on typical PC boxes.
> > 
> > Not true at all.  If you can do it with a block device, you can do it 
> > with a SCSI block device.
> 
> I don't believe this is true. The complexity of expressing sequences of
> command ordering between virtual machines acting in a co-operative but
> secure manner isn't as far as I can see expressable sanely in SCSI TCQ

I thought usb_scsi taught us that SCSI was overkill for a block
abstraction?  I have a much simpler Xen block-device implementation
which seems to perform OK, and is a lot less LOC than the in-tree one,
so I don't think the "SCSI would be better than what's there" (while
possibly true) is valid.

Cheers!
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

