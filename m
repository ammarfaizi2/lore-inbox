Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVBYVtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVBYVtM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVBYVq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:46:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:4783 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261923AbVBYVo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:44:56 -0500
Date: Fri, 25 Feb 2005 13:41:54 -0800
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] I2C patch 2 - break up the SMBus formatting
Message-ID: <20050225214154.GB27270@kroah.com>
References: <421E62DD.5030608@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E62DD.5030608@acm.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 05:27:25PM -0600, Corey Minyard wrote:
> This is one in a series of patches for adding a non-blocking interface 
> to the I2C driver for supporting the IPMI SMBus driver.

> This patch reorganizes the formatting code to  make it more
> suitable for the upcoming non-blocking changes.  It also adds
> an op queue entry that is used to pass data around (for now)
> and will be used for queueing in the non-blocking case.

Hm, ick.  Can you break this up into 2 pieces?  One that reorders the
formatting of the code, and then one that adds the new functionality?
Otherwise it's very hard to follow the changes that are happening in
here.

thanks,

greg k-h
