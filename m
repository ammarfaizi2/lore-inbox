Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbTC0TcK>; Thu, 27 Mar 2003 14:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261304AbTC0TcK>; Thu, 27 Mar 2003 14:32:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20710 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261296AbTC0TcI>;
	Thu, 27 Mar 2003 14:32:08 -0500
Date: Thu, 27 Mar 2003 11:39:33 -0800 (PST)
Message-Id: <20030327.113933.123322481.davem@redhat.com>
To: torvalds@transmeta.com
Cc: dane@aiinet.com, shmulik.hen@intel.com,
       bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       mingo@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0303271120230.31459-100000@home.transmeta.com>
References: <20030327.111012.23672715.davem@redhat.com>
	<Pine.LNX.4.44.0303271120230.31459-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Thu, 27 Mar 2003 11:22:55 -0800 (PST)

   	if (gfp_mask & __GFP_WAIT)
   		might_sleep();
   
   and might_sleep() should be updated.
   
   Anybody want to try that and see whether things break horribly?

I hadn't considered this, good idea.  I'm trying this out right now.

Someone should backport the might_sleep() stuff to 2.4.x, it's very
useful.
