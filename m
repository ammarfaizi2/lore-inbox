Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVBTKgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVBTKgx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 05:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVBTKgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 05:36:53 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:44039 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261794AbVBTKgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 05:36:51 -0500
Message-Id: <200502201036.j1KAagE04722@blake.inputplus.co.uk>
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       darcs-users@darcs.net
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed 
In-Reply-To: <20050219171457.GA20285@abridgegame.org> 
Date: Sun, 20 Feb 2005 10:36:42 +0000
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

David Roundy, creator of darcs, wrote:
> On Sat, Feb 19, 2005 at 05:42:13PM +0100, Andrea Arcangeli wrote:
> > I read in the webpage of the darcs kernel repository that they had
> > to add RAM serveral times to avoid running out of memory. They
> > needed more than 1G IIRC, and that was enough for me to lose
> > interest into it.  You're right I blamed the functional approach and
> > so I felt it was going to be a mess to fix the ram utilization, but
> > as someone else pointed out, perhaps it's darcs to blame and not
> > haskell. I don't know.
> 
> Darcs' RAM use has indeed already improved somewhat... I'm not exactly
> sure how much.  I'm not quite sure how to measure peak virtual memory
> usage, and most of the time darcs' memory use while doing the linux
> kernel conversion is under a couple of hundred megabytes.

Wouldn't calling sbrk(0) help?  I don't know if the Haskell run-time
ever shrinks the data segment, if not, it could just be called at the
end.  Or a `strace -e trace=brk darcs ...' might do.  But I guess darcs
has other VM usage that doesn't show in this figure?  Does /proc/$$/maps
if running under Linux help?

A consistent way to measure would be handy for observing changes over
time.

Cheers,


Ralph.

