Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVFQSyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVFQSyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVFQSyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:54:23 -0400
Received: from peabody.ximian.com ([130.57.169.10]:19355 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262061AbVFQSyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:54:03 -0400
Subject: Re: [patch] inotify.
From: Robert Love <rml@novell.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050617184550.GA20822@infradead.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net>
	 <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de>
	 <20050617175404.GA19463@infradead.org> <1119032213.3949.124.camel@betsy>
	 <20050617182826.GA20250@infradead.org> <1119033486.3949.135.camel@betsy>
	 <20050617184550.GA20822@infradead.org>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 14:54:01 -0400
Message-Id: <1119034441.3949.145.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 19:45 +0100, Christoph Hellwig wrote:

> inotify does indeed use file->private data to retrieve the inotify_dev
> structure.  Of which by design exists a single instance only.  So yes,
> you do not use the file descriptor at all.

Sorry, I am not following how we "do not use the file descriptor at
all".  It is given to the ioctl and, as you said, used to find the
inotify_dev.  The file descriptor maps to the device, and vice versa.

You _can_ have multiple open devices per process.

> And a default limit matters exactly how?

Because we want people to actually use inotify, to make the desktop
better, and in the real world "become root and bump the fd limit" is not
always feasible.  The fd limit might be low for other reasons.

> Thanks a lot, I'm enjoying life a lot when I don't happen to have to deal
> with ignorant people :)

Just because we disagree does not make either of us ignorant.  Indeed,
even if one of us were wrong, we need not be ignorant--wrong word.
Neither of us is untaught on or unacquainted with the kernel.  We are
just viewing things differently.

	Robert Love


