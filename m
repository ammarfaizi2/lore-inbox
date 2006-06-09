Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWFISnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWFISnO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWFISnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:43:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8085 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030374AbWFISnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:43:13 -0400
Message-ID: <4489C13C.90302@garzik.org>
Date: Fri, 09 Jun 2006 14:43:08 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<m33beecntr.fsf@bzzz.home.net>	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>	<20060609181020.GB5964@schatzie.adilger.int>	<Pine.LNX.4.64.0606091114270.5498@g5.osdl.org> <m31wty9o77.fsf@bzzz.home.net>
In-Reply-To: <m31wty9o77.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Linus Torvalds (LT) writes:
>  LT> My point is, maintaining two different pieces is SIMPLER.
> 
> "different" is a key word here. why should we copy most of ext3 code
> into ext4?
> 
>  LT> It would be bigger, if you made ext3 do 48-bit block numbers.
> 
> nope, we re-use existing i_data w/o any changes. yes, we've made
> inode a bit larger to cache last found extent. this improves
> performance in some workloads noticable though.
> 
>  LT> See? ext3 would become strictly _worse_ for the majority of users, who 
>  LT> wouldn't get any advantage. That's my point.
> 
> would "#if CONFIG_EXT3_EXTENTS" be a good solution then?

No, that would be worse.

	Jeff



