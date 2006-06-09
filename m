Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWFIPZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWFIPZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbWFIPZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:25:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:62603 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965286AbWFIPZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:25:34 -0400
Message-ID: <448992EB.5070405@garzik.org>
Date: Fri, 09 Jun 2006 11:25:31 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
CC: Andreas Dilger <adilger@clusterfs.com>, cmm@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org>
In-Reply-To: <44898EE3.6080903@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Overall, I'm surprised that ext3 developers don't see any of the 
problems related to progressive, stealth filesystem upgrades.

Users are never given a clear indication of when their metadata is being 
upgraded, there is no clear "line of demarcation" they cross, when they 
start using extents.

Since there is no user-visible fs upgrade event, users do not have a 
clear picture of what features are being used -- which means they are 
kept in the dark about which kernels are OK to use on their data.

Do you guys honestly expect users to keep track of which kernels added 
specific ext3 features?

This is why other enterprise filesystems have clear "fs version 1", "fs 
version 2" points across which a user migrates.  ext3's feature-flags 
approach just means that there are a million combinations of potential 
old-and-new features, in-tree and third party, all of which must be 
supported.

	Jeff


