Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263231AbUDUPgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUDUPgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 11:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbUDUPgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 11:36:47 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:50949 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263231AbUDUPga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 11:36:30 -0400
Date: Wed, 21 Apr 2004 23:39:44 +0800 (WST)
From: raven@themaw.net
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
In-Reply-To: <20040421155634.A6736@infradead.org>
Message-ID: <Pine.LNX.4.58.0404212315130.16711@donald.themaw.net>
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419202538.A15701@infradead.org>
 <Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au>
 <20040419182657.7870aee9.akpm@osdl.org> <20040421100835.A3577@infradead.org>
 <Pine.LNX.4.58.0404212035280.3740@donald.themaw.net> <20040421141901.B5551@infradead.org>
 <Pine.LNX.4.58.0404212135520.3740@donald.themaw.net> <20040421155634.A6736@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, Christoph Hellwig wrote:

> 
> If you ask me much of what autofs does should reside in the VFS, namely
> triggering userspace upcalls as soon someone enters a special trigger
> (aka delayed mountpount) directory and expiry of vfsmounts.
> 

That's am approach that I've not had the luxury of pondering till now.
I'll have to think about the potential of that for a while.

In the past I have thought that automount functionality is specialised 
enough to warrant seperation from the core VFS services. But now (after 
several months of consideration) I'm not sure that the functionality 
needed can be done without some general VFS support.

At the moment I think that if it was decided to add these services to 
the VFS then they would need to be general, not automount specific. As VFS 
services should be. But alas there are no clear requirements. For 
example, the recent proposal by Mike Waychison, although an excellent 
paper, requires a kernel expiry service but has no discussion of what is 
actually needed.

Sorry, I must be boring you with all this ranting.

Ian

