Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264739AbUD3DU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264739AbUD3DU3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 23:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUD3DU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 23:20:29 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:59658 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264739AbUD3DU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 23:20:27 -0400
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1083294719@astro.swin.edu.au>
Subject: Re:  ~500 megs cached yet 2.6.5 goes into swap hell
In-reply-to: <20040429141412.A12541@mail.kroptech.com>
References: <20040428184008.226bd52d.akpm@osdl.org> <Pine.LNX.4.44.0404282147000.19633-100000@chimarrao.boston.redhat.com> <20040429141412.A12541@mail.kroptech.com>
X-Face: "$j_Mi4]y1OBC/&z_^bNEN.b2?Nq4#6U/FiE}PPag?w3'vo79[]J_w+gQ7}d4emsX+`'Uh*.GPj}6jr\XLj|R^AI,5On^QZm2xlEnt4Xj]Ia">r37r<@S.qQKK;Y,oKBl<1.sP8r,umBRH';vjULF^fydLBbHJ"tP?/1@iDFsKkXRq`]Jl51PWN0D0%rty(`3Jx3nYg!
Message-ID: <slrn-0.9.7.4-783-31231-200404301311-tc@hexane.ssi.swin.edu.au>
Date: Fri, 30 Apr 2004 13:17:29 +1000
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin <akropel1@rochester.rr.com> said on Thu, 29 Apr 2004 14:14:13 -0400:
> On Wed, Apr 28, 2004 at 09:47:45PM -0400, Rik van Riel wrote:
> > On Wed, 28 Apr 2004, Andrew Morton wrote:
> > 
> > > OK, so it takes four seconds to swap mozilla back in, and you noticed it.
> > > 
> > > Did you notice that those three kernel builds you just did ran in twenty
> > > seconds less time because they had more cache available?  Nope.
> > 
> > That's exactly why desktops should be optimised to give
> > the best performance where the user notices it most...
...
> The 'swappiness' tunable may well give enough control over the situation
> to suit all sorts of users. If nothing else, this thread has raised
> awareness that such a tunable exists and can be played with to influence
> the kernel's decision-making. Distros, too, should give consideration to
> appropriate default settings to serve their intended users.

Actually, I decided to investigate how 2.4 compares (we're still stuck
on 2.4)

According to this:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.1/0011.html 

2.6 with swapiness of 0% is same as 2.4.19 - I assume 2.4.19's VM is
the same as 2.4.26 (given feature freeze).

I have always been completely unimpressed with the 2.4 VM - before and
after the big change in ~2.4.10. It has *always* preferred to use
cache in preference to a recently used application.

So will this still apply to 2.6 with swapiness of 0%?

I might try to get my sysadmin to put on 2.6, becuase 2.4 is quite
unusable for some of the work I do (if I need mozilla at the same time
as my visualisation software, which allocates a good 3/4 of RAM, after
reading a file that is about that size, leaving still enough for
mozilla and X combined, mozilla and parts of X still get swapped out -
and the cahce is wasted, since I only ever read the file once, and it
is written on another host)

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
"32-bit patch for a 16-bit GUI shell running on top of an
8-bit operating system written for a 4-bit processor by a
2-bit company who cannot stand 1 bit of competition."
