Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTLJWfm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 17:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTLJWfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 17:35:42 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:26051 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S264241AbTLJWfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 17:35:39 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: viro@parcelfarce.linux.theplanet.co.uk
Date: Wed, 10 Dec 2003 14:36:46 -0800
MIME-Version: 1.0
Subject: Re: Linux GPL and binary module exception clause?
CC: Linus Torvalds <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Message-ID: <3FD72F7E.4493.6296CE66@localhost>
In-reply-to: <20031210211541.GF4176@parcelfarce.linux.theplanet.co.uk>
References: <3FD7081D.31093.61FCFA36@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Dec 10, 2003 at 11:48:45AM -0800, Kendall Bennett wrote:
> > Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > > In fact, a user program written in 1991 is actually still likely
> > > to run, if it doesn't do a lot of special things. So user programs
> > > really are a hell of a lot more insulated than kernel modules, which
> > > have been known to break weekly. 
> > 
> > IMHO (and IANAL of course), it seems a bit tenuous to me the argument
> > that just because you deliberating break compatibility at the module
> > level on a regular basis, that they are automatically derived works.
> > Clearly the module interfaces could be stabilised and published, and if
> > you consider the instance of a single kernel version in time, that
> > module ABI *is* published and *is* stable *for that version*. Just
> > because you make an active effort to change things and actively *not*
> > document the ABI other than in the source code across kernel versions,
> > doesn't automatically make a module a derived work. 
> 
> Oh, for crying out loud!  Had you ever looked at that "API"?
> 
> At least 90% of it are random functions exposing random details of
> internals. Most of them are there only because some in-tree piece
> of code had been "modularized".  Badly. 

The fact that an API is 'badly' implemented does not detract from the 
fact that it is an API. It is still published as the mechanism that a 
module would use to load and interface to the kernel, via that API.

> In 2.7 we need to get the export list back to sanity.  Right now it's a
> such a junkpile that speaking about even a relative stability for it... 
> Not funny. 

You miss my point. I was talking about a single kernel version. For a 
single kernel version, the ABI is both *published* and *stable*. Sure it 
may not be what you consider a *clean* or *good* ABI, but it *IS* an ABI. 
Note that:

1. It is a published ABI because for that one kernel release, all the 
source code is available that documents the ABI (albiet badly IYO).

2. It is stable because that kernel version will never change on your 
machine.

Given that it is a stable and published ABI for a single kernel version, 
then what makes a kernel module different from a user program? The fact 
that binary only modules are *only* guaranteed to work with one single 
kernel version, the fact that the ABI changes from version to version is 
completely irrelevant to determing whether a binary module is derived 
from the kernel or not.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

