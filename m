Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266269AbUAIA3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUAIA3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:29:10 -0500
Received: from [130.57.169.10] ([130.57.169.10]:23688 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S266269AbUAIA3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:29:07 -0500
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
From: Robert Love <rml@ximian.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Greg KH <greg@kroah.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0401071941390.2131@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru>
	 <20040103055847.GC5306@kroah.com>
	 <Pine.LNX.4.58.0401071036560.12602@home.osdl.org>
	 <20040108031357.A1396@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401071815320.12602@home.osdl.org>
	 <20040108034906.A1409@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401071854500.2131@home.osdl.org>
	 <20040108043506.A1555@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401071941390.2131@home.osdl.org>
Content-Type: text/plain
Message-Id: <1073608126.1228.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 08 Jan 2004 19:28:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-07 at 22:43, Linus Torvalds wrote:

> Yes. We _could_ do that, by just making a "we noticed the disk change" be
> a hotplug event. However, I'm loath to do that, because some devices
> literally don't even have an easily read disk change signal, so what they
> do is

I like the idea of a hotplug event on media change (basically, a hotplug
event for partitions).  And, in fact, I am loath not to do it.

The current direction with the kernel and udev is letting us move _away_
from polling.  Projects such as HAL are helping to finally integrate
hardware management throughout the system.  But HAL is going to be very
confused by some of the alternative solutions for partitions: requiring
that all of the partition device nodes preexist is going to really
complicate things, and I really do not want to have to poll on all of
them in order for HAL to have an idea of what partitions are valid.

But I hear you loud and clear about dumb devices that cannot detect
media change.  They pose a problem.

I want a proper solution, too... ideas?

	Robert Love


