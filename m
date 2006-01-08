Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932748AbWAHS5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbWAHS5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbWAHS5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:57:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41705 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932760AbWAHS5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:57:40 -0500
Subject: Re: [PATCH]: How to be a kernel driver maintainer
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1136745838.2955.17.camel@laptopd505.fenrus.org>
References: <1136736455.24378.3.camel@grayson>
	 <1136737997.2955.10.camel@laptopd505.fenrus.org>
	 <1136744870.1043.4.camel@grayson>
	 <1136745838.2955.17.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 19:57:37 +0100
Message-Id: <1136746657.2955.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 19:43 +0100, Arjan van de Ven wrote:
> > But this isn't at al true. Almost all subsystems maintain the primary
> > tree outside of the kernel, with the kernel being the primary _stable_
> > tree. USB, Netdev,
> 
> patches yes. but usually only small stuff
> 
> >  Alsa, etc. All changes go someplace else before being
> > pushed to the primary kernel tree. 99% of the time, patches are going
> > somewhere else before going into the main kernel. 
> 
> that's different... that's a patch queue. That's not the same as being
> the prime repository.

this deserves expanding.

What net/usb/scsi queue is *deltas* to the kernel.org kernel. This is
fundamentally different from having the main driver be in its own
repository. Each delta is meant to do a certain change to the driver, eg
it's a CHANGE BASED thing. While "own repository" is "here is new
code" (even though you can disguise it as changes pretty well).
The linux development model is based on introducing changes, not on
introducing new code (of course the difference goes away if you
introduce a new driver, but that's a corner case)

The result is also highly different. In the net/usb/scsi case, there is
no "we need to move changes in mainline to our tree or they get lost".
The only thing needed would be resolving conflicts in the proposed
changes in the subsystem maintainers queue and the changes already in
mainline.

Note: this is independent of what kind of tool is used to store and
distribute such changes. quilt and git are used most, but git can also
be used in a CVS way if you want. But it's the "the main driver is in
the kernel, and we have proposed improvements to it" that counts (versus
"we have the main driver that we push to the kernel occasionally if we
feel like it").


