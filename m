Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbUKLVbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbUKLVbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbUKLVaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:30:35 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:60288 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262621AbUKLVaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:30:22 -0500
Date: Fri, 12 Nov 2004 12:49:25 -0800
From: Greg KH <greg@kroah.com>
To: Milton Miller <miltonm@bga.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: sysfs backing store error path confusion
Message-ID: <20041112204925.GE1711@kroah.com>
References: <200411050749.iA57nXlP076996@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411050749.iA57nXlP076996@sullivan.realtime.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 01:49:34AM -0600, Milton Miller wrote:
> 
> On Nov 3, 2004, at 3:42 PM, Greg KH wrote:
> 
> |On Tue, Nov 02, 2004 at 10:03:34AM -0600, Maneesh Soni wrote:
> ||On Tue, Nov 02, 2004 at 02:46:58AM -0600, Milton Miller wrote:
> |||sysfs_new_dirent returns ERR_PTR(-ENOMEM) if kmalloc fails but the callers
> |||were expecting NULL.  
> ||
> ||Thanks for spotting this. But as you said, I will prefer to change the callee.
> ||How about this patch? 
> ..
> ||-		return -ENOMEM;
> ||+		return NULL;
> |
> |Actually, this needs to be a 0, not NULL, otherwise the compiler
> |complains with a warning.  I've fixed it up and applied it.
> |
> |thanks,
> |
> |greg k-h
> 
> I wondered why greg thought the type was wrong.   After it was merged I 
> realized that the wrong function was changed.  Here's an attempt to fix
> both errors.
> 
> milton

Applied, thanks.

greg k-h
