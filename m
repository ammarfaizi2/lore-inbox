Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbUBXTfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUBXTfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:35:33 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:50698 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S262405AbUBXTf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:35:27 -0500
Date: Tue, 24 Feb 2004 14:35:24 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <20040224104718.26059b7b.davem@redhat.com>
Message-ID: <Pine.OSF.4.21.0402241426120.320699-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Feb 2004, David S. Miller wrote:

> Hmmm, I wonder if the connection tracking tables are simply never shrinking.
> 
> Can you get some kernel profiles when the problem hits?  If you don't know how
> to do this, it's got to be documented somewhere and I'm sure someone can point
> you at how to do it.
> 
> I bet we'll see netfilter at the top of the profiles or something like that.

OK.

I haven't done kernel profiling before.  Did a little googling and this is
what I think I know (2.4.x)

In lilo.conf, do append="profile=2" (is 2 a good number?)
reboot
echo > /proc/profile
readprofile -m System.map-2.4.24 (or whatever)

Is that correct?

Of course, this problem happens fastest on productions machines, which I
hate to put out of commission...  I need to turn my attention to some
other stuff for a bit today, but tonight I'll see if I can't work
something up on a non-production machine to make it go bad.  Then do some
profiling.

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College


