Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbTFSVR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbTFSVR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:17:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51122 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265796AbTFSVR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:17:56 -0400
Date: Thu, 19 Jun 2003 14:31:09 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@osdl.org>, Mike Anderson <andmike@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030619213109.GB5644@kroah.com>
References: <Pine.LNX.4.44.0306190946440.955-100000@cherise> <Pine.LNX.4.44L0.0306191433140.1445-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0306191433140.1445-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 05:14:42PM -0400, Alan Stern wrote:
> 
> So what Mike says the SCSI core does, and what Pat says it ought to do, 
> isn't what actually happens.  Is this simply an indication that the work 
> of completing the SCSI code to the driver model isn't yet complete?  It 
> seems as though a very large change would be needed to make things work as 
> Pat described.

I think it's more of the matter that Mike is still changing the way the
SCSI core works with the class and driver model.  I suggest you take
this to the linux-scsi list to hash out the way scsi should and does
work in order to find the best solution for usb-storage, as I guess that
it also would be the best solution for all other SCSI host drivers.

> In the meantime, where should I register my class device for the 
> usb-storage driver?

Why not hold off until the scsi people are finished with their changes?
If after that, you _really_ need to be putting usb-storage only
attributes in the sysfs tree somewhere, we can talk again.

thanks,

greg "scsi makes my head hurt" k-h
