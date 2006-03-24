Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422767AbWCXMi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422767AbWCXMi5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422762AbWCXMi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:38:57 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:29669 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422741AbWCXMi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:38:56 -0500
Message-ID: <4423E853.1040707@garzik.org>
Date: Fri, 24 Mar 2006 07:38:43 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>, ian.pratt@cl.cam.ac.uk,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>	 <4421D943.1090804@garzik.org> <1143202673.18986.5.camel@localhost.localdomain>
In-Reply-To: <1143202673.18986.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2006-03-22 at 18:09 -0500, Jeff Garzik wrote:
>> An IBM hypervisor on ppc64 communicates uses SCSI RPC messages.  I think 
>> this would be quite nice for Xen, because SCSI (a) is a message-based 
>> model, and (b) implementing block using SCSI has a very high Just 
>> Works(tm) value which cannot be ignored.  And perhaps (c) SCSI target 
>> code already exists, so implementing the server side doesn't require 
>> starting from scratch, but rather simply connecting the Legos.
> 
> A pure SCSI abstraction doesn't allow for shared head scheduling which
> you will need to scale Xen sanely on typical PC boxes.

Not true at all.  If you can do it with a block device, you can do it 
with a SCSI block device.

In fact, SCSI should make a few things easier, because the notion of 
host+bus topology is already present, and notion of messaging is already 
present, so you don't have to recreate that in a Xen block device 
infrastructure.


> SCSI emulations
> are also always full of bits people got wrong, often critical bits like
> tagged queues and error sequences - things that break your journalled
> file system.

This I'll grant you.

	Jeff



