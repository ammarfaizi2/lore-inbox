Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319813AbSIMWQg>; Fri, 13 Sep 2002 18:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319814AbSIMWQg>; Fri, 13 Sep 2002 18:16:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49613 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319813AbSIMWQf>;
	Fri, 13 Sep 2002 18:16:35 -0400
Date: Fri, 13 Sep 2002 15:13:06 -0700 (PDT)
Message-Id: <20020913.151306.40776578.davem@redhat.com>
To: defouwj@purdue.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.0-2.5 bug in ip_options_compile
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020913220838.GA1579@blorp.plorb.com>
References: <20020913220838.GA1579@blorp.plorb.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff DeFouw <defouwj@purdue.edu>
   Date: Fri, 13 Sep 2002 17:08:38 -0500

   While reading about IP options, I found the IPOPT_END padding (cleaning)
   in ip_options_compile (net/ipv4/ip_options.c) was not incrementing a
   pointer.  There should be an optptr++ in the for end-of-block statement
   to go along with the l--, otherwise it's just comparing the same byte
   for each l.  Patch is against 2.4.19.  From the kernel source browser
   this bug is also in 2.5.31, 2.2.21, and 2.0.39.

Thanks a lot for spotting this, I will add this
to my 2.4.x and 2.5.x trees and merge upstream.
