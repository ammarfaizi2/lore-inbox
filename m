Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbUDYDTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbUDYDTM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 23:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUDYDTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 23:19:12 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:17931 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262796AbUDYDTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 23:19:08 -0400
Date: Sun, 25 Apr 2004 04:19:07 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jason Cox <steel300@gentoo.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Change number of tty devices
In-Reply-To: <E1BGTsk-0000va-Bx@smtp.gentoo.org>
Message-ID: <Pine.LNX.4.44.0404250416380.15965-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> First off, thanks for the reply. Does lowering the number of tty devices
> interfer with the creation of serial consoles? Can't they start at the
> same major number without an issue?

No. It when we need more than 64 VCs.

> > What is even more is that there exist ioctls that return shorts 
> > which means only 16 VCs can be accounted for on a VT. 
> 
> So is my limit wrong? Should I up the lower limit to 16 to account for
> this? 

I would recommend it. 

> > When the kernel supports multi-desktop systems we will have to deal
> > with the serial and VT issue. Most likely the serial tty drivers will
> > be given a different major number. 
> 
> Why isn't this done now?

We are in a stable release.

> > I personally believe that because
> > of the 16 bit limit that there should be 16 VCs per VT terminal. 
> 
> That does make sense.
> 
> Just a side note: I have been running with 12 (0 - 11) tty devices
> without issue. I haven't tried a serial console, but will shortly, just
> to see if it interferes with serial console creation.

It should be no problem. I hate hard limits tho. I rather have a lean 
system that only allocates resources when we want them.


