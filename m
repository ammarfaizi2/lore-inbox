Return-Path: <linux-kernel-owner+w=401wt.eu-S1751964AbXAQAqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbXAQAqd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 19:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbXAQAqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 19:46:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:41812 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbXAQAqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 19:46:32 -0500
Date: Tue, 16 Jan 2007 16:45:49 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kay Sievers <kay.sievers@novell.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Driver core: fix refcounting bug
Message-ID: <20070117004549.GA18335@kroah.com>
References: <Pine.LNX.4.44L0.0701081103530.4249-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0701081103530.4249-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 11:06:44AM -0500, Alan Stern wrote:
> This patch (as832) fixes a newly-introduced bug in the driver core.
> When a kobject is assigned to a kset, it must acquire a reference to
> the kset.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> The bug was introduced in Kay's "unify /sys/class and /sys/bus at 
> /sys/subsystem" patch.
> 
> I left the assignment of class_dev->kobj.parent as it was, although it is 
> not needed.  The following call to kobject_add() will end up doing the 
> same thing.
> 
> Alan Stern
> 
> P.S.: Tracking down refcounting bugs is a real pain!  I spent an entire 
> afternoon on this one...  :-(

Thanks, I've merged your patch with the one from Kay so we don't
introduce a bug along the way.

greg k-h
