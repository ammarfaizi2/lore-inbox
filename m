Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbTDUUol (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbTDUUol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:44:41 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:23767 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261962AbTDUUog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:44:36 -0400
Date: Mon, 21 Apr 2003 16:56:37 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
In-Reply-To: <1050957875.1224.2.camel@flat41>
Message-ID: <Pine.LNX.4.55.0304211647270.2742@marabou.research.att.com>
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com> 
 <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de> 
 <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com> 
 <20030421210020.A29421@lst.de>  <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
  <20030421215637.A30019@lst.de>  <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
 <1050957875.1224.2.camel@flat41>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, Grzegorz Jaskiewicz wrote:

> you must mount devpts in /dev/pts

It is mounted, in case if you missed the beginning of the discussion.

> and change inittab :
> [snip]
> # Note that on most Debian systems tty7 is used by the X Window System,
> # so if you want to add more getty's go ahead but skip tty7 if you run
> X.
> #
> 1:2345:respawn:/sbin/getty 38400 /dev/vc/1

But I don't have /dev/vc/1 because ...

> > The only entry under /dev/vc is /dev/vc/0.  /dev/tts is missing.

This was caused by Christoph's patch he posted in this thread.  I'm not
familiar with internals of devfs and character devices.  I'm just trying
to help Christoph to come to the right solution.

-- 
Regards,
Pavel Roskin
