Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281961AbRKZTgl>; Mon, 26 Nov 2001 14:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282002AbRKZTge>; Mon, 26 Nov 2001 14:36:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21121 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282000AbRKZTgN>;
	Mon, 26 Nov 2001 14:36:13 -0500
Date: Mon, 26 Nov 2001 11:35:55 -0800 (PST)
Message-Id: <20011126.113555.102784070.davem@redhat.com>
To: akpm@zip.com.au
Cc: mingo@elte.hu, bcrl@redhat.com, velco@fadata.bg,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable page cache
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C02980E.8EDED15D@zip.com.au>
In-Reply-To: <Pine.LNX.4.33.0111262115261.17043-100000@localhost.localdomain>
	<20011126.103327.18298379.davem@redhat.com>
	<3C02980E.8EDED15D@zip.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Mon, 26 Nov 2001 11:29:19 -0800

   "David S. Miller" wrote:
   > Maybe you should give it a test to find out for sure :)
   
   umm..  I've never seen any numbers from you, David.
   
I'll work on something for you this week then :-)
Not a problem.

   ergo, there is no point in futzing with the pagecache_lock *at all*
   until either TUX is merged, or we decide to support large-scale
   NUMA hardware well
   
Or your "1a", "other sendfile applications", right?

I really still feel (and will try to show with numbers) that the copy
being present is not so important.  Like I have stated on other
occaisions, several platforms do not harm L2 cache state during
copies, new lines are never brought in.

I expect x86 systems to move more in this direction if they aren't
somewhat there already.
