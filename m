Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUJAPiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUJAPiA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 11:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUJAPiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 11:38:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:11653 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261451AbUJAPh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 11:37:57 -0400
Date: Fri, 1 Oct 2004 08:31:10 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Robert Love <rml@novell.com>
Cc: mpm@selenic.com, ttb@tentacle.dhs.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org
Subject: Re: [patch] make dnotify compile-time configurable
Message-Id: <20041001083110.76a58fd2.rddunlap@osdl.org>
In-Reply-To: <1096644076.7676.6.camel@betsy.boston.ximian.com>
References: <1096611874.4803.18.camel@localhost>
	<20041001151124.GQ31237@waste.org>
	<1096644076.7676.6.camel@betsy.boston.ximian.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2004 11:21:16 -0400 Robert Love wrote:

| On Fri, 2004-10-01 at 10:11 -0500, Matt Mackall wrote:
| 
| > Indeed, it's been useful for months. Unfortunately my development
| > boxes are still mothballed so progress upstream is stalled.
| 
| Oh, great...
| 
| /me finds your broken out patches ...
| 
| Ah, you ifdef'ed out the dnotify variables in the inode structure.  That
| was the original reason I did this--doh.
| 
| In mine, I remove the sysctl entirely, which you don't.  I also add some
| documentation to dnotify.txt.  Not a big difference.
| 
| > > Disabling CONFIG_DNOTIFY saves a couple hundred bytes off of vmlinux.
| > 
| > Hmm, thought I saved at least 1 or 2k.
| 
| I thought my number sounded suspect.  Dunno.
| 
| Here is a respun patch ifdef'ing out the dnotify member variables in
| struct inode.  This one is diff'ed against my inode tree since the
| struct inode changes break one path or the other and, well, I like to
| mix things up.
| 
| John, want to merge this into the inotify patch?

I'd rather see inotify additions and dnotify config options kept
separate.  They may serve a similar purpose, but inotify doesn't
replace the dnotify API.  If the latter were true, combining
them would make sense IMO.


| Thanks, Matt.


-- 
~Randy
