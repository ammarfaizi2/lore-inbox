Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279596AbRKIHZa>; Fri, 9 Nov 2001 02:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279674AbRKIHZX>; Fri, 9 Nov 2001 02:25:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21890 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279596AbRKIHYe>;
	Fri, 9 Nov 2001 02:24:34 -0500
Date: Thu, 08 Nov 2001 23:24:25 -0800 (PST)
Message-Id: <20011108.232425.21928928.davem@redhat.com>
To: akpm@zip.com.au
Cc: ak@suse.de, anton@samba.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BEB82B8.541558CA@zip.com.au>
In-Reply-To: <3BEB7DA6.BC8793B1@zip.com.au>
	<20011108.231717.85686073.davem@redhat.com>
	<3BEB82B8.541558CA@zip.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Thu, 08 Nov 2001 23:16:08 -0800
   
   Well on my setup, there are more hash buckets than there are
   pages in the system.  So - basically empty.  If memory serves
   me, never more than two pages in a bucket.

Ok, this is what I expected.  The function is tuned for
having N_HASH_CHAINS being roughly equal to N_PAGES.

If you want to experiment with smaller hash tables, there
are some hacks in the FreeBSD sources that choose a different "salt"
per inode.  You xor the salt into the hash for each page on that
inode.  Something like this...

Franks a lot,
David S. Miller
davem@redhat.com
