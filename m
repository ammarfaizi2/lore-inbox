Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUEJXta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUEJXta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUEJXta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:49:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:30944 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262079AbUEJXtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:49:05 -0400
Date: Mon, 10 May 2004 16:51:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-Id: <20040510165132.5107472e.akpm@osdl.org>
In-Reply-To: <20040510233342.GA5614@taniwha.stupidest.org>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	<20040510223755.A7773@infradead.org>
	<20040510150203.3257ccac.akpm@osdl.org>
	<20040510231146.GA5168@taniwha.stupidest.org>
	<20040510162818.376b4a55.akpm@osdl.org>
	<20040510233342.GA5614@taniwha.stupidest.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> On Mon, May 10, 2004 at 04:28:18PM -0700, Andrew Morton wrote:
> 
> > If vendors are forced to ship a nasty hack it often points at
> > problems in the mainline kernel.  Certainly that's true in this
> > case.
> 
> Yes, so let's discuss it and think about a nice clean solution rather
> than hastily merge something that 'seems to work' without considering
> the long term consequences of this.

Has been discussed on this list.  It requires worrisome changes to the
capability system, changes to PAM, changes to login and changes to
applications.

> > And if we are unable to fix the kernel acceptably then I'd prefer
> > that the expedient fix be in the mainstream kernel so as to prevent
> > divergence in user-visible features between vendor kernels.
> 
> And when we have a clean solution we will have to live with this hack
> too.

Maybe that's the price we pay for leaving this problem unsolved for a year.
I must say that it's also to some extent a consequence of ISV's and
vendors quitely working on problems in little corners.

> > And let's remember, code-wise, this is a very small change.
> 
> It's not the code size --- it's the fact we add a strange new semantic
> (magic group) without what IMO is sufficient thought and discussion
> into a stable kernel series knowing that we will probably *NEVER* be
> able to remove this wart once we have a better solution.

There is no magic group unless the admin chooses to set the sysctl.

> > But it's too late.
> 
> Why?  Also, most existing users will be 2.4.x --- why does that not
> nee this but 2.6.x _MUST_ had it?
> 
> > This stuff is going out the door to end 2.6 users and that's just
> > tough luck.  The least we can do is to ensure that it works the same
> > across different vendor's kernels.
> 
> When was this issue properly discussed?  It seems like it's a new
> issue that's be hurried out the door without much consultation.
> 
> It might be my interpretation, but this also reads to me like "I don't
> think it's too ugly, it's my party so tough shit if you don't like it"
> :)

You misunderstand.  Nasty workarounds will be shipped to end users by
vendors.  That's a certainty.  We cannot change this now.

What I wish to do is to ensure that all users receive the *same* nasty
workaround.  Call it damage control.
