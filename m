Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266664AbUBFHOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 02:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUBFHOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 02:14:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:48008 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266664AbUBFHOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 02:14:11 -0500
Subject: Re: HFSPLus driver for Linux 2.6.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dylan Griffiths <dylang+kernel@thock.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20040205200217.360c51ab.akpm@osdl.org>
References: <402304F0.1070008@thock.com>
	 <20040205191527.4c7a488e.akpm@osdl.org> <40231076.7040307@thock.com>
	 <20040205200217.360c51ab.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1076051611.885.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 06 Feb 2004 18:13:32 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-06 at 15:02, Andrew Morton wrote:
> Dylan Griffiths <dylang+kernel@thock.com> wrote:
> >
> > 	I don't remember where I grabbed this driver, I only know it's much 
> >  more current than the one at 
> >  http://sourceforge.net/projects/linux-hfsplus.
> 
> Sorry, that's a showstopper.  We need to understand who the maintenance
> team is, and evaluate their preparedness to maintain this code long-term.
> 
> We don't want to be adding yet another rarely-used filesystem which has no
> visible maintenance team.

It's a not-that-rarely used filesystem actually :) Been in my tree for
a few monthes and it's used by pmac users either for iPod's or for
accessing the MacOS X partitions.

It's written & maintained by Roman Zippel, and the latest snapshot is
available at http://www.ardistech.com/hfsplus/ but you probably want
to ask Roman if it's really the latest version before merging :)

One thing we absolutely need too is a port of Apple's fsck for HFS+,
currently, the driver will refuse to mount read/write a "dirty"
HFS+ filesystem to avoid corruption, but that means we have to reboot
MacOS to fsck it then... But that limitation shouldn't prevent merging
it.

I suppose it may be good to also merge Roman's cleanup/rewrite of
the old HFS filesytem...

Ben.
 


