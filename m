Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVBOWPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVBOWPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVBOWO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:14:59 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:16259 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261915AbVBOWOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:14:49 -0500
Subject: Re: Pty is losing bytes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0502151129210.5570@ppc970.osdl.org>
References: <jebramy75q.fsf@sykes.suse.de>
	 <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
	 <Pine.LNX.4.58.0502151129210.5570@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108505601.4915.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Feb 2005 22:13:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-02-15 at 19:44, Linus Torvalds wrote:
> However, then when I start looking at n_tty_receive_room() and 
> n_tty_receive_buf(), my stomach gets a bit queasy. I have this horrid 
> feeling that I had something to do with the mess, but I'm going to lash 

You did.
Then Ted tided it up
Then Bill added hacks to "fix" up the locking

The real fix is shooting the flip buffers, at that point a lot of the
locking goes away (because the tty owns everything relevant). I just
don't have time to do major kernel hacking and finish the MBA thesis at
the same time.

Sorry yes I know how n_tty works, and no I'm not going to fix it

