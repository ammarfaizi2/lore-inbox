Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWFIOzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWFIOzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWFIOzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:55:21 -0400
Received: from [80.71.248.82] ([80.71.248.82]:37297 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030190AbWFIOzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:55:15 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Christoph Hellwig <hch@infradead.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net>
	<44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net>
	<4489874C.1020108@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 18:57:10 +0400
In-Reply-To: <4489874C.1020108@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 10:35:56 -0400")
Message-ID: <m3y7w6cr7d.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Jeff Garzik (JG) writes:

 JG> Alex Tomas wrote:
 >>>>>>> Jeff Garzik (JG) writes:
 JG> And thus, inodes are progressively incompatible with older
 JG> kernels. Boot into an older kernel, and you can now only read half
 JG> your filesystem (if it even allows mount at all).
 >> nope, you aren't allowed to mount fs with extents-enabled files
 >> by ext3 which has no the feature compiled in. the same will
 >> happen if you call it ext4.

 JG> This is my point...  why increase user confusion by calling it ext3, then?

by default it's still old good ext3 without extents. user should
enable it explicitly. for him, this means the feature is ready
to be used anytime. the only thing he needs is to (re)mount fs
with the option. for us, this means: a) a single source tree -
easy to maintain b) we must be clear with user that the feature
isn't backward compatible

thanks, Alex

PS. in the end this is just ext3 with one more feature ...
