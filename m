Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTDUVLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTDUVLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:11:49 -0400
Received: from verein.lst.de ([212.34.181.86]:8209 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262186AbTDUVLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:11:47 -0400
Date: Mon, 21 Apr 2003 23:23:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Roskin <proski@gnu.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
Message-ID: <20030421232348.A30621@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com> <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de> <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com> <20030421210020.A29421@lst.de> <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com> <20030421215637.A30019@lst.de> <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com> <20030421225704.A30489@lst.de> <Pine.LNX.4.55.0304211709560.2913@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0304211709560.2913@marabou.research.att.com>; from proski@gnu.org on Mon, Apr 21, 2003 at 05:15:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 05:15:39PM -0400, Pavel Roskin wrote:
> On Mon, 21 Apr 2003, Christoph Hellwig wrote:
> >
> > The devfs <-> tty interaction are going to drive me nuts.
> >
> > TTY_DRIVER_NO_DEVFS actually means don't call tty_register_device
> > in tty_register_driver, not don't register with devfs.
> >
> > Updated patch (replaces the last one):
> 
> The old story again.  /dev/pts disappears when /dev/pts/0 is unregistered.
> "devfs_remove: no entry for pts!" appears on the next attempt to login by
> ssh.

And you are sure you have the following line in pty.c:

	pts_driver[i].flags |= TTY_DRIVER_NO_DEVFS;

?
