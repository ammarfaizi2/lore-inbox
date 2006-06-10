Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWFJCMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWFJCMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 22:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWFJCMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 22:12:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:60589 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750721AbWFJCML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 22:12:11 -0400
Message-ID: <448A2A6F.8020301@garzik.org>
Date: Fri, 09 Jun 2006 22:11:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <20060609194959.GC10524@thunk.org> <4489D44A.1080700@garzik.org> <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk> <4489ECDD.9060307@garzik.org> <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org> <20060610004727.GC7749@thunk.org> <448A1BBA.1030103@garzik.org> <20060610013048.GS5964@schatzie.adilger.int> <448A23B2.5080004@garzik.org> <20060610020306.GA449@thunk.org>
In-Reply-To: <20060610020306.GA449@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Fri, Jun 09, 2006 at 09:43:14PM -0400, Jeff Garzik wrote:
>>> ???  Can you please be specific in what the performance penalty is, and
>>> what specifically is "not sized optimally" after a resize?  How exactly
>>> does inode allocation strategy relate to anything at all to online 
>>> resizing.
>> Inodes per group / inode blocks per group, as I've already stated.
> 
> Inodes per group and inode blocks per group are maintained
> across an online resize.

That's the problem I'm pointing out.


> So there is no difference in inodes per
> group for a filesystem created at size S1 and resized to size S2
> (using either an on-line or off-line resize), and a filesystem which
> is created to be size S2.

Trivial to prove false, by your statement above if nothing else.  But 
anyway:
Run mke2fs on a blkdev of size 500MB, and one of 500GB.  Note values.
Now resize blkdev formatted for size 500MB to 500GB, and note differences.

	Jeff



