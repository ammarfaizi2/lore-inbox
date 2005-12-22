Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVLVXv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVLVXv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVLVXv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:51:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:51632 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751082AbVLVXv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:51:26 -0500
Date: Thu, 22 Dec 2005 15:51:01 -0800
From: Greg KH <greg@kroah.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, mbligh@google.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH] pci device ensure sysdata initialised
Message-ID: <20051222235101.GA2826@kroah.com>
References: <20051220151609.565160d9.akpm@osdl.org> <20051222210628.GA16797@shadowen.org> <20051222231843.GB1943@kroah.com> <43AB3A1C.5070606@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43AB3A1C.5070606@shadowen.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 11:43:24PM +0000, Andy Whitcroft wrote:
> Greg KH wrote:
> 
> > Yeah, but this patch is just papering over that fact :(
> > 
> > In fact, you will not put these devices on the proper node with this
> > patch, right?  So I don't think it is what you want.
> 
> If there is ACPI information for the machine I believe it will put them
> in the correct nodes; otherwise it behaves as we did in -mm1, in that
> they are not correctly located.

Well, why not properly locate them?  That's my point :)

It seems you just put a default sysdata on a few places in the tree,
which fixed your boot problems.  I'm thinking that isn't fixing the root
issue here of not probing the pci devices properly on these boxes.  Does
that make more sense?

thanks,

greg k-h
