Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUJGTAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUJGTAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUJGSyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:54:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:14562 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267607AbUJGSwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:52:41 -0400
Date: Thu, 7 Oct 2004 11:52:40 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, jmorris@redhat.com, serue@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] lsm: add bsdjail module
Message-ID: <20041007115240.C2357@build.pdx.osdl.net>
References: <20041007040859.GA17774@escher.cs.wm.edu> <Xine.LNX.4.44.0410070216130.2191-100000@thoron.boston.redhat.com> <20041006232208.505ccacd.akpm@osdl.org> <20041007090645.U2357@build.pdx.osdl.net> <20041007114039.6e861b2b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041007114039.6e861b2b.akpm@osdl.org>; from akpm@osdl.org on Thu, Oct 07, 2004 at 11:40:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> > * Andrew Morton (akpm@osdl.org) wrote:
> > Which feature are you concerned over, the additional hook or the
> > new module?
> 
> I am concerned about the presence of new code - simple as that.

Understood.

> We need to be able to demonstrate that the new code is sufficiently useful
> to a sufficiently large number of people as to warrant the cost of
> maintaining it in the tree for the rest of eternity.

That's fine.  Serge, can you enlighten us with an idea of the users of
this code?

> >  The module is a no-op for anybody who doesn't want it.
> 
> It still needs to be maintained.

Absolutely.

> > I can't vouch for the number of users of this module although I've seen
> > some positive feedback from users.  One nice bit is that it goes a way
> > towards helping vserver which does have quite a few users.
> 
> Tell us more.

One portion of the vserver project (that which has to do with security
and isolation) could be largely covered by this work.  And vserver
is an active project with many users AFAICT.  The vserver maintainer
has expressed some interest in this as well.  The other portion of the
project, which does the resource limiting has a decent chance of working
well with something like CKRM or similar.

> >  This module
> > really demonstrates one of the points of LSM...to support multiple
> > security models.
> 
> Sure.  But that doesn't mean that those modules have to live at kernel.org
> rather than, say, at bsdjail.sourceforge.net.

I agree, some userbase does wonders to justify mainlining the code.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
