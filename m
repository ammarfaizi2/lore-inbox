Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbUEKLww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUEKLww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 07:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbUEKLww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 07:52:52 -0400
Received: from mx-00.sil.at ([62.116.68.196]:49934 "EHLO mx-00.sil.at")
	by vger.kernel.org with ESMTP id S263124AbUEKLwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 07:52:46 -0400
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
From: nf <nf2@scheinwelt.at>
Reply-To: nf2@scheinwelt.at
To: Chris Wedgwood <cw@f00f.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>, nautilus-list@gnome.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040511024701.GA19489@taniwha.stupidest.org>
References: <1084152941.22837.21.camel@vertex>
	 <20040510021141.GA10760@taniwha.stupidest.org>
	 <1084227460.28663.8.camel@vertex>
	 <20040511024701.GA19489@taniwha.stupidest.org>
Content-Type: text/plain
Message-Id: <1084276364.4081.63.camel@lilota.lamp.priv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-2mdk 
Date: Tue, 11 May 2004 13:52:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 04:47, Chris Wedgwood wrote: 
> On Mon, May 10, 2004 at 06:17:40PM -0400, John McCutchan wrote:
> 
> > According to everyone who uses dnotify it is.
> 
> I don't buy that.  I have used dnotify and signals where not an issue.
> Why is this an issue for others?

I believe the worst thing about dnotify is the "umount blocking"
behaviour. It drives me crazy since i use the Linux desktop. So if this
is the "Year of the linux desktop", please please switch OFF dnotify
until it does not open files for monitoring anymore! Or until "inotify"
works.

Btw, i have written a little tool to assist people with the
umount-problem and collected some links
http://www.scheinwelt.at/~norbertf/wbumount/. 

> > The idea is to encourage use of a user-space daemon that will
> > multiplex all requests, so if 5 people want to watch /somedir the
> > daemon will only use one watcher in the kernel. The number might be
> > too low, but its easily upped.
> 
> If you are to use a daemon for this, why no use dnotify?

I don't understand, why the author of inotify wants to force people to
use user-space daemons like fam (which requires xinetd, ...)? Does using
a daemon for multiplexing really add efficiency? Is it really worth
adding all the complexity of things like "fam" to the system, just
because more than one application monitor the same directory once in a
while? I doubt it.

I would even claim, that simple polling ("stat"-ing) the filesystem for
changes is more efficient in 95% of the cases, than all this dnotify,
fam, etc... stuff.

Just to be fair - i don't think that dnotify or fam are bad tools, but
the combination of them seems poisonous for the desktop.

Norbert


