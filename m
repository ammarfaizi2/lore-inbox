Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWGZGYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWGZGYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWGZGYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:24:54 -0400
Received: from tara2.wa.amnet.net.au ([203.161.126.21]:19901 "EHLO
	tara2.wa.amnet.net.au") by vger.kernel.org with ESMTP
	id S1030314AbWGZGYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:24:53 -0400
Date: Wed, 26 Jul 2006 14:24:48 +0800
From: Michael Deegan <michael@ucc.gu.uwa.edu.au>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: BUG: __d_find_alias went POP! (was: BUG: lock held at task exit time!)
Message-ID: <20060726062447.GC3874@wibble>
References: <20060722032533.GZ3874@wibble> <1153885899.4017.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153885899.4017.21.camel@localhost.localdomain>
X-Subliminal-Message: .yenom em dneS .tsixe ton od segassem lanimilbuS
X-ICQ-UIN: 562440
X-Random-Number: 1.1108622248584e-227
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: michael@wibble
X-SA-Exim-Scanned: No (on localhost.localdomain); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 11:51:39PM -0400, Steven Rostedt wrote:
> Actually the lock held at exit time was caused by the BUG, it wasn't the
> bug itself.  Seems you got a bad pointer which killed a task that
> happened to be holding a lock.  And that's why you got the bug from your
> subject.

I had initially been wondering if something in an error path forgot to
clean things up correctly, but I guess there are valid circumstances where
such cleanups don't get to happen...

> It looks like there was something fishy going on in __d_find_alias (like
> a corrupted inode?).  Don't know for sure but since this looks like it's
> splice related or something wrong with general VFS, I CC'd Al Viro, and
> since it came from ext3, I CC'd Stephen Tweedie and the ext2-devel list.
> 
> Could a corrupted filesystem cause this oops?

I'm afraid the problem was likely caused by bad RAM, as some time yesterday
the machine hung hard, and upon restart failed POST. The machine was fine
after removing the dud 32M SIMM.

Sorry for the bother,

-MD

-- 
-------------------------------------------------------------------------------
Michael Deegan           Hugaholic          http://wibble.darktech.org/gallery/
------------------------- Nyy Tybel Gb Gur Ulcabgbnq! -------------------------
