Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWFIPpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWFIPpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWFIPpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:45:05 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:49548 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030183AbWFIPpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:45:02 -0400
Message-ID: <44899778.1010705@garzik.org>
Date: Fri, 09 Jun 2006 11:44:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <m3r71ycprd.fsf@bzzz.home.net>
In-Reply-To: <m3r71ycprd.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>  JG> "ext3" will become more and more meaningless.  It could mean _any_ of 
>  JG> several filesystem metadata variants, and the admin will have no clue 
>  JG> which variant they are talking to until they try to mount the blkdev 
>  JG> (and possibly fail the mount).
> 
> debugfs <dev> -R stats | grep features ?

The question is, do you

a) expect users to run this magic command, and DTRT or

b) watch users boot w/ extents, accidentally do something silly like 
writing data to a file, and become locked into a new subset of kernels?

The simple act of writing data to a file has become an _irrevocable 
filesystem upgrade event_.

	Jeff



