Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTDWXzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTDWXzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:55:06 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:34014 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S264331AbTDWXzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:55:03 -0400
Date: Thu, 24 Apr 2003 12:02:30 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Fix SWSUSP & !SWAP
In-reply-to: <20030424000344.GC32577@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-id: <1051142550.4306.10.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com>
 <20030424000344.GC32577@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't believer I've ever seen things get OOM killed. Instead, page
cache is discarded until things do fit.

Regards,

Nigel

On Thu, 2003-04-24 at 12:03, Pavel Machek wrote:
> Hi!
> 
> > > From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
> > > Can't you just create a pre-reserved separate swsusp area on 
> > > disk the size 
> > > of RAM (maybe a partition rather than a file to make things 
> > > easier), and 
> > > then you know you're safe (basically what Marc was 
> > > suggesting, except pre-allocated)? Or does that make me the 
> > > prince of all evil? ;-)
> > > 
> > > However much swap space you allocate, it can always all be 
> > > used, so that seems futile ...
> > 
> > This is what Other OSes do, and I believe this is the correct path.
> > Using swap for swsusp is a clever hack but not a 100% solution.
> 
> Well, for normal use its clearly inferior -- suspend partition is unused
> when it could be used for speeding system up by swapping out unused
> stuff.
> 
> OtherOS approach is better because it can guarantee suspend-to-disk
> for critical situations like overheat or battery-critical.
> 
> But we can get best of both worlds if we OOM-kill during critical
> suspend. [If suspend partition was not used for swapping, machine
> would *already* OOM-killed someone, so we are only improving stuff].
> 
> 						Pavel  
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

