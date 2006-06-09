Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWFIUbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWFIUbX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWFIUbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:31:23 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:17058 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932173AbWFIUbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:31:22 -0400
Message-ID: <4489DA95.9030703@garzik.org>
Date: Fri, 09 Jun 2006 16:31:17 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org> <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <20060609201643.GG5964@schatzie.adilger.int>
In-Reply-To: <20060609201643.GG5964@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> The other issue is that adding a new "ext4" filesystem type will cause
> userspace tools to break that assume they know something about the
> filesystem type.  They will all detect the filesystem as "ext3" and try
> to mount it as such, when the required kernel filesystem is ext4.  Or
> we will need to have "mkfs.ext4", "fsck.ext4", etc, for no particular
> reason.

Yes, you want those tools, and you want to call the filesystem ext4. 
Otherwise you'll never break free of the existing metadata formats 
(which are apparently changing over time _anyway_).


> Either a system upgrades totally to ext4 to avoid the duplication of code
> in memory (and breaks ALL backward compatibility, for no good reason), or

Correct.  You must upgrade totally to ext4.

And this happens ANYWAY once extents/etc. are enabled.  Its an upgrade.

	Jeff


