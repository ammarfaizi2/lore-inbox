Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbUKJPLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUKJPLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 10:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbUKJPKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 10:10:36 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:9876 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261997AbUKJPHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 10:07:12 -0500
Date: Wed, 10 Nov 2004 07:06:47 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Larry McVoy <lm@bitmover.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: bk-commits: diff -p?
Message-ID: <20041110150646.GA10537@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Larry McVoy <lm@bitmover.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0411080940310.27771@anakin> <20041108164302.GA489@work.bitmover.com> <1100043712.21273.26.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100043712.21273.26.camel@baythorne.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 11:41:52PM +0000, David Woodhouse wrote:
> On Mon, 2004-11-08 at 08:43 -0800, Larry McVoy wrote:
> > This has been fixed in the following releases:
> > 
> > bk-3.2.3
> > bk-3.2.2c
> > bk-3.2.2b
> > 
> > Correct usage is "bk diffs -up" which will get you unified + procedural diffs.
> > -p is currently a hack, it implies -u, but don't depend on that behaviour,
> > a future release does this correctly and if you teach your fingers that 
> > diffs -p is the same as diffs -up you'll get burned later.
> 
> Actually my script is using 'bk export -du -tpatch -r$CSET'. '-dup'
> doesn't seem to do the right thing.

OK, this is a hack but I think you can make it work.  Try moving
`bk bin`/diff `bk bin`/diff.orig and putting in a shell 
script for `bk bin`/diff that just adds $BK_GNU_DIFF_OPTS to the 
options and execs `bk bin`/diff.orig
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
