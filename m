Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUAHDfU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 22:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUAHDfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 22:35:20 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:39695 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262705AbUAHDfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 22:35:10 -0500
Date: Thu, 8 Jan 2004 04:35:06 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Greg KH <greg@kroah.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040108043506.A1555@pclin040.win.tue.nl>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040108031357.A1396@pclin040.win.tue.nl> <Pine.LNX.4.58.0401071815320.12602@home.osdl.org> <20040108034906.A1409@pclin040.win.tue.nl> <Pine.LNX.4.58.0401071854500.2131@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401071854500.2131@home.osdl.org>; from torvalds@osdl.org on Wed, Jan 07, 2004 at 06:56:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 06:56:30PM -0800, Linus Torvalds wrote:

> > > When I insert a card in my card reader, it had better "just work". WITHOUT 
> > > any strange "poll another device Y to make device X" work.
> > 
> > But it does just work.
> > 
> > Already today.
> 
> Exactly. It works today, because:
> 
>  - the device nodes are there.
> 
>    Ergo: udev should create the device nodes
> 
>  - the kernel autopartitions the device on any open (both main device and 
>    the subpartitions) when it notices a changed media. No polling 
>    required.
> 
>    Ergo: the kernel should continue to do this.
> 
> We should _not_ be in the situation where either of these things aren't 
> true.

Indeed.

I am even happy in a somewhat more general situation that you are.
If the kernel autopartitions (and make recognition of new partitions
hotplug events so that udev can create the device nodes), all is well.

On the other hand, if the kernel does not autopartition
(for example because I had not selected CONFIG_MAC_PARTITION
and put a Mac disk in my ZIP drive) then all is still well
since user space can tell the kernel about the partitions
it sees on this Mac disk. Of course these partitions that
userspace tells the kernel about must also lead to hotplug
events.

Andries

