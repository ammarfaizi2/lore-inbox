Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWHTQ6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWHTQ6J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWHTQ6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:58:09 -0400
Received: from mx2.rowland.org ([192.131.102.7]:29964 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1750945AbWHTQ6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:58:08 -0400
Date: Sun, 20 Aug 2006 12:58:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Ingo Molnar <mingo@redhat.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Alexey Dobriyan <adobriyan@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Complaint about return code convention in queue_work() etc.
In-Reply-To: <Pine.LNX.4.61.0608201024330.9707@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.44L0.0608201246310.17959-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2006, Jan Engelhardt wrote:

> >Mixing up these two sorts of representations is a fertile source of
> >difficult-to-find bugs.  If the C language included a strong distinction
> >between integers and booleans then the compiler would find these mistakes
> >for us... but it doesn't.
> 
> Recently introduced "bool".

I haven't seen the new definition of "bool", but it can't possibly provide 
a strong distinction between integers and booleans.  That is, if x is 
declared as an integer rather than as a bool, the compiler won't complain 
about "if (x) ...".


On Sun, 20 Aug 2006, Ingo Molnar wrote:

> yeah, lets just flip the logic over, but combined with a rename so that
> we dont surprise not-yet-in-tree code [and documentation/books].
> queue_work() -> add_work() or something like that.

How about add_work_to_q() instead of queue_work() and add_work() instead
of schedule_work()?

Alan Stern

