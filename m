Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUCCK1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUCCK1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:27:34 -0500
Received: from gprs40-155.eurotel.cz ([160.218.40.155]:34188 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262427AbUCCK1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:27:00 -0500
Date: Wed, 3 Mar 2004 00:35:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040302233512.GJ1225@elf.ucw.cz>
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net> <20040302223143.GE1225@elf.ucw.cz> <20040302230018.GL20227@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040302230018.GL20227@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 02-03-04 16:00:18, Tom Rini wrote:
> On Tue, Mar 02, 2004 at 11:31:43PM +0100, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > > Tom Rini wrote:
> > > > >Hello.  The following interdiff kills kgdb_serial in favor of function
> > > > >names.  This only adds a weak function for kgdb_flush_io, and documents
> > > > >when it would need to be provided.
> > > > 
> > > > It looks like you are also dumping any notion of building a kernel that can 
> > > > choose which method of communication to use for kgdb at run time.  Is this 
> > > > so?
> > > 
> > > Yes, as this is how Andrew suggested we do it.  It becomes quite ugly if
> > > you try and allow for any 2 of 3 methods.
> > 
> > I do not think that having kgdb_serial is so ugly. Are there any other
> > uglyness associated with that?
> 
> More precisely:
> http://lkml.org/lkml/2004/2/11/224

Well, that just says Andrew does not care too much. I think that
having both serial and ethernet support *is* good idea after all... I
have few machines here, some of them do not have serial, and some of
them do not have supported ethernet. It would be nice to use same
kernel on all of them. Also distribution wants to have "debugging
kernel", but does _not_ want to have 10 of them.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
