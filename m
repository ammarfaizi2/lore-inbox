Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263016AbVFXPRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbVFXPRp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVFXPRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:17:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:5336 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262985AbVFXPQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:16:33 -0400
Date: Fri, 24 Jun 2005 08:16:15 -0700
From: Greg KH <greg@kroah.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050624151615.GA29854@kroah.com>
References: <20050624081808.GA26174@kroah.com> <42BBFB55.3040008@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BBFB55.3040008@tls.msk.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 04:23:49PM +0400, Michael Tokarev wrote:

<snip>

I'll respond to your comments later, it's too early...

> A question.  I can't apply this to 2.6.12, it fails in
> drivers/base/class.c -- the main portion i think.  What's
> this patch against?

2.6.12-git5, sorry I should have mentioned that.

> And another question.  Why it isn't possible to use
> plain tmpfs for this sort of things?

What do you mean?  What's wrong with a ramfs based fs?  To use tmpfs
would require a lot more work.  But if you want to do it, I'll gladly
take patches :)

> Why to create another filesystem, instead of just using current
> tmpfs and call mknod/unlink on it as appropriate?

Um, that's about all that this code does.

> This same tmpfs can be used by udev too (to create that "policy"-based
> names), and it gives us all the directories and other stuff...

udev doesn't need a kernel specific fs.

thanks,

greg k-h
