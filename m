Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbTHVA5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262975AbTHVA5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:57:06 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:56500 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262948AbTHVA5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:57:02 -0400
Subject: Re: Hang when mounting XFS root in 2.6.0 tests on x86-64
From: Steve Lord <lord@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: Chris Meadors <clubneon@hereintown.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
In-Reply-To: <m3r83en2th.fsf@averell.firstfloor.org>
References: <n4o5.8ga.21@gated-at.bofh.it> 
	<m3r83en2th.fsf@averell.firstfloor.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 21 Aug 2003 19:55:32 -0500
Message-Id: <1061513734.1622.55.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-21 at 16:00, Andi Kleen wrote:
> Chris Meadors <clubneon@hereintown.net> writes:
> 
> Better report it to linux-xfs@oss.sgi.com (cc'ed) too.
> 
> > I'm trying to get a 2.6.0-test kernel to boot on my Opteron system.  It
> > has SuSE's 2.4.19-SMP kernel on it now, and it boots with that, mounts
> > the XFS root just fine.  But I build a vanilla 2.6.0-test3 with no
> > module support, everything included that I would need.  The last line
> > that it prints during boot is the NET4.0
> >
> > Repeated presses of Alt+SysRq+P seems to show RIP looping in xfs_xlatesb
> > and xfs_lowbit64.

Seems to suggest a platform specific problem with this code, Andi,
didn't you write the function behind xfs_lowbit64?

> >
> > I've tried -test3-bk9 and also went back to -test2 and -test1.
> >
> > Earlier when playing with this machine I built 2.6.0-test3 with a 32 bit
> > only version of gcc, but still optimized for the Opteron.  This one had
> > no problem booting and mounting the XFS root.
> >
> > This is easy to reproduce, so let me know if more information is needed.
> 
> I test XFS (but not as root) occasionally on x86-64 and seen no problems 
> so far. I haven't tested it with test2+ yet though.

This code chunk will be the same no matter which filesystem you are
mounting, if the hang happened on an xfs root, I would expect to see
it on any xfs filesystem with that kernel.

> 
> What compiler are you using?
> 

Some disassembly output and help from someone who can read it might
be in order here.

Steve



