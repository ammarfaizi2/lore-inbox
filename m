Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272167AbTG2XBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 19:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272168AbTG2XBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 19:01:10 -0400
Received: from dp.samba.org ([66.70.73.150]:51874 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S272167AbTG2XBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 19:01:08 -0400
Date: Wed, 30 Jul 2003 06:33:10 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: notting@redhat.com, arjanv@redhat.com, torvalds@osdl.org,
       shemminger@osdl.org, davem@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting.
Message-Id: <20030730063310.70b5c794.rusty@rustcorp.com.au>
In-Reply-To: <1059392321.15458.23.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org>
	<20030727193919.832302C450@lists.samba.org>
	<20030727214701.A23137@devserv.devel.redhat.com>
	<20030727201242.A29448@devserv.devel.redhat.com>
	<1059392321.15458.23.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jul 2003 12:38:41 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Llu, 2003-07-28 at 01:12, Bill Nottingham wrote:
> > It loads/unloads things like scsi modules and firewire controller
> > modules, but only for hardware actually present in the system (i.e.,
> > you'd probably be loading it again anyway, if you haven't already
> > loaded it.)
> 
> It loads things like floppy anyway, and it loads lots of things like the
> firewire stuff that nobody ever uses because it has to see if anything
> is plugged into them.

And it has to leave them in memory anyway, in case someone plugs stuff in
later.  Oh well.

> I guess kudzu could simply do lots of I/O ops directly on the floppy 
> hardware to detect it without loading drivers but thats pretty fugly.

Agreed that'd be kinda silly.  But I was "educated" earlier that driver
loading shouldn't fail just because hardware is missing, due to hotplug.

Is this wrong?
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
