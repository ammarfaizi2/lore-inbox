Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUAGXKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbUAGXKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:10:01 -0500
Received: from mail.kroah.org ([65.200.24.183]:46032 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262652AbUAGXJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:09:59 -0500
Date: Wed, 7 Jan 2004 14:34:11 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Inconsistency in sysfs behavior?
Message-ID: <20040107223411.GA2029@kroah.com>
References: <20040107215624.GC1083@kroah.com> <Pine.LNX.4.44L0.0401071712550.1589-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0401071712550.1589-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 05:24:08PM -0500, Alan Stern wrote:
> The real problem was finding a way to indicate that the file was
> disconnected from its kobject.  I did that by setting
> dentry->d_inode->i_mode to 0.  (I didn't want to erase dentry->d_fsdata
> for fear that it might be needed somewhere else.)  That's definitely not a
> good way; it was intended only for my proof-of-principle.  No doubt
> someone else could do a much better job.

Because this is the hardest part, it's easier just to have the behavior
we currently have :)

thanks,

greg k-h
