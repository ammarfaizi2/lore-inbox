Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVIPXjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVIPXjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVIPXjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:39:12 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:41642 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750738AbVIPXjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:39:11 -0400
Date: Fri, 16 Sep 2005 19:36:24 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.14-rc1 on ATI hangs when executing _STA and _INI
  methods
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Peter Osterlund <petero2@telia.com>
Message-ID: <200509161938_MC3-1-AA5F-2E2A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.58.0509141521370.26803@g5.osdl.org>

On Wed, 14 Sep 2005 at 15:27:19 -0700 (PDT), Linus Torvalds wrote:

> >     [PATCH] x86-64: i386/x86-64: Fix time going twice as fast problem on ATI Xpress chipsets
> > 
> > Passing enable_timer_pin_1 as a kernel boot parameter doesn't help,
> > but this patch does:
> 
> Ok. That patch has been one big pain, and was clearly totally half-baked.  
> I think I'll disable the automated checks, since they are clearly wrong.

 Well I never meant it to be merged, but Andi picked it up from Bugzilla
bug #3927, added some bugs of his own, then sent it on.

 This bug was mine, though: just checking for vendor == ATI was a bad idea.
Current earlyquirk code actually looks at PCI bridges instead of host bridge,
so to get an accurate test I guess it needs to look at PCI dev 00:00.0 and
check both vendor and device ID.  As new models come out they will have to
be added one by one.

 With a real understanding of what's going on maybe this problem can be solved
reliably with generic code, but it's beyond me...
__
Chuck
Subliminal URL: www.sluggy.com/daily.php?date=050905
