Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbUBZXfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUBZXeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:34:13 -0500
Received: from nevyn.them.org ([66.93.172.17]:7827 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261299AbUBZXcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:32:19 -0500
Date: Thu, 26 Feb 2004 18:32:13 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][3/3] Update CVS KGDB's wrt connect / detach
Message-ID: <20040226233213.GA11330@nevyn.them.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	"Amit S. Kale" <amitkale@emsyssoft.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
References: <20040225213626.GF1052@smtp.west.cox.net> <20040225214343.GG1052@smtp.west.cox.net> <20040225215309.GI1052@smtp.west.cox.net> <200402261344.49261.amitkale@emsyssoft.com> <20040226144155.GQ1052@smtp.west.cox.net> <20040226160523.GB28873@nevyn.them.org> <20040226174421.GT1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226174421.GT1052@smtp.west.cox.net>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 10:44:21AM -0700, Tom Rini wrote:
> Ack.  Does gdb do anything to see if the rmote side will support being
> left hanging?

No.

> > > > > - Don't try and look for a connection in put_packet, after we've tried
> > > > >   to put a packet.  Instead, when we receive a packet, GDB has
> > > > >   connected.
> > > > 
> > > > We have to check for gdb connection in putpacket or else following problem 
> > > > occurs.
> > > > 
> > > > 1. kgdb console messages are to be put.
> > > > 2. gdb dies
> > > 
> > > As in doesn't cleanly remove itself?
> > 
> > Seg faults, for instance.
> 
> That's what I was figuring.  Does gdbserver handle things like this (gdb
> up and dying in the middle of a session, disconnecting without warning)
> well?

Generally yes, if the program was stopped, as an accident of the fact
that GDB removes breakpoints when you're stopped.

When running, no, not so much.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
