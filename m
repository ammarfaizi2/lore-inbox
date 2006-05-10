Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWEJJBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWEJJBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWEJJBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:01:21 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:62896 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964867AbWEJJBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:01:20 -0400
Date: Wed, 10 May 2006 05:00:57 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Adrian Bunk <bunk@stusta.de>
cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] mtd redboot (also gcc 4.1 warning fix)
In-Reply-To: <20060510053701.GO3570@stusta.de>
Message-ID: <Pine.LNX.4.58.0605100453540.556@gandalf.stny.rr.com>
References: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
 <20060510053701.GO3570@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, Adrian Bunk wrote:

> On Tue, May 09, 2006 at 07:56:04PM -0700, Daniel Walker wrote:
>
> > unsigned long may not always be 32 bits, right ? This patch fixes the
> > warning, but not the bug .
> >...
>
> IOW, all your patch does is to hide a bug?
>
> Not exactly an improvement...
>

Perfect example of what Andrew Morten stated in his keynote at LinuxTag.
He mentioned patches that fixed warnings but not the problem that they
warn about.  He stated that these are very dangerous, because, not only is
the problem not fixed, but now no one knows of the problem.

Daniel,

We appreciate the clean up of the kernel.  Just try to focus on the
obvious stuff, and maybe only flag those that you're not sure is still a
problem.  Email the author of the code, or kick his butt to get him to
move and fix it.

Unintialized variables and bad compares may not be as trivial as they
appear.  Look closely at them to see if there isn't really a problem that
lies underneath.

Thanks,

-- Steve

