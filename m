Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268598AbRH3ADg>; Wed, 29 Aug 2001 20:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268971AbRH3AD1>; Wed, 29 Aug 2001 20:03:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60553 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268598AbRH3ADV>;
	Wed, 29 Aug 2001 20:03:21 -0400
Date: Wed, 29 Aug 2001 17:03:15 -0700 (PDT)
Message-Id: <20010829.170315.28787631.davem@redhat.com>
To: bcrl@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blkgetsize64 ioctl
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0108291840310.28439-100000@toomuch.toronto.redhat.com>
In-Reply-To: <Pine.LNX.4.33.0108291840310.28439-100000@toomuch.toronto.redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben LaHaise <bcrl@redhat.com>
   Date: Wed, 29 Aug 2001 18:45:20 -0400 (EDT)

   The patch below reserves an ioctl for getting the size in blocks of a
   device as a long long instead of long as the old ioctl did.  The patch for
   this to e2fsprogs sneaked in a bit too early.  There is a conflict with
   the ia64 get/set sector ioctls, but I that's less common than e2fsprogs.

Any problems with using "u64" or some other more strictly portable
type?  "long long" and other non-fixed sized types cause grief for
many dual-API platforms.

Later,
David S. Miller
davem@redhat.com
