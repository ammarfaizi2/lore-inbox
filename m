Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTAPHWI>; Thu, 16 Jan 2003 02:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTAPHWI>; Thu, 16 Jan 2003 02:22:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25266 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261907AbTAPHWH>;
	Thu, 16 Jan 2003 02:22:07 -0500
Date: Wed, 15 Jan 2003 23:21:04 -0800 (PST)
Message-Id: <20030115.232104.52604347.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __cacheline_aligned_in_smp? 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030115082444.0CFFA2C123@lists.samba.org>
References: <20030113.223253.18825371.davem@redhat.com>
	<20030115082444.0CFFA2C123@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Wed, 15 Jan 2003 19:02:20 +1100

   > I want alignment on cache line boundary, and I don't want anything
   > else in that cacheline.
   
   A "read-mostly" section might be appropriate, then.  Of course, you'd
   have to split the structure, in that case, and it's not worth it if
   there are only a few of these.
   
   Have I finally got it through my thick skull now?

I think so.  A read-mostly section would allow us to exploit this
more for other things.

BTW, the tcp_hashinfo struct exists only because the linker could
otherwise legally reorder data section members.
