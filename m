Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSHCFEd>; Sat, 3 Aug 2002 01:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317469AbSHCFEd>; Sat, 3 Aug 2002 01:04:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22699 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317468AbSHCFEc>;
	Sat, 3 Aug 2002 01:04:32 -0400
Date: Fri, 02 Aug 2002 21:55:55 -0700 (PDT)
Message-Id: <20020802.215555.90364869.davem@redhat.com>
To: flo@rfc822.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 sparc ipv6 over ipv4 broken ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020802193610.GB30824@paradigm.rfc822.org>
References: <20020802193610.GB30824@paradigm.rfc822.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Florian Lohoff <flo@rfc822.org>
   Date: Fri, 2 Aug 2002 21:36:10 +0200

   i am having trouble to get a ipv6 over ipv4 tunnel to work
   on a linux/sparc with a vanilla 2.4.18 kernel - It seems
   there is something broken. The same setup works on i386. 

Unfortunately SIT tunnels use SIOCDEVPRIVATE ioctls which we can't
support in 32-bit programs runnign on sparc64 hardware.  Sorry.

Some day we'll add non-conflicting ioctls for SIT and other similar
devices using SIOCDEVPRIVATE but for now you're out of luck.
