Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275037AbRIYPUQ>; Tue, 25 Sep 2001 11:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275038AbRIYPUH>; Tue, 25 Sep 2001 11:20:07 -0400
Received: from borg.org ([208.218.135.231]:17927 "HELO borg.org")
	by vger.kernel.org with SMTP id <S275037AbRIYPTq>;
	Tue, 25 Sep 2001 11:19:46 -0400
Date: Tue, 25 Sep 2001 11:20:12 -0400
From: Kent Borg <kentborg@borg.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Something Broken in 2.4.9-ac15
Message-ID: <20010925112012.C27059@borg.org>
In-Reply-To: <1001377785.1430.7.camel@gromit.house>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1001377785.1430.7.camel@gromit.house>; from rothwell@holly-springs.nc.us on Mon, Sep 24, 2001 at 08:29:44PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 08:29:44PM -0400, Michael Rothwell wrote:
> my swap load is at zero, which is probably where it should be (2.4.7
> would regularly be using 256MB of swap with the same applications
> running).

That got my attention.  I think something is broken here and you
are into swap but the reporting is quite wrong.

I have 192 MB in my laptop running 2.4.9-ac15 w/preemption patch
turned on.  I fired up a couple Mozilla windows, a couple Netscape
windows, Staroffice, a couple acroread windows, a couple emacs
windows, Abiword, and I forget what all.  Still no swap usage
reported.  I fired up a second X session and my computer came to a
crawl as it tried to run all those apps again.  The disk was grinding
away--it felt just like a swapping death and yet xosview and top both
reported 0 swap usage.  I don't believe it was so.

I killed most everything, and now the computer feels like it is back
to normal, but xosview thinks the CPU is pinned at 100% SYS when
nothing is going on.  I drag a window around and I get plenty of USR
and even some FREE, but let go and it goes back to 100%.

Something is broken here, me thinks.


-kb, the Kent who might go back to 2.4.9-ac12 later today and ry it
again.
