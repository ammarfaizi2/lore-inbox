Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbVKSBfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbVKSBfc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbVKSBfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:35:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:33469 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161103AbVKSBfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:35:31 -0500
Date: Fri, 18 Nov 2005 17:20:10 -0800
From: Greg KH <greg@kroah.com>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about driver built-in kernel
Message-ID: <20051119012010.GC28175@kroah.com>
References: <08A354A3A9CCA24F9EE9BE13600CFBC501A31910@wcosmb07.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08A354A3A9CCA24F9EE9BE13600CFBC501A31910@wcosmb07.cos.agilent.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 05:18:34PM -0700, yiding_wang@agilent.com wrote:
> We have two driver modules to support our hardware for some
> applications. Both modules worked fine as loadable modules. Now I need
> to build both drivers in kernel 2.6.11-8. I have changed configuration
> file and make file. Both drivers are built OK with kernel together.

Have a pointer to the source for these drivers?

> 1, Because both drivers were loaded as module before, the entry point
> for both driver is "init_module()". Since both drivers are built in
> kernel, the entry name is conflicting. Changing one entry point name
> will make driver built OK. However, I am concerned that loading kernel
> will not pick up the driver with changed entry point name. What is the
> best way to handle this situation?

Make your init module function static, like all other kernel drivers.

> 2, One of built-in driver requires to be loaded before the second one.
> Because these two drivers are not belong to any existing group, such
> as network, scsi, where is the best place these two driver can be
> specified for loading sequence? I checked init.d and rc* files but did
> not figure out proper place to handle the requirement.

The linker specifies the loading order.

hope this helps,

greg k-h
