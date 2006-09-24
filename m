Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWIXVyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWIXVyT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWIXVyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:54:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751622AbWIXVyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:54:18 -0400
Date: Sun, 24 Sep 2006 14:53:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>,
       ext2-devel@lists.sourceforge.net, reiserfs-dev@namesys.com
Subject: Re: [2.6.18-rc7-mm1] slow boot
Message-Id: <20060924145337.ae152efd.akpm@osdl.org>
In-Reply-To: <4516B966.3010909@imap.cc>
References: <4516B966.3010909@imap.cc>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 18:59:18 +0200
Tilman Schmidt <tilman@imap.cc> wrote:

> In the end, the mm kernel has taken twice as much time to get up
> and running as the mainline kernel.

Don't know, sorry.

make-ext3-mount-default-to-barrier=1.patch takes my laptop's bootup time
from 53 seconds to 68, which is rather painful.  In fact I'm inclined to
drop the patch because of this, and I'd also be quite concerned about the
similar reiserfs patch, make-reiserfs-default-to-barrier=flush.patch.

I've *never* seen any reports of any problems being caused by disk
writeback caching.  Yes, it's a theoretical problem but for some reason it
just doesn't seem to be a problem in practice.  Hence I'm really reluctant
to go and slow everyone's machines down so much in this manner.

But apart from that problem I see no differences in bootup time between
2.6.18 and 2.6.18-mm1.

Do you have the time to go through the
http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
process?
