Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVC2FjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVC2FjU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 00:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVC2FjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 00:39:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:31192 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262344AbVC2Fit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 00:38:49 -0500
Date: Mon, 28 Mar 2005 21:05:55 -0800
From: Greg KH <greg@kroah.com>
To: Aaron Gyes <floam@sh.nu>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050329050555.GC7937@kroah.com>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com> <20050327181221.GB14502@kroah.com> <1112058277.14563.4.camel@localhost> <20050329033350.GA6990@kroah.com> <1112070511.32594.4.camel@localhost> <20050329044533.GG7362@kroah.com> <1112072487.27364.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112072487.27364.4.camel@localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 09:01:27PM -0800, Aaron Gyes wrote:
> On Mon, 2005-03-28 at 20:45 -0800, Greg KH wrote:
> > If after removed, that's not what udev is set up to do, sorry.
> 
> There's no way to either a) Hack udev.conf to always create a node with
> a certain major and minor

No.

> or b) A way to make sysfs trick udev?

 From userspace?  No.

> I'll kind of need to do this for nvidia and any other modules affected
> by this change, or else switch back to the inferior devfs.

I know debian provides a way for the udev startup script to create any
static device node that you want to have be created.  I suggest you look
at that as an example to do what you wish.

Also, vmware already supports using udev, yet it does not use sysfs.  It
does so by creating the device nodes in its startup script.  There is no
reason why you can't do the same thing in the nvidia driver.

thanks,

greg k-h
