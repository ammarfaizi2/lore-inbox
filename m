Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266654AbUGVAed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266654AbUGVAed (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 20:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266660AbUGVAed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 20:34:33 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:55249 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266654AbUGVAeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 20:34:31 -0400
Date: Wed, 21 Jul 2004 17:33:57 -0700
From: Chris Wedgwood <cw@f00f.org>
To: L A Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.6.7-vanilla-SMP kernel: pagebuf_get: failed to lookup pages
Message-ID: <20040722003357.GA31163@taniwha.stupidest.org>
References: <40FF0479.6050509@tlinx.org> <20040722001224.GC30595@taniwha.stupidest.org> <40FF0885.7060704@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FF0885.7060704@tlinx.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 05:21:25PM -0700, L A Walsh wrote:

> Will this be included/fixed in 2.6.8?

i assume that's the intention but i don't know when 2.6.8 is and how
much time the sgi people have before then.  my guess is yes though

> How serious is the problem?  The system doesn't seem to panic or
> indicate backup failures.

not sure, hch can you comment here maybe?

> Setting up a CVS tree to get a patch for a "stable-series" kernel
> seems a bit unstable.

CVS is "stable linux releases + XFS fixes" --- it's really not that
bad (whilst i personally don't use it, my tree is derieved from it and
i don't have problems)

> I'm not sure what I'd pull in besides the fix or even if I'd pull
> down a coherent/stable CVS image if I downloaded in the middle of
> when some other patch was being checked in.

  cd path/to/workarea
  cvs -qz9 -d :pserver:cvs@oss.sgi.com:/cvs co linux-2.6-xfs
  cd linux-2.6-xfs
  cp path/to/old/.config .config
  make oldconfig
  make ...

> Maybe I'm sounding like a wimp, but the idea of pulling in freshly
> checked in CVS code for use on a 'stable' machine is bordering on my
> discomfort zone. :-)

FWIW, the CVS tree isn't freshly checked in, it's a reflection of the
internal ptools tree where in theory you shouldn't get adhoc checkins
like lots of places (but yeah, it does sometimes break but not usually
badly).

Anyhow, if you don't like it you can (1) ingnore the problems (2) use
official binary releases from vendors (3) use ext3, etc.

whatever works for you...


  --cw
