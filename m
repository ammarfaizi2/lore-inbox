Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWFISwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWFISwF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWFISwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:52:04 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:38549 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030387AbWFISwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:52:02 -0400
Message-ID: <4489C34B.1080806@garzik.org>
Date: Fri, 09 Jun 2006 14:51:55 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Matthew Frost <artusemrys@sbcglobal.net>, Alex Tomas <alex@clusterfs.com>,
       Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int>
In-Reply-To: <20060609181426.GC5964@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Jun 09, 2006  13:04 -0500, Matthew Frost wrote:
>> Alex Tomas wrote:
>>> sorry, I disagree. for example, NUMA isn't default and shouldn't be.
>>> but we have it in the tree and any one may choose to use it.
>> NUMA is designed to cope with a hardware feature, which not everybody 
>> has.  Filesystem upgrades are not qualitatively similar; it does not 
>> depend on one's hardware design as to whether one uses ext3, let alone 
>> extents.  Your logic is faulty.
> 
> If you have a > 8TB block device (which is common in large RAID devices
> today, will be a single disk in a couple of years) then it is important
> that your filesystem work with this block device.
> 
> If ext2 and ext3 didn't support > 2GB files (which was a filesystem
> feature added in exactly the same way as extents are today, and nobody
> bitched about it then) then they would be relegated to the same status
> as minix and xiafs and all the other filesystems that are stuck in the
> "we can't change" or "we aren't supported" camps.

PRECISELY.  So you should stop modifying a filesystem whose design is 
admittedly _not_ modern!

ext3 is already essentially xiafs-on-life-support, when you consider 
today's large storage systems and today's filesystem technology.  Just 
look at the ugly hacks needed to support expanding an ext3 filesystem 
online.

	Jeff



