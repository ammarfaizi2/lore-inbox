Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWFISsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWFISsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWFISsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:48:50 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:23701 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030381AbWFISss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:48:48 -0400
Message-ID: <4489C280.2090607@garzik.org>
Date: Fri, 09 Jun 2006 14:48:32 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
       Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net> <44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net> <4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net> <44899113.3070509@garzik.org> <20060609165643.GA5964@schatzie.adilger.int>
In-Reply-To: <20060609165643.GA5964@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> Except that the only way that they will get extents is if they read some
> documentation that tells them to mount with "-o extents", which will also
> say "this is incompatible with older kernels - only use it if you aren't
> going to revert to older kernels".  If they try to mount such a filesystem
> it will report "trying to mount filesystem with incompatible feature",
> and "e2fsprogs" will report "incompatible feature extents - please upgrade
> your e2fsprogs" (for versions newer than Nov 2004).

False.  What will happen is that distros will default to extents, and 
users will continue to not read documentation, as usual.


> It's a lot better than e.g. the latest ubuntu which (apparently,
> I read) can't mount a kernel older than 2.6.15 because of udev (or
> sysfs?) changes.  It's better than e.g. reiserfs vs. reiser4 compatibility
> (which doesn't exist).  2.4 kernels probably can't mount a new udev root
> filesystem because none of the /dev files exist either.  2.4 kernels can't
> mount a filesystem that is using device mapper ("LVM 2.0") instead of
> "LVM 1.0".  All 2.2 kernel.org kernels couldn't use any system with RAID,
> because any distro worth its salt had upgraded the RAID code to a working
> (incompatible) version.

This is different.

The proposal is to change the thing called "ext3" to suddenly require 
kernels >= 2.6.18, while still calling it "ext3."

The above examples are actually proving my point.  The above examples 
had much more clear distinctions between incompatible upgrades.


> Nobody is forcing users to use extents.   Same with large inodes in ext3,
> which give a 7x speedup in samba4 performance - did this cause you any
> heartburn yet?   Large inodes + fast EAs are available for people who want
> to use it for a couple of years already, will soon allow nanosecond times
> and maybe one day in the distant future it will become the default but not
> yet.  In a few years, the support for extents in ext3 will be pervasive
> and most people won't care if they can boot to 2.4.10 or not, and if they
> care about this they will also know enough not to enable extents.  The ext3
> developers are a very cautious bunch, and don't force anything onto users.

I wouldn't use the word "cautious" to describe continually adding new, 
incompatible features to the main Linux filesystem.

You are as cautious as one can be, while adding potentially 
destabilizing features.

	Jeff


