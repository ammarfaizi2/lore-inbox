Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbTHaC6h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 22:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbTHaC6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 22:58:36 -0400
Received: from netrider.rowland.org ([192.131.102.5]:3852 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S262468AbTHaC6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 22:58:35 -0400
Date: Sat, 30 Aug 2003 22:58:34 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Duncan Sands <baldrick@wanadoo.fr>
cc: Fredrik Noring <noring@nocrew.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Johannes Erdfelt <johannes@erdfelt.com>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.6.0-test4: uhci-hcd.c: "host controller process error", slab
 call trace
In-Reply-To: <200308310136.02093.baldrick@wanadoo.fr>
Message-ID: <Pine.LNX.4.44L0.0308302248230.20207-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Aug 2003, Duncan Sands wrote:

> Does the attached patch help?
> 
> Alan, Johannes, did you have any further thoughts on this problem?
> I'm still not sure what the best approach is.

This was the same patch you proposed a month or two back, right?  I got a 
copy of this error report, but it wasn't at all clear what the cause of 
the problem was, so I haven't suggested anything.  Maybe the patch for 
your problem will help...

I also haven't done anything for your particular problem.  In fact, there
was a whole list of about 10 items that ought to be fixed I went over with
Johannes, and I haven't started on any of them.  There were 4 or so small
patches I sent in, but they haven't been applied yet -- Greg is still
waiting for Johannes to give the okay.  (They were pretty minor, except
one that fixed a nasty bug in the queueing code for control messages.)

My feeling is that a reasonably large change may end up being the best 
thing to do.  In particular, we probably only need to have one QH per 
queue, instead of one for each URB.  But it'll be a while before that 
stuff gets done.

Alan Stern

