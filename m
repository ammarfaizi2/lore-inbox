Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbWFIP4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWFIP4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWFIP41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:56:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:31117 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965098AbWFIP4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:56:17 -0400
Message-ID: <44899A1C.7000207@garzik.org>
Date: Fri, 09 Jun 2006 11:56:12 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net>
In-Reply-To: <m3irnacohp.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Jeff Garzik (JG) writes:
> 
>  JG> think about The Experience:  Suddenly users that could use 2.4.x and 
>  JG> 2.6.x are locked into 2.6.18+, by the simple and common act of writing 
>  JG> to a file.
> 
> sorry to repeat, but if they simple try 2.6.18, they won't get extents.
> instead, they must specify extents mount option. and at this point
> they must get clear that this is a way to get incompatible fs.

Think about how this will be deployed in production, long term.

If extents are not made default at some point, then no one will use the 
feature, and it should not be merged.

And when extents are default, you have this blizzard-of-feature-flags 
stealth upgrade event occur _sometime_ after they boot into the new fs 
for the first time.  And then when they want to boot another kernel, 
they have to dig down a feature matrix, and figure out which ext3 
codebase will work for them.

	Jeff



