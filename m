Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319062AbSIJAWa>; Mon, 9 Sep 2002 20:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319063AbSIJAWa>; Mon, 9 Sep 2002 20:22:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7684 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319062AbSIJAW3>; Mon, 9 Sep 2002 20:22:29 -0400
Date: Mon, 9 Sep 2002 17:30:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <20020910001945.GB8477@kroah.com>
Message-ID: <Pine.LNX.4.33.0209091727370.2069-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Greg KH wrote:
> 
> Sorry, Matt told me to add it, I didn't realize the background.  Should
> I leave it as show_trace(), or just remove it?  Do you want me to send
> you another changeset to put it back?

I've just excluded it, with a comment to never _ever_ kill the machine 
unless there is a major reason for it.

We might want to add some "weaker" form of BUG_ON() for sanity checks that 
aren't life-threatening (ie a "CHECK(a == b)" kind of debug facility) that 
would be prettier than doing printk's and show_trace(), and that would 
also be easier to disable for production kernels (not that I personally 
much believe in disabling debugging like that - if it really isn't needed 
it should be removed, not disabled).

		Linus

