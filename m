Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWEJQVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWEJQVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWEJQVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:21:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:4075 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964988AbWEJQVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:21:10 -0400
Date: Wed, 10 May 2006 17:21:06 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060510162106.GC27946@ftp.linux.org.uk>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com> <1147257266.17886.3.camel@localhost.localdomain> <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net> <1147273787.17886.46.camel@localhost.localdomain> <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net> <1147275571.17886.64.camel@localhost.localdomain> <1147275522.21536.109.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147275522.21536.109.camel@c-67-180-134-207.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 08:38:41AM -0700, Daniel Walker wrote:
> On Wed, 2006-05-10 at 16:39 +0100, Alan Cox wrote:
> > On Mer, 2006-05-10 at 08:06 -0700, Daniel Walker wrote:
> > > > Because while the warning is present people will check it now and again.
> > > 
> > > But it's pointless to review it, in this case and for this warning .
> > 
> > Then why did you review it ? 
> 
> So I wouldn't have to see that warning again ..
> 
> > It reminds people that it does need checking, and ensures now and then
> > people do check that there isn't actually a bug there.
> 
> I don't see a reason why it needs checking .. People are just going to
> spin their wheel reviewing code that's been reviewed .. Maybe someone
> like me will write a patch to fix this warning , and we'll see this
> process happening all over again ..

Don't.  Fix.  Correct.  Code.

Ever.  Because sooner or later you will paper over real bug.  It's far better
to reject patches that just make $TOOL to STFU than risk blind "fix" hiding
a real bug.

Unless you show a real codepath that leads to use without initialization
(and do that in commit message, so it could be verified as real issue),
these patches are worthless in the best case and dangerous in the worst
one.
