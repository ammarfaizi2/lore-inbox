Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281981AbRKZSEb>; Mon, 26 Nov 2001 13:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281987AbRKZSEM>; Mon, 26 Nov 2001 13:04:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17280 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281963AbRKZSEA>;
	Mon, 26 Nov 2001 13:04:00 -0500
Date: Mon, 26 Nov 2001 10:02:17 -0800 (PST)
Message-Id: <20011126.100217.112611573.davem@redhat.com>
To: mingo@elte.hu
Cc: velco@fadata.bg, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable page cache
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain>
In-Reply-To: <87elml4ssx.fsf@fadata.bg>
	<Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Mon, 26 Nov 2001 18:22:25 +0100 (CET)
   
   The problem with the tree is that if we have a big, eg. 16 GB pagecache,
   then even assuming a perfectly balanced tree, it takes more than 20
   iterations to find the page in the tree.

His tree is per-inode, so you'd need a fully in ram 16GB _FILE_ to get
the bad tree search properties you describe.

I like his patch, a lot.
