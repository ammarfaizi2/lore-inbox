Return-Path: <linux-kernel-owner+w=401wt.eu-S932151AbXAFUSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbXAFUSS (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbXAFUSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:18:18 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38758 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151AbXAFUSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:18:17 -0500
Date: Sat, 6 Jan 2007 12:17:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <randy.dunlap@oracle.com>,
       "J.H." <warthog9@kernel.org>, Willy Tarreau <w@1wt.eu>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-Id: <20070106121728.1b2946dc.akpm@osdl.org>
In-Reply-To: <45A002FE.8060700@garzik.org>
References: <20061214223718.GA3816@elf.ucw.cz>
	<20061216094421.416a271e.randy.dunlap@oracle.com>
	<20061216095702.3e6f1d1f.akpm@osdl.org>
	<458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<20061219063413.GI24090@1wt.eu>
	<1166511171.26330.120.camel@localhost.localdomain>
	<20070106103331.48150aed.randy.dunlap@oracle.com>
	<459FF60D.7080901@zytor.com>
	<45A002FE.8060700@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jan 2007 15:13:50 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> H. Peter Anvin wrote:
> > Randy Dunlap wrote:
> >>
> >>>> BTW, yesterday my 2.4 patches were not published, but I noticed that
> >>>> they were not even signed not bziped on hera. At first I simply thought
> >>>> it was related, but right now I have a doubt. Maybe the automatic 
> >>>> script
> >>>> has been temporarily been disabled on hera too ?
> >>> The script that deals with the uploads also deals with the packaging -
> >>> so yes the problem is related.
> >>
> >> and with the finger_banner and version info on www.kernel.org page?
> > 
> > Yes, they're all connected.
> > 
> > The load on *both* machines were up above the 300s yesterday, probably 
> > due to the release of a new Knoppix DVD.
> > 
> > The most fundamental problem seems to be that I can't tell currnt Linux 
> > kernels that the dcache/icache is precious, and that it's way too eager 
> > to dump dcache and icache in favour of data blocks.  If I could do that, 
> > this problem would be much, much smaller.
> 
> Have you messed around with /proc/sys/vm/vfs_cache_pressure?
> 
> Unfortunately that affects all three of: dcache, icache, and mbcache. 
> Maybe we could split that sysctl in two (Andrew?), so that one sysctl 
> affects dcache/icache and another affects mbcache.
> 

That would be simple enough to do, if someone can demonstrate a
need.

