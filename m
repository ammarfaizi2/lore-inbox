Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267759AbUJGSqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267759AbUJGSqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267740AbUJGSp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:45:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:36314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267748AbUJGSmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:42:36 -0400
Date: Thu, 7 Oct 2004 11:40:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: jmorris@redhat.com, serue@us.ibm.com, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] lsm: add bsdjail module
Message-Id: <20041007114039.6e861b2b.akpm@osdl.org>
In-Reply-To: <20041007090645.U2357@build.pdx.osdl.net>
References: <20041007040859.GA17774@escher.cs.wm.edu>
	<Xine.LNX.4.44.0410070216130.2191-100000@thoron.boston.redhat.com>
	<20041006232208.505ccacd.akpm@osdl.org>
	<20041007090645.U2357@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Andrew Morton (akpm@osdl.org) wrote:
> > James Morris <jmorris@redhat.com> wrote:
> > > On Thu, 7 Oct 2004, Serge E. Hallyn wrote:
> > > 
> > >  > Because it gives Linux a functionality like FreeBSD's jail and Solaris'
> > >  > zones in an unobtrusive manner, without impacting users who don't wish
> > >  > to use it  (except for the extra security_task_lookup function calls).
> > > 
> > >  Yes, as an LSM module, it can be configured out.  I think it's a good use
> > >  of the LSM framework, and may be useful for people migrating to Linux from
> > >  legacy Solaris and FreeBSD.
> > 
> > Sure, but that's a bit speculative for adding a feature to the mainline
> > kernel.
> 
> Which feature are you concerned over, the additional hook or the
> new module?

I am concerned about the presence of new code - simple as that.

We need to be able to demonstrate that the new code is sufficiently useful
to a sufficiently large number of people as to warrant the cost of
maintaining it in the tree for the rest of eternity.

>  The module is a no-op for anybody who doesn't want it.

It still needs to be maintained.

> I can't vouch for the number of users of this module although I've seen
> some positive feedback from users.  One nice bit is that it goes a way
> towards helping vserver which does have quite a few users.

Tell us more.

>  This module
> really demonstrates one of the points of LSM...to support multiple
> security models.

Sure.  But that doesn't mean that those modules have to live at kernel.org
rather than, say, at bsdjail.sourceforge.net.

