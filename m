Return-Path: <linux-kernel-owner+w=401wt.eu-S1762776AbWLKKnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762776AbWLKKnE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762779AbWLKKnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:43:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:37836 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762776AbWLKKnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:43:01 -0500
Date: Mon, 11 Dec 2006 16:13:06 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, <gregkh@suse.com>,
       <linux-usb-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: race in sysfs between sysfs_remove_file() and read()/write() #2
Message-ID: <20061211104306.GA22628@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20061204130406.GA2314@in.ibm.com> <Pine.LNX.4.44L0.0612041101410.3606-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0612041101410.3606-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 11:06:41AM -0500, Alan Stern wrote:
> On Mon, 4 Dec 2006, Maneesh Soni wrote:
> 
> > hmm, I guess Greg has to say the final word. The question is either to fail
> > the IO (-ENODEV) or fail the file removal (-EBUSY). If we are not going to
> > fail the removal then your patch is the way to go.
> >
> > Greg?
> 
> Oliver is right that we cannot allow device_remove_file() to fail.  In
> fact we can't even allow it to block until all the existing open file
> references are closed.
> 
> Our major questions have to do with the details of the patch itself.  In
> particular, we are worried about possible races with the VFS and the
> handling of the inode's usage count.  Can you examine the patch carefully
> to see if it is okay?
> 

Sorry for late reply.. I reviewed the patch and it looks ok me.

Thanks
Maneesh
