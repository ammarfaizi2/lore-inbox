Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTDTUWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 16:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTDTUWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 16:22:39 -0400
Received: from hera.cwi.nl ([192.16.191.8]:55244 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263691AbTDTUWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 16:22:39 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 22:34:38 +0200 (MEST)
Message-Id: <UTC200304202034.h3KKYct01306.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH] new system call mknod64
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Christoph Hellwig <hch@infradead.org>

    On Sun, Apr 20, 2003 at 08:39:32PM +0200, Andries.Brouwer@cwi.nl wrote:
    > Change the type of the mknod arg from dev_t to unsigned int.
    > Add (for i386) mknod64.

    Please make the argument for mknod/mknod64 __u32/__u64.  And I
    don't think adding the syscall makes sense before the internal
    dev_t representation has changed.

Yes, there is a dozen rather uninteresting patches that can
be applied any moment. But a new system call is more important,
so I show it in public at some earlier stage, so that Linus and
others, like you, can comment.

Yesterday or the day before Linus preferred __u32 etc for this
loopinfo64 ioctl, so I did it that way. Here, since mknod is a
traditional Unix system call, I am still inclined to prefer
(unsigned) int above __u32.  Of course it doesn't matter much.

Andries
