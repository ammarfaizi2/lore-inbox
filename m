Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUAHC4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbUAHC4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:56:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:52407 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263625AbUAHC4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:56:37 -0500
Date: Wed, 7 Jan 2004 18:56:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Greg KH <greg@kroah.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <20040108034906.A1409@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0401071854500.2131@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com>
 <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040108031357.A1396@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401071815320.12602@home.osdl.org> <20040108034906.A1409@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jan 2004, Andries Brouwer wrote:
>
> On Wed, Jan 07, 2004 at 06:19:42PM -0800, Linus Torvalds wrote:
> 
> > When I insert a card in my card reader, it had better "just work". WITHOUT 
> > any strange "poll another device Y to make device X" work.
> 
> But it does just work.
> 
> Already today.

Exactly. It works today, because:

 - the device nodes are there.

   Ergo: udev should create the device nodes

 - the kernel autopartitions the device on any open (both main device and 
   the subpartitions) when it notices a changed media. No polling 
   required.

   Ergo: the kernel should continue to do this.

We should _not_ be in the situation where either of these things aren't 
true.

		Linus
