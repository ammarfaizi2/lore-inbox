Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTFKRDV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTFKRDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:03:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48845 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263077AbTFKRDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:03:19 -0400
Date: Wed, 11 Jun 2003 10:18:55 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in driver model class.c
Message-ID: <20030611171855.GA25304@kroah.com>
References: <Pine.LNX.4.44L0.0306111305300.668-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0306111305300.668-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:12:47PM -0400, Alan Stern wrote:
> Greg:
> 
> There is a bug in drivers/base/class.c in 2.5.70.  Near the start of the
> routine class_device_add() are the lines
> 
>         if (class_dev->dev)
>                 get_device(class_dev->dev);
> 
> But there's nothing to undo this get_device, either in the error return 
> part of class_device_add() or in class_device_del().
> 
> I assume that either this get_device() doesn't belong there or else there
> should be corresponding put_device() calls in the other two spots.  
> Whichever is the case, it should be easy for you to fix.

Already fixed in Linus's -bk tree :)

thanks for pointing it out though.

greg k-h
