Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUGCUhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUGCUhG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 16:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUGCUhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 16:37:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:57306 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265249AbUGCUhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 16:37:03 -0400
Date: Sat, 3 Jul 2004 13:35:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, olaf+list.linux-kernel@olafdietsche.de
Subject: Re: procfs permissions on 2.6.x
Message-Id: <20040703133556.44b70d60.akpm@osdl.org>
In-Reply-To: <20040703202541.GA11398@infradead.org>
References: <20040703202242.GA31656@MAIL.13thfloor.at>
	<20040703202541.GA11398@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Jul 03, 2004 at 10:22:42PM +0200, Herbert Poetzl wrote:
> > 
> > Hi Andrew!
> > 
> > stumbled over the following detail ...
> > 
> > usually when somebody tries to modify an inode,
> > notify_change() calls inode_change_ok() to verify
> > the user's permissions ... now it seems that
> > somewhere around 2.5.41, a patch similar to this
> > one was included into the mainline, and remained
> > almost unmodified ...
> > 
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.1/1002.html
> > 
> > this probably unintentionally circumvents the 
> > inode_change_ok() check, so that now any user
> > can modify inodes of the procfs. 
> > 
> > example:
> > 
> >   $ chmod a-rwx /proc/cmdline
> > 
> > the following patch hopefully fixes this, so
> > please consider for inclusion ...
> 
> Actually the patch you reference above looks extremly bogus and should just
> be reverted instead.

Why is it "extremely bogus"?  I assume Olaf had a reason for wanting chmod
on procfs files?

