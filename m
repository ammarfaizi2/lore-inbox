Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTI2SzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTI2SzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:55:14 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:51368 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S264454AbTI2SzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:55:08 -0400
Date: Tue, 30 Sep 2003 06:49:30 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: pm: Revert swsusp to 2.6.0-test3
In-reply-to: <Pine.LNX.4.44.0309290938010.968-100000@localhost.localdomain>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1064861370.2014.4.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.44.0309290938010.968-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 04:51, Patrick Mochel wrote:
> > Could you also give me some clear direction on where you want me to put
> > my 2.4 port. Should it go in kernel/power, or somewhere else? (I'm
> > assuming you don't want 3 versions of swsusp?!). I'd like to put it in
> > the right place when I start populating swsusp25.bkbits.net, so you're
> > not pulling changesets later that only move the code around (I know bk
> > reduces the cost, but...).
> 
> Please put it in kernel/power/. 

Ok. I'll do that then.

> It's completely alright to have three suspend-to-disk implementations. For 
> one, porting it does not imply that it will be merged into mainline, as 
> is. I would like to see convergence of the competing solutions, and I 
> fully intend to leverage the work that you've done and integrate it into 
> the core power management code, and the pmdisk implementation. 
> 
> The power management core provides, among other things, a framework for 
> properly suspending and resuming a system. Persistant state retention is 
> one aspect, albeit the largest in terms of importance and sheer size. I 
> would like to see backend mechanism for storing state abstracted from the 
> snapshotting process.

I'd certainly like to see such additions somehow implemented as optional
extras. The core functionality ought not be a great monolithic mass.

> This means that there may be several low-level 'drivers' that each deal 
> with reading/writing data on a particular format. And, it means that much 

I've had enquiries about adding support for UML, NFS and encryption
support; they would match well with your desire for a more general
solution. 

> of the overhead of swsusp, etc, can be folded into the core PM code. 

Yes; I have a pretty clear distinction between the code for freezing
processes and syncing data and that which actually saves the data.

> I do not have more technical details about this ATM, but I will work with 
> you to make sure things are streamlined as much as possible during and 
> after your port.

Great. I'll start the work in earnest tomorrow. Today I'm packing up
books :>

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

