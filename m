Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTESU1K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTESU1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:27:10 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.92.226.148]:15764 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262861AbTESU1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:27:07 -0400
Date: Mon, 19 May 2003 16:36:53 -0400
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about buffer overflow.
Message-ID: <20030519203653.GA1718@andromeda>
References: <E19Hp05-0005FO-00@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19Hp05-0005FO-00@andromeda>
User-Agent: Mutt/1.5.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check out [http://www.trusteddebian.org/].  They apply a bunch of kernel
patches like grsecurity.  Seems they have to recompile, repackage all
the .debs though.  

It is interesting to note that some of these patches introduce an
apparent non-determinism into userspace; the same inputs could result in
different outputs (the difference is that there are more inputs than
userspace can actually see).  So, maybe it could happen that you get a
segv from an off by 1, but when you rerun it, you can't reproduce it
because all the addresses are different.

In practice, this will eventually segv somewhere, and someone will find
the problem, but its something to consider.

Justin Pryzby

On Mon, May 19, 2003 at 02:22:00AM +0000, Barry K. Nathan wrote:
> 
> On Mon, May 19, 2003 at 03:00:47AM +0300, Halil Demirezen wrote:
> > yes that is interesting, however, what i want to learn, clearly, is
> > this patch available from 2.4.20-rc1 at every default linux kernel
> > from this moment on?
> ...
> BTW, another option is the pageexec ('PaX') patch:
> http://pageexec.virtualave.net/ (warning: this page has pop-up windows)
> 
> and that's integrated into a more comprehensive security patch,
> grsecurity:
> http://www.grsecurity.net/
> 
> -Barry K. Nathan <barryn@pobox.com>
