Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUCCPXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbUCCPWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:22:52 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:28117 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S262488AbUCCPW2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:22:28 -0500
Date: Wed, 3 Mar 2004 08:22:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040303152226.GS20227@smtp.west.cox.net>
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net> <20040302223143.GE1225@elf.ucw.cz> <20040302230018.GL20227@smtp.west.cox.net> <20040302233512.GJ1225@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302233512.GJ1225@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 12:35:12AM +0100, Pavel Machek wrote:
> On ?t 02-03-04 16:00:18, Tom Rini wrote:
> > On Tue, Mar 02, 2004 at 11:31:43PM +0100, Pavel Machek wrote:
> > 
> > > Hi!
> > > 
> > > > > Tom Rini wrote:
> > > > > >Hello.  The following interdiff kills kgdb_serial in favor of function
> > > > > >names.  This only adds a weak function for kgdb_flush_io, and documents
> > > > > >when it would need to be provided.
> > > > > 
> > > > > It looks like you are also dumping any notion of building a kernel that can 
> > > > > choose which method of communication to use for kgdb at run time.  Is this 
> > > > > so?
> > > > 
> > > > Yes, as this is how Andrew suggested we do it.  It becomes quite ugly if
> > > > you try and allow for any 2 of 3 methods.
> > > 
> > > I do not think that having kgdb_serial is so ugly. Are there any other
> > > uglyness associated with that?
> > 
> > More precisely:
> > http://lkml.org/lkml/2004/2/11/224
> 
> Well, that just says Andrew does not care too much. I think that
> having both serial and ethernet support *is* good idea after all... I
> have few machines here, some of them do not have serial, and some of
> them do not have supported ethernet. It would be nice to use same
> kernel on all of them. Also distribution wants to have "debugging
> kernel", but does _not_ want to have 10 of them.

But unless I'm missing something, supporting eth or 8250 at all times
doesn't work right now anyhow, as eth if available will always take over.

-- 
Tom Rini
http://gate.crashing.org/~trini/
