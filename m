Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVLDAYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVLDAYt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVLDAYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:24:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:37292 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932180AbVLDAYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:24:49 -0500
Date: Sat, 3 Dec 2005 16:20:46 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204002043.GA1879@kroah.com>
References: <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <4391CEC7.30905@unsolicited.net> <1133630012.6724.7.camel@localhost.localdomain> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de> <4391E52D.6020702@unsolicited.net> <20051203222731.GC25722@merlin.emma.line.org> <1133649261.5890.7.camel@mindpipe> <20051203225020.GF25722@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203225020.GF25722@merlin.emma.line.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 11:50:20PM +0100, Matthias Andree wrote:
> The point is, removing something that has worked well enough that some
> people had a reason to use it, is not "stable".

Please remember, no one is calling 2.6 "stable" anymore than they are
calling it "development".  The current development model is different
than what we used to do pre 2.6.  See the archives for details about
this if you want more information.

> Third, IF udev is so sexy but OTOH a real kernel-space devfs can be done
> in 200 LoC as has been claimed so often,

282 LoC:
 drivers/base/class.c   |    7 +
 fs/Kconfig             |    3 
 fs/Makefile            |    1 
 fs/ndevfs/Makefile     |    4 
 fs/ndevfs/inode.c      |  249 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/partitions/check.c  |    6 +
 include/linux/ndevfs.h |   13 ++
 7 files changed, 282 insertions(+), 1 deletion(-)

> why in hell is this not happening?

Because it's not the correct solution.

> Switch "broken bloaty bulky devfs" to "lean & clean devfs"?  This ship
> would have been flying the "clean-up nation" flags.

Again, because an in-kernel devfs is not the correct thing to do.  devfs
has been disabled for a few months now, and I don't think anyone has
missed it yet :)

thanks,

greg k-h
