Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbWFITB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWFITB1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWFITB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:01:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:45207 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030399AbWFITBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:01:25 -0400
Message-ID: <4489C580.7080001@garzik.org>
Date: Fri, 09 Jun 2006 15:01:20 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org> <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:
> Now, granted, I really do agree with you about the whole code sharing 
> thing. A fresh start is often just what you need. I'm just questioning 
> if it wouldn't be better to do this fresh start immediately after going 
> 48-bit, rather than before. That way, existing users that want that 
> extra umph can have it today.

Then you continue to crap up the code with

	if (48bit)
		...
	else
		...

etc.

The proper way to do this is "cp -a ext3 ext4" (excluding JBD as Andrew 
mentioned), and then let evolution take its course.

"Evolution" means the standard Linux developement -- patch the kernel, 
patch e4fsprogs, test, lather rinse repeat.  The best development 
platform for new features is one that _works_, and keeps working.

	Jeff


