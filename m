Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265958AbUGIWAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUGIWAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUGIWAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 18:00:38 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:35051 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265958AbUGIWAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 18:00:34 -0400
Date: Fri, 9 Jul 2004 14:59:55 -0700
From: Chris Wedgwood <cw@f00f.org>
To: L A Walsh <lkml@tlinx.org>
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040709215955.GA24857@taniwha.stupidest.org>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <40EEC9DC.8080501@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EEC9DC.8080501@tlinx.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 09:37:48AM -0700, L A Walsh wrote:

> Even after multiple syncs, files edited within the past few days
> will sometimes go mysteriously null.  Good reason to do daily
> backups as the backups will usually contain the correct file...

I *never* see this even when beating the hell out of machines and
trying to break things.

I do see nulls in cases where the metadata was updated and the data
didn't flush, that's supposed to happen.

> Now if we could just come up with a reproducable test case...but
> when I try to reproduce it, it doesn't.  Grrr....it knows when I'm
> scrutinizing!! :-)

Use anything that handles dotfiles or configuration badly (ie. KDE),
make some changes or just 'run it' for a bit.  Every now something
rewrites some files.  Yank the power a few times and sooner or later
you'll end up with problems under KDE certainly.

Sane applications (MTAs like postfix for example) don't have this
problem because they were written with more clue.  If they did have
this problem people would scream, because mail would get lost...  and
large mail servers might have tens of thousands of files moving about
in-flight, much more strenuous that a few dot-files.


  --cw
