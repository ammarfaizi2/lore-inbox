Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbULVA6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbULVA6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbULVA6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:58:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:18099 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261932AbULVA57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:57:59 -0500
Date: Tue, 21 Dec 2004 16:57:26 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-usb-devel@lists.sourcefoge.net.kroah.org,
       linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: My vision of usbmon
Message-ID: <20041222005726.GA13317@kroah.com>
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041219230454.5b7f83e3@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2004 at 11:04:54PM -0800, Pete Zaitcev wrote:
> Hi, Guys:
> 
> This is usbmon which I cooked up because I got tired from adding dbg()'s
> and polluting my dmesg. I use it to hunt bugs in USB storage devices so
> far, and it's useful, although limited at this stage.
> 
> I looked at the Harding's USBmon patch, and I think he got a few things right.
> The main of them is that I underestimated the benefits of placing the special
> files into the filesystem namespace. When we discussed it with Greg in the
> airport, we decided that having some sort of Netlink-style socket would be
> the best option. I decided to make a u-turn and attach those sockets into
> the namespace (currently under /dbg, but it can change). What this buys us is:
> 
>  1. cat(1): never bet against it. It's too handy. And netcat is just
>     not the same.
>  2. USBmon userland in Java. Just try to hack in JNI a little as I have
>     and you'll see.

I agree, file interfaces are just too easy and simple to use.  Sorry for
sending you down the wrong track with the socket stuff.

> The architecture to support various output formats is present. Obvious
> candidates are Old USBmon format and a Binary format. But it's not done.

It looks great, thanks for doing this work.  Let me know when you want
it added to the kernel tree.

thanks,

greg k-h
