Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTDUTcF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTDUTcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:32:05 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:32467 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261876AbTDUTcE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:32:04 -0400
Date: Mon, 21 Apr 2003 15:44:07 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
In-Reply-To: <20030421210020.A29421@lst.de>
Message-ID: <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
 <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de>
 <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
 <20030421210020.A29421@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, Christoph Hellwig wrote:

> On Mon, Apr 21, 2003 at 02:53:54PM -0400, Pavel Roskin wrote:
> > On Mon, 21 Apr 2003, Christoph Hellwig wrote:
> >
> > > On Mon, Apr 21, 2003 at 07:55:55PM +0200, Christoph Hellwig wrote:
> > > > Could you please try this patch?
> > >
> > > Better this one :)  Sorry.
> >
> > No, it doesn't help, although the stack trace is different this time:
>
> Hmm.  Can you please apply the following patch in addition and
> see what the printk I added sais?

Following is happening.  The system boots, /dev/pts is a directory (I can
see it by logging on the serial console).  devpts is mounted on /dev/pts.

I log in by ssh.  It works.  /dev/pts/0 appears.  I log out.  /dev/pts
directory disappears!

I log in by ssh again.  I get this message on the console:

devfs_remove: no entry for pts!

ssh hangs.  I can recreate /dev/pts by mkdir, umount it and mount it
again.  Then ssh works again, but again only once.  /dev/pts disappears on
logout.

-- 
Regards,
Pavel Roskin
