Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266335AbUAHUpp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 15:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUAHUpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 15:45:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:17078 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266335AbUAHUpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 15:45:43 -0500
Date: Thu, 8 Jan 2004 12:19:20 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Inconsistency in sysfs behavior?
Message-ID: <20040108201920.GB16183@kroah.com>
References: <Pine.LNX.4.44L0.0401071039150.850-100000@ida.rowland.org> <20040107172750.GC31177@kroah.com> <20040108103242.GA2267@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108103242.GA2267@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 04:02:42PM +0530, Maneesh Soni wrote:
>                                                                                 
> The problem is that we have live references to the kobject dentry but 
> kobject is gone. Problems can occur if kobject is accessed
> through dentry->d_fsdata field. The fix I did was to take a ref. to the
> kobject while linking the dentry with the kobject in create_dir(). This
> ref. can be released when dentry ref. count goes to zero, that is when
> dentry is being freed, through dentry->d_op->d_iput() call. With this
> patch we can have a kobject alive during the life time of the corresponding
> dentry. 
> 
> Please comment.

This is the patch already in the -mm tree, right?  I think it's already
in Pat's pending queue of patches to send off (we're a bit hampered by
the weather right now in this part of the world...)

thanks,

greg k-h
