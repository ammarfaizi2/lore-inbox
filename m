Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVFLTp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVFLTp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVFLT2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:28:15 -0400
Received: from [81.2.110.250] ([81.2.110.250]:40915 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262669AbVFLS2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 14:28:08 -0400
Subject: Re: MMC ioctl or sysfs interface?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <42AC7BD4.9040906@drzeus.cx>
References: <42A83F59.7090509@drzeus.cx>
	 <101040.57feb9cd101d268ffd2ffe2d314867d3.ANY@taniwha.stupidest.org>
	 <42A9FF79.1010003@drzeus.cx>
	 <1118444435.5213.72.camel@localhost.localdomain>
	 <42AC7BD4.9040906@drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118600720.9949.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Jun 2005 19:25:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-06-12 at 19:15, Pierre Ossman wrote:
> Alan Cox wrote:
> I wasn't aware that you could do ioctl on sysfs nodes. I guess I'll have
> to dig a bit deeper in the documentation/code.

You can add support, but you'll need a device node one day anyway so you
might as well give up on the sysfs only game - it doesn't IMHO work.

> As for keeping the same ioctl. If the current ioctls are similar enough
> then I don't see why not. The userspace tools might need changing though
> since all ATA ioctls won't be available. What tool is used for locking
> an ATA drive? And is there some documentation detailing the lock
> commands and related ioctls so I can compare with what I'm trying to do?

Right now for ATA you issue a taskfile ioctl, for SCSI you use SG_IO and
applications are not presented with any uniformity.

