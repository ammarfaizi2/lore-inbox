Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUE1Qyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUE1Qyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 12:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUE1Qyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 12:54:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:16527 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261610AbUE1Qyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 12:54:45 -0400
Subject: Re: filesystem corruption (ReiserFS, 2.6.6): regions replaced by
	\000 bytes
From: Chris Mason <mason@suse.com>
To: Pat <finnegpt@purdue.edu>
Cc: linux-kernel@vger.kernel.org, David Madore <david.madore@ens.fr>
In-Reply-To: <200405281142.54299.finnegpt@purdue.edu>
References: <20040528122854.GA23491@clipper.ens.fr>
	 <20040528162450.GE422@louise.pinerecords.com>
	 <1085761753.22636.3329.camel@watt.suse.com>
	 <200405281142.54299.finnegpt@purdue.edu>
Content-Type: text/plain
Message-Id: <1085763295.22636.3332.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 May 2004 12:54:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 12:42, Pat wrote:
> On Friday 28 May 2004 11:29, Chris Mason wrote:
> > On Fri, 2004-05-28 at 12:24, Tomas Szepe wrote:
> > > On May-28 2004, Fri, 08:46 -0400
> > >
> > > Chris Mason <mason@suse.com> wrote:
> > > > > The bottom line: I've experienced file corruption, of the
> > > > > following nature: consecutive regions (all, it seems, aligned
> > > > > on 256-byte boundaries, and typically around 1kb or 2kb in
> > > > > length) of seemingly random files are replaced by null bytes.
> > > >
> > > > The good news is that we tracked this one down recently. 
> > > > 2.6.7-rc1 shouldn't do this anymore.
> > >
> > > So did this only affect SMP machines?
> >
> > No, if you slept in the right spot you could hit it on UP.
> 
> I saw this once when using 2.6.6, it was messing up the filesystem 
> structures as well (ext2 & ext3), replacing mostly with nulls, some 
> with random letters and numbers, for 4-6 character lengths, and not on 
> any nice boundaries.  Since I stopped trying to use the ATI framebuffer 
> driver (this is on a 21164A alpha, 164LX motherboard, ATI Mach64 CT 
> video), it seems to have stopped.  Also, I noticed that the framebuffer 
> driver didn't work so well.
> 
This is different.   The reiserfs bug can only trigger data corruptions
in reiserfs, and won't trigger metadata problems.

-chris


