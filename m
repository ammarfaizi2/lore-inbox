Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbUD2Bm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbUD2Bm5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbUD2Bm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:42:57 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:55055 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S262796AbUD2BmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:42:15 -0400
To: Jeff Garzik <jgarzik@pobox.com>,
       "Cc@tellurium.ssi.swin.edu.au":Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	linux-kernel@vger.kernel.org
			^-missing semicolon to end mail group
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	linux-kernel@vger.kernel.org
			^-missing semicolon to end mail group
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	linux-kernel@vger.kernel.org
			^-missing semicolon to end mail group
From: Tim Connors <tconnors+linuxkernel1083202568@astro.swin.edu.au>
Subject: Re:  ~500 megs cached yet 2.6.5 goes into swap hell
In-reply-to: <40905127.3000001@fastclick.com>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40905127.3000001@fastclick.com>
X-Face: "/6m>=uJ8[yh+S{nuW'%UG"H-:QZ$'XRk^sOJ/XE{d/7^|mGK<-"*e>]JDh/b[aqj)MSsV`X1*pA~Uk8C:el[*2TT]O/eVz!(BQ8fp9aZ&RM=Ym&8@.dGBW}KDT]MtT"<e(`rn*-w$3tF&:%]KHf"{~`X*i]=gqAi,ScRRkbv&U;7Aw4WvC
X-Face-Author: David Bonde mailto:i97_bed@i.kth.se.REMOVE.THIS.TO.REPLY -- If you want to use it please also use this Authorline.
Message-ID: <slrn-0.9.7.4-25418-11378-200404291136-tc@hexane.ssi.swin.edu.au>
Date: Thu, 29 Apr 2004 11:41:34 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brett E." <brettspamacct@fastclick.com> said on Wed, 28 Apr 2004 17:49:43 -0700:
> Or how about "Use ALL the cache you want Mr. Kernel.  But when I want 
> more physical memory pages, just reap cache pages and only swap out when 
> the cache is down to a certain size(configurable, say 100megs or 
> something)."

Oh how dearly I would love that...

I have a huge app that operates on a large file (but both are a bit
smaller than available memory, by maybe a hundred or two megs - enough
for to keep the entire working set in RAM, anyway). I create these
large files over and over (on another host, so cache does absolutely
no good whatsoever, since we are streaming a read once), but don't
delete the old ones, so they all remain in cache. So when I close one
copy of the app, and open up a new one on a different file, when it
comes time to allocate those several hundred megs, it rather blows
away my mozilla or my X session(! -- since I need it to display the
results) or my window manager, and keeps growing that cache.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
When you are chewing on life's grissle, don't grumble - give a whistle!
This'll help things turn out for the best
Always look on the bright side of life
