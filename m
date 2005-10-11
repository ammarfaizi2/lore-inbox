Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVJKTNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVJKTNl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 15:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVJKTNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 15:13:41 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:484 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932291AbVJKTNl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 15:13:41 -0400
Date: Tue, 11 Oct 2005 15:13:39 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Paul Jackson <pj@sgi.com>, <laforge@gnumonks.org>, <torvalds@osdl.org>,
       <chrisw@osdl.org>, <vsu@altlinux.ru>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <security@linux.kernel.org>, <vendor-sec@lst.de>
Subject: Re: [linux-usb-devel] Re: [BUG/PATCH/RFC] Oops while completing
 async USB via usbdevio
In-Reply-To: <Pine.LNX.4.61.0510111352400.6379@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44L0.0510111505540.3821-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2005, linux-os (Dick Johnson) wrote:

> On Tue, 11 Oct 2005, Paul Jackson wrote:
> 
> > Alan asked:
> >> But why do people go to the
> >> effort of confusing readers by using "^" instead of "!="?
> >
> > My guess - eor (^) was quicker than not-equal (!=) on a PDP-11.
> >
> > That code fragment for checking uid's has been around a -long-
> > time, if my memory serves me.
> >
> > It's gotten to be like the infamous "!!" boolean conversion
> > operator, a bit of vernacular that would be harder to read if
> > recoded using modern coding style.

Surely Linux uses entirely original code, with no hangovers from the
original AT&T Unix...  Besides, to the best of my recollection, the two
operations are equal in speed on a PDP-11.

"!!" makes sense as an idiom.  But "^" for "!=" doesn't, at least not in 
this context.

> Also, at one time, people used to spend a lot of time
> minimizing the number of CPU cycles used in the code.
> 
> For instance, when it's appropriate, using XOR makes the
> resulting generated code simpler and usually faster:
...

Yes, sometimes XOR can yield simpler object code.  But not in cases like 
this, where it's part of a Boolean test:

	if (... && (a1^b1) && (a2^b2) && (a3^b3)) ...

On any architecture I know of, "^" and "!=" would be equally efficient 
here.

Alan Stern

