Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbULVBjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbULVBjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 20:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbULVBjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 20:39:04 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:120 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261938AbULVBjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 20:39:01 -0500
Subject: Re: My vision of usbmon
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       linux-usb-devel@lists.sourcefoge.net.kroah.org,
       linux-kernel@vger.kernel.org, laforge@gnumonks.org
In-Reply-To: <20041222005726.GA13317@kroah.com>
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan>
	 <20041222005726.GA13317@kroah.com>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 12:38:54 +1100
Message-Id: <1103679534.5055.2.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-21 at 16:57 -0800, Greg KH wrote:
> On Sun, Dec 19, 2004 at 11:04:54PM -0800, Pete Zaitcev wrote:
> > Hi, Guys:
> > 
> > This is usbmon which I cooked up because I got tired from adding dbg()'s
> > and polluting my dmesg. I use it to hunt bugs in USB storage devices so
> > far, and it's useful, although limited at this stage.
> > 
> > I looked at the Harding's USBmon patch, and I think he got a few things right.
> > The main of them is that I underestimated the benefits of placing the special
> > files into the filesystem namespace. When we discussed it with Greg in the
> > airport, we decided that having some sort of Netlink-style socket would be
> > the best option. I decided to make a u-turn and attach those sockets into
> > the namespace (currently under /dbg, but it can change). What this buys us is:
> > 

Is there any reason why these debug filesystems are going under the
root directory? Why not /sys/debug or /sys/kernel/debug or something?

Nick


