Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWFIUEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWFIUEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbWFIUEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:04:46 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:44704 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030470AbWFIUEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:04:37 -0400
Message-ID: <4489D44A.1080700@garzik.org>
Date: Fri, 09 Jun 2006 16:04:26 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
       Matthew Frost <artusemrys@sbcglobal.net>,
       Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org> <20060609194959.GC10524@thunk.org>
In-Reply-To: <20060609194959.GC10524@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Fri, Jun 09, 2006 at 02:51:55PM -0400, Jeff Garzik wrote:
>> ext3 is already essentially xiafs-on-life-support, when you consider 
>> today's large storage systems and today's filesystem technology.  Just 
>> look at the ugly hacks needed to support expanding an ext3 filesystem 
>> online.
> 
> And what ugly hacks are you talking about?  It's actually quite clean;
> with the latest e2fsprogs, you use the same command (resize2fs) for
> doing both online and offline resizing.

Consider a blkdev of size S1.  Using LVM we increase that value under 
the hood to size S2, where S2 > S1.  We perform an online resize from 
size S1 to S2.  The size and alignment of any new groups added will 
different from the non-resize case, where mke2fs was run directly on a 
blkdev of size S2.

	Jeff



