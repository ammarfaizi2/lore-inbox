Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265057AbUEKXpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265057AbUEKXpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUEKXpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:45:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:57826 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265057AbUEKXpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:45:21 -0400
Date: Tue, 11 May 2004 16:39:38 -0700
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix dev_printk to work even in the absence of am attached driver
Message-ID: <20040511233938.GD27069@kroah.com>
References: <1082407198.1804.35.camel@mulgrave> <20040422220756.GA2479@kroah.com> <1084284048.2305.6.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084284048.2305.6.camel@mulgrave>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 09:00:47AM -0500, James Bottomley wrote:
> On Thu, 2004-04-22 at 17:07, Greg KH wrote: 
> > But doesn't this cause the string "(unbound)" to be created for every
> > dev_printk() call in the code?  I don't think gcc can optimize that very
> > well.  How about making a global string just for that, otherwise the
> > size police will come after me for adding such a patch :)
> 
> OK, I can't find an elegant way of making it global, so I think the best
> thing to do is just leave it blank for no driver (gcc can optimise that
> case). 

Ok, I can live with this, thanks.  Applied.

greg k-h
