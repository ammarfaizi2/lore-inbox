Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbTBVLT6>; Sat, 22 Feb 2003 06:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267883AbTBVLT6>; Sat, 22 Feb 2003 06:19:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31959 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266939AbTBVLT5>;
	Sat, 22 Feb 2003 06:19:57 -0500
Date: Sat, 22 Feb 2003 03:13:26 -0800 (PST)
Message-Id: <20030222.031326.103246837.davem@redhat.com>
To: kazunori@miyazawa.org
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi-core@linux-ipv6.org, kunihiro@ipinfusion.com
Subject: Re: [PATCH] IPv6 IPSEC support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030222202623.38d41d8a.kazunori@miyazawa.org>
References: <20030222202623.38d41d8a.kazunori@miyazawa.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Kazunori Miyazawa <kazunori@miyazawa.org>
   Date: Sat, 22 Feb 2003 20:26:23 +0900

   I also moved the functions for ah, and esp.

I don't think this is so good idea...
   
   As a result of moving IPv6 IPsec functions to net/ipv4, it currently prevents to
   make IPv6 as a module.
   
This is one of the reasons why ah/esp ipv6 should stay under ipv6.

Nothing in xfrm routines really need to reference ipv6 module
functions, please eliminate this dependency.  Breaking ipv6 as module
is ok for temporary development, but eventually it must be solved.
