Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUJHUX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUJHUX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUJHUX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:23:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:27361 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264530AbUJHUXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:23:08 -0400
Date: Fri, 8 Oct 2004 13:22:47 -0700
From: Greg KH <greg@kroah.com>
To: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: InfiniBand incompatible with the Linux kernel?
Message-ID: <20041008202247.GA9653@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Enough people have been asking me about this lately, that I thought I
would just bring it up publicly here.

It seems that the Infiniband group (IBTA) has changed their licensing
agrement of the basic Infiniband spec.  See:
	http://www.theinquirer.net/?article=18922
for more info about this.

The main point that affects Linux is the fact that now, no non-member of
the IBTA can implement any working Infiniband code, otherwise they might
run into legal problems.  As an anonymous member of a IBTA company told
me:
	If someone downloads the spec without joining the IBTA, and
	proceeds to use the spec for an implementation of the IBTA spec,
	that person (company) runs the risk of being a target of patent
	infringement claims by IBTA members.

Another person, wanting to remain anonymous stated to me:
	In justification for this position people say that they are just
	trying to get more people to join the IBTA because they need the
	dues, which by coincidence are $9500 per year, and point out
	that some other commonly used specs are similarly made available
	for steep prices. I don't know one way or the other about that
	but this sounds a lot like the reason that we all gave ourselves
	for NOT including SDP in the kernel[1].

So, even if a IBTA member company creates a Linux IB implementation, and
gets it into the kernel tree, any company who ships such a
implementation, who is not a IBTA member, could be the target of any
patent infringement claims[2].

So, OpenIB group, how to you plan to address this issue?  Do you all
have a position as to how you think your code base can be accepted into
the main kernel tree given these recent events?

thanks,

greg k-h

[1] SDP, for those who do not know, is a part of the IB spec that
Microsoft has come out and stated they they currently own the patents
that cover that portion of the specification, and that anyone who wants
to implement it, needs to get a licensing agreement with them.  Of
course, that license agreement does not allow for a GPLed version of the
implementation.

[2] Sure, any person who has a copy of the kernel source tree could be a
target for any of a zillion other potential claims, nothing new there,
but the point here is they are explicitly stating that they will go
after non-IBTA members who touch IB code[3].

[3] An insanely stupid position to take, given the fact that any normal
industry group would be very happy to actually have people use their
specification, but hey, the IB people have never been know for their
brilliance in the past...
