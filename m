Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUG2E64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUG2E64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 00:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUG2E64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 00:58:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46030 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264192AbUG2E6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 00:58:54 -0400
Date: Thu, 29 Jul 2004 15:54:37 +1000
From: Nathan Scott <nathans@sgi.com>
To: L A Walsh <lkml@tlinx.org>, Chris Wedgwood <cw@f00f.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.6.7-vanilla-SMP kernel: pagebuf_get: failed to lookup pages
Message-ID: <20040729055437.GL800@frodo>
References: <40FF0479.6050509@tlinx.org> <20040722001224.GC30595@taniwha.stupidest.org> <40FF0885.7060704@tlinx.org> <20040722003357.GA31163@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722003357.GA31163@taniwha.stupidest.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 05:33:57PM -0700, Chris Wedgwood wrote:
> On Wed, Jul 21, 2004 at 05:21:25PM -0700, L A Walsh wrote:
> 
> > Will this be included/fixed in 2.6.8?
> 
> i assume that's the intention but i don't know when 2.6.8 is and how
> much time the sgi people have before then.  my guess is yes though

The fix has been included in the 2.6.8-pre/rc kernels for some
time now, so yes it'll be in 2.6.8.

> > How serious is the problem?  The system doesn't seem to panic or
> > indicate backup failures.
> 
> not sure, hch can you comment here maybe?

This leaked locked pages on metadata readahead failure (which
could occur when free memory becomes low), which is serious.

cheers.

-- 
Nathan
