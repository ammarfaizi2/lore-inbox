Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTCEXNB>; Wed, 5 Mar 2003 18:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTCEXNB>; Wed, 5 Mar 2003 18:13:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30141 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262821AbTCEXNA>;
	Wed, 5 Mar 2003 18:13:00 -0500
Date: Wed, 05 Mar 2003 15:03:44 -0800 (PST)
Message-Id: <20030305.150344.50145701.davem@redhat.com>
To: Rod.VanMeter@nokia.com
Cc: bunk@fs.tum.de, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Chaotic structure of the net headers?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1046905834.17778.400.camel@localhost.localdomain>
References: <20030305225441.GO20423@fs.tum.de>
	<1046905834.17778.400.camel@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rod Van Meter <Rod.VanMeter@nokia.com>
   Date: 05 Mar 2003 15:10:35 -0800
   
   Does it make sense to have two forms, one kernel, one user?  I haven't
   e.g. followed the desired include chain.  If we wanted to merge the
   uses, the former form and include location would probably have to be
   used.
   
   I've been looking into this.  There are a *few* things missing from the
   2292 support.  AFAICT, it's just a handful of functions/macros for
   manipulating option headers that need to be added.

Actually forget all my comments, GLIBC headers are where
the advanced socket API requirements for headers should
be applied.

And since this is only used in the kernel, there is no need
for the NEXTHDR_* if it trully just duplicates the IPPROTO_*
defines.

I'm willing to accept a cleanup patch of this nature, sure.
