Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbVCJUga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbVCJUga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbVCJUde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:33:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:24714 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263123AbVCJUbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:31:32 -0500
Date: Thu, 10 Mar 2005 12:31:12 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Netdev <netdev@oss.sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       stable@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] 2.6.x net driver oops fixes
Message-ID: <20050310203112.GA20337@kroah.com>
References: <422F59E8.2090707@pobox.com> <20050310202548.GV5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310202548.GV5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 12:25:48PM -0800, Chris Wright wrote:
> * Jeff Garzik (jgarzik@pobox.com) wrote:
> 
> > This will update the following files:
> > 
> >  drivers/net/sis900.c    |   41 +++++++++++++++++++++--------------------
> >  drivers/net/via-rhine.c |    3 +++
> 
> The via-rhine fix is already in the stable queue.  But the sis900 oops
> fix does not apply to the stable tree.  It relies on a few intermediate
> patches.  Appears to still be an issue for the older version which is in
> 2.6.11.  Here's a stab at a backport.  Would you like to review/validate
> or drop this one?

The pci_name() portion of this patch is not necessary for the -stable
tree.  Care to remove it?

thanks,

greg k-h
