Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUEJXcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUEJXcw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUEJX2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:28:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:55762 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263567AbUEJXZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:25:55 -0400
Date: Mon, 10 May 2004 16:28:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-Id: <20040510162818.376b4a55.akpm@osdl.org>
In-Reply-To: <20040510231146.GA5168@taniwha.stupidest.org>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	<20040510223755.A7773@infradead.org>
	<20040510150203.3257ccac.akpm@osdl.org>
	<20040510231146.GA5168@taniwha.stupidest.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> On Mon, May 10, 2004 at 03:02:03PM -0700, Andrew Morton wrote:
> 
> > Capabilities are broken and don't work.  Nobody has a clue how to
> > provide the required services with SELinux and nobody has any code
> > and we need the feature *now* before vendors go shipping even more
> > ghastly stuff.
> 
> eh? magic groups are nasty...  and why is this needed?  can't
> oracle/whatever just run with a wrapper to give the capabilities out
> as required until a better solution is available

capabilities all get dropped on the floor across exec().  We discussed this
on this list after Bill and I spent half a day getting cap_pam working,
only to discover that the kernel had been nobbled years ago.

> and who cares if vendors show something worse?

me.

>  vendors ship crap all
> the time, that's partly why we have vendor kernels --- to ship crap
> that people want now w/o having to corrupt and pollute the cleanliness
> of the mainline kernel until a sufficiently well thought out sane plan
> can be devised

If vendors are forced to ship a nasty hack it often points at problems in
the mainline kernel.  Certainly that's true in this case.

And if we are unable to fix the kernel acceptably then I'd prefer that the
expedient fix be in the mainstream kernel so as to prevent divergence in
user-visible features between vendor kernels.

And let's remember, code-wise, this is a very small change.

If someone comes up with an acceptable SELinux (or whatever)-based solution
then fine.  But it's too late.  This stuff is going out the door to end 2.6
users and that's just tough luck.  The least we can do is to ensure that it
works the same across different vendor's kernels.

