Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbUABUnc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUABUnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:43:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:44730 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265659AbUABUnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:43:25 -0500
Date: Fri, 2 Jan 2004 12:42:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rob Love <rml@ximian.com>
cc: Andries Brouwer <aebr@win.tue.nl>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <1072972440.3975.29.camel@fur>
Message-ID: <Pine.LNX.4.58.0401021238510.5282@home.osdl.org>
References: <18Cz7-7Ep-7@gated-at.bofh.it>  <20040101001549.GA17401@win.tue.nl>
 <1072917113.11003.34.camel@fur>  <200401010634.28559.rob@landley.net>
 <1072970573.3975.3.camel@fur>  <20040101164831.A2431@pclin040.win.tue.nl>
 <1072972440.3975.29.camel@fur>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jan 2004, Rob Love wrote:
>
> On Thu, 2004-01-01 at 10:48, Andries Brouwer wrote: 
> > I am afraid I have to disappoint you. I made them 64-bit,
> > and I think they were 64-bit for a few months in the -mm tree,
> > forgot the details, but unfortunately Al went back to 32-bit again.
> 
> You did disappoint me!  My heart is crushed and my aspirations for the
> future ruined.
> 
> But you are right, dunno what I was thinking.

Note that one reason I didn't much like the 64-bit versions is that not 
only are they bigger, they also encourage insanity. Ie you'd find SCSI 
people who want to try to encode device/controller/bus/target/lun info 
into the device number. 

We should resist any effort that makes the numbers "mean" something. They 
are random cookies. Not "unique identifiers", and not "addresses".

The unique identifiers you get from things like udev, using contents of
the device itself or user preferences etc. That's outside the scope of the
kernel. The addresses you get from /sys.

		Linus
