Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264095AbUESHJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUESHJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 03:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbUESHJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 03:09:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:41418 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264095AbUESHJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 03:09:05 -0400
Date: Wed, 19 May 2004 00:07:01 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use idr_get_new to allocate a bus id in drivers/i2c/i2c-core.c
Message-ID: <20040519070701.GB18660@kroah.com>
References: <20040515222632.GA7218@dsl.ttnet.net.tr> <20040515165812.7e771f20.akpm@osdl.org> <20040516091312.GA2052@tnn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516091312.GA2052@tnn.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 12:13:13PM +0300, Faik Uygur wrote:
> On Sat, 15 May 2004, Andrew Morton wrote:
> 
> > The IDR interface is a bit cumbersome.  Even though you called
> > idr_pre_get(), there's no guarantee that the memory which it preallocated
> > is still present when you call idr_get_new().
> 
> Thanks for the correction.
> 
> > Is the kernel likely to ever have so many bus IDs that we actually need
> > this patch?  Or do you specifically want first-fit-from-zero for some
> > reason?
> 
> Actually there is no special need for this. It is just what i think would
> be the expected behaviour. There was a thread two weeks ago about this issue:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108370586601550&w=2
> 
> here is the updated patch:

Nice, thanks, I've applied this to my trees.  I tried doing this same
patch a while ago, but missed the masking off the upper bits trick, and
was wondering why my results were so strange...

thanks again,

greg k-h
