Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267050AbUBRBAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266981AbUBRBAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:00:47 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:52232 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S267050AbUBRBAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:00:46 -0500
Date: Wed, 18 Feb 2004 09:02:06 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Rusty Russell <rusty@rustcorp.com.au>
cc: ia6432@inbox.ru, linux-kernel@vger.kernel.org, autofs@linux.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] nfs or autofs related hangs
In-Reply-To: <20040217183749.490777c5.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.58.0402180855400.11927@wombat.indigo.net.au>
References: <20040215222107.7E4382C2D8@lists.samba.org>
 <Pine.LNX.4.58.0402160910300.28358@wombat.indigo.net.au>
 <20040217183749.490777c5.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Rusty Russell wrote:

> On Mon, 16 Feb 2004 09:13:55 +0800 (WST)
> Ian Kent <raven@themaw.net> wrote:
> 
> > On Sun, 15 Feb 2004, Rusty Russell wrote:
> > > Is this __cacheline_aligned_in_smp really required?
> > 
> > I must admit I put this together without much thought with a "cut and 
> > paste".
> > 
> > But, please tell me. I'm not entirely clear on what conditions I 
> > should be concerned about blowing the cache.
> 
> You should usually try to declare the spinlock near the things it protects, in
> the hope that they'll be in the same cacheline.  If we blow 128 bytes for
> every spinlock, things will get slower, not faster.

Thanks. I'll take it out.

Do you mean near to the storage declaration. This lock is used in three 
places in the module within it's declared. Near the begining, the middle 
and near the end.

Ian

