Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUBPQxh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265700AbUBPQxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:53:37 -0500
Received: from mail.shareable.org ([81.29.64.88]:17284 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265661AbUBPQxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:53:36 -0500
Date: Mon, 16 Feb 2004 16:53:29 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christophe Saout <christophe@saout.de>,
       LKML <linux-kernel@vger.kernel.org>, pavel@suse.cz
Subject: Re: kthread, signals and PF_FREEZE (suspend)
Message-ID: <20040216165329.GB17323@mail.shareable.org>
References: <1076890731.5525.31.camel@leto.cs.pocnet.net> <20040216034251.0912E2C0F8@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216034251.0912E2C0F8@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> > That means that signal_pending() will return true for that process which
> > will make kthread stop the thread.
> 
> Yes, the way they are currently coded.  I had assumed that spurious
> signals do not occur.

Yowch.  Does suspend mean this warning in futex_wait is wrong?

	/* A spurious wakeup should never happen. */
	WARN_ON(!signal_pending(current));
	return -EINTR;

-- Jamie
