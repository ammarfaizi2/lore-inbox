Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWFXVxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWFXVxQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 17:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWFXVxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 17:53:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27112 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964844AbWFXVxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 17:53:15 -0400
Date: Sat, 24 Jun 2006 14:53:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kmannth@gmail.com, linux-kernel@vger.kernel.org,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: 2.6.17-mm1
Message-Id: <20060624145305.9b4f9f65.akpm@osdl.org>
In-Reply-To: <20060624212706.GE2049@mars.ravnborg.org>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<a762e240606231339n11b8de89r37b9ff0401c50e21@mail.gmail.com>
	<20060623143205.9b8bfa96.akpm@osdl.org>
	<20060624212706.GE2049@mars.ravnborg.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006 23:27:06 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Fri, Jun 23, 2006 at 02:32:05PM -0700, Andrew Morton wrote:
> > On Fri, 23 Jun 2006 13:39:01 -0700
> > "Keith Mannthey" <kmannth@gmail.com> wrote:
> > 
> > > Andrew,
> > >   When I make mrproper to clean the kernel tree with the -mm trees (at
> > > least the last few releases) I end up having to remove
> > > /include/linux/dwarf2-defs.h myself.  This file is generated at build
> > > time but mrproper isn't cleaning it up.   This file is always present
> > > in a tree that has been built but not in the origninal tree so a diff
> > > of the tree picks it up.
> > > 
> > > Is this expected?
> > > 
> > 
> > No, it's not expected.  That's due to the kgdb patches.
> > 
> > Sam, what should we be doing here?
> 
> The dwarf2-defs.h file is similar to the asm-offsets.h file. We need it
> before starting to build the kernel.
> So the only same solution would be to move it all to the Kbuild file in
> the top-level directory. Then we should also let same Kbuild file take
> care of cleaning up.
> 
> I noticed that kgdb patches was dropped in -mm this time.
> Shall I try to cook up a patch next time you include kgdb?
> 

I wouldn't bother, really - we have bigger fish to fry.

I cc'ed Tom, who might care to take a look at it sometime.
