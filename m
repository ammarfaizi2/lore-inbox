Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbULPBgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbULPBgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbULPBSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:18:10 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:3523 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262578AbULPAv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:51:27 -0500
Date: Wed, 15 Dec 2004 16:51:16 -0800
From: Greg KH <greg@kroah.com>
To: wendy xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 kernel] src/linux/drivers/serial: new serial driver
Message-ID: <20041216005116.GA10319@kroah.com>
References: <41C089DD.1040208@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C089DD.1040208@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 07:00:45PM +0000, wendy xiong wrote:
> Hi All,
> 
> We are submiting a new serial driver for the 2.6 kernel. This device 
> driver is for the Digi Neo serial port adapter.
> 
> We made some changes based on great comments from linux community. We 
> used the Russell's serial_core interface, handled all initilization of 
> module correctly and used fs/seq_file.c interface for /proc entry.
> 
> I put the driver on our website:
> http://www-124.ibm.com/linux/patches/?patch_id=1672

As per Documentation/SubmittingPatches, patches need to have a
"Signed-off-by:" line in them.  And they should be posted inline if
possible.  If not possible, care to split it up into smaller pieces?

There seems to be a few places in the patch that have whitespace messed
up (spaces instead of tabs), and you do a number of printk() calls
without a KERN_ level.  Also, the coding style for the function comments
is pretty atrocious, care to fix that up to be sane?

And, why not use msleep() instead of rolling your own?

Your Makefile seems a bit odd, why are you doing it that way?

More comments when the patch is posted to the list, to make it easier to
respond to.

thanks,

greg k-h
