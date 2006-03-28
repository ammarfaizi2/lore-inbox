Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWC1XV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWC1XV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWC1XV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:21:27 -0500
Received: from smtp18.wanadoo.fr ([193.252.22.126]:5471 "EHLO
	smtp18.wanadoo.fr") by vger.kernel.org with ESMTP id S964821AbWC1XV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:21:26 -0500
X-ME-UUID: 20060328232125188.2DDF4700008E@mwinf1806.wanadoo.fr
Date: Wed, 29 Mar 2006 01:21:22 +0200
From: Thierry Godefroy <thgodef@nerim.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in Linux 2.6.16/2.6.16.1 (compilation failure of third
 party software)
Message-Id: <20060329012122.0c533fc6.thgodef@nerim.net>
In-Reply-To: <1143586271.11792.118.camel@mindpipe>
References: <20060328202905.18cb2cb0.thgodef@nerim.net>
	<1143586271.11792.118.camel@mindpipe>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.4; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 17:51:11 -0500, Lee Revell wrote:

> On Tue, 2006-03-28 at 20:29 +0200, Thierry Godefroy wrote:
> > Paragon_NTFS_3.x.v5.1 fails to compile (with gcc v3.4.3) with the following
> > errors:
> 
> It's not a bug when an upgrade causes third party kernel modules not to
> compile - your code needs to be updated to work with 2.6.16.

Oh, yeah ?... Really ?... Please, read the errors before drawing hasted conclusions...
The errors occur after the mere #inclusion of Linux headers. Here is a simple "code"
which will trigger the error:

#ifndef __KERNEL__
#define __KERNEL__
#endif

#include <linux/module.h>

int main() {
	return 0;
}

And I don't see anything wrong in that code...

> Linux makes no effort to guarantee source or binary compatibility with
> out of tree kernel modules, or userspace code that includes kernel
> headers.

That's a pity... Non-regression should be guaranteed. The problem with Linux
is that each new version brings a load of incompatibilities with third parties
drivers (graphic cards, win/smart modems, wifi cards, etc, etc), most of which
using proprietary code which sources are unavailable to the end user. The fact
that Linux keeps breaking those drivers code is not going to encourage hardware
vendors to make Linux drivers for their products. For example, ATI takes a
couple of months to catchup with the kernel changes, and each time they release
a new driver the next Linux release breaks it. :-(

Thierry Godefroy.

