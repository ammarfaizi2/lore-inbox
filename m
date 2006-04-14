Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWDNPuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWDNPuD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 11:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWDNPuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 11:50:03 -0400
Received: from xenotime.net ([66.160.160.81]:33987 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751253AbWDNPuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 11:50:02 -0400
Date: Fri, 14 Apr 2006 08:52:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Direct writing to the IDE on panic?
Message-Id: <20060414085227.83f73176.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0604141048260.11438@gandalf.stny.rr.com>
References: <1144936547.1336.20.camel@localhost.localdomain>
	<1145024914.17531.21.camel@localhost.localdomain>
	<Pine.LNX.4.58.0604141023240.11098@gandalf.stny.rr.com>
	<1145026327.17531.24.camel@localhost.localdomain>
	<Pine.LNX.4.58.0604141048260.11438@gandalf.stny.rr.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006 10:54:19 -0400 (EDT) Steven Rostedt wrote:

> 
> On Fri, 14 Apr 2006, Alan Cox wrote:
> 
> > On Gwe, 2006-04-14 at 10:27 -0400, Steven Rostedt wrote:
> > > Nice point.  But fortunately, this is for a custom application running on
> > > an embedded device, such that the data that is on another part of the disk
> > > (which btw is an IDE flash) is just the application and the rest of the
> > > OS.  So, although a bad write to the disk will cause much more work, it
> > > wont destroy data that cant be replaced.
> >
> > If you know the controller as well then you are correct in assuming the
> > code to do the dump is very simple indeed providing you stick to PIO,
> > especially if you know the set up is already done before crash
> >
> 
> Thank you very much for your input Alan!
> 
> Now my strength in IDE is not that strong, hence the reason I was asking
> if this was done before.  I'd like to look at some examples before I go
> ahead and figure it out on my own.  I'm sure that I'm going to need to do
> a rewrite for our specific configuration, but looking at others work might
> make things easier.
> 
> Since this is all under GPL (my customer will give all the source to who
> ever they distribute it to), I was hoping to take advantage of free
> software here and not completely reinvent the wheel (and destroying it
> along the way ;)

Rusty Russell had an IDE block dump patch during the 2.4
timeframe IIRC.  I don't know where it could be found now.
Maybe in old LKCD tarballs or archives?

---
~Randy
