Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVEQNad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVEQNad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVEQNad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:30:33 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:23748 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261192AbVEQNa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:30:26 -0400
Date: Tue, 17 May 2005 09:30:25 -0400
To: "Michael H. Warfield" <mhw@wittsend.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sync option destroys flash!
Message-ID: <20050517133025.GC23621@csclub.uwaterloo.ca>
References: <1116001207.5239.38.camel@localhost.localdomain> <1116009619.9371.494.camel@localhost.localdomain> <1116032735.5461.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116032735.5461.46.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 09:05:34PM -0400, Michael H. Warfield wrote:
> 	Yah know...  I've been thinking about this...  In a former life, we use
> to do something very similar with a virtual memory system on some real
> early (80's vintage) networked VM workstations (back when memory was
> actually valuable and scarce).
> 
> 	So...  This would have to work with a list or pool of "spares" that are
> not allocated to the "visible" file system.  We used a "least used"
> algorithm for that VM system.  This would seem to be a "replace as
> rewritten" algorithm.  Each time you write to the file system, it grabs
> a block off the head of the spares list, writes your data to it, and
> then adds the old block to the tail of the list.  Pretty basic stuff and
> it doesn't have to track what kind of high level file system you are
> using or know anything about its structure.  Cool...

Really good wearleveling will even move blocks that "never" seem to
change to the more used blocks ones in a while to spread out the wear to
blocks that have static content in them.  After all if 90% of your flash
never changes, and you run a log in the last 10%, you will still wear
out that 10% first if you don't occationally move some of the static
content to the 10% with some wear, and start running your log on the
previously unused area.

I was told by someone from SanDisk that this is how _some_ of their
flash media work (at least on the new ones).

I was actually surprised since I assumed at the time this was how all of
the CF cards worked.

Len Sorensen
