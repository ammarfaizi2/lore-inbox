Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265394AbTF1Tx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbTF1Tx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:53:29 -0400
Received: from mail.gmx.de ([213.165.64.20]:5531 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265394AbTF1Tx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:53:28 -0400
Date: Sat, 28 Jun 2003 23:07:43 +0300
From: Dan Aloni <da-x@gmx.net>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: [TRIVIAL] avoid Oops in net/core/dev.c
Message-ID: <20030628200743.GA19658@callisto.yi.org>
References: <20030628083810.GA2793@callisto.yi.org> <20030628194102.GA2384@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030628194102.GA2384@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 12:41:02PM -0700, Greg KH wrote:
> On Sat, Jun 28, 2003 at 11:38:10AM +0300, Dan Aloni wrote:
> > 
> > BTW2, the attempt to rename the device here doesn't affect
> > sysfs. Patrick, we need a class_device_* interface that does 
> > this.
> 
> That's a good idea (I'm the person to blame for the class_device code,
> not Pat.)  Care to send a patch?

I have no patch, but I thought of either using lookup_one_len() 
and then d_move() to create a new dentry or to rip out some 
code out of vfs_rename_dir(). Anyway, I'm no VFS expert, so 
no patch any time soon.

-- 
Dan Aloni
da-x@gmx.net
