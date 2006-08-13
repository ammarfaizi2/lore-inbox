Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbWHMAqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWHMAqf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 20:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWHMAqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 20:46:34 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22429
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932633AbWHMAqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 20:46:32 -0400
Date: Sat, 12 Aug 2006 17:46:51 -0700 (PDT)
Message-Id: <20060812.174651.113732891.davem@davemloft.net>
To: a.p.zijlstra@chello.nl
Cc: johnpol@2ka.mipt.ru, riel@redhat.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       phillips@google.com
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
From: David Miller <davem@davemloft.net>
In-Reply-To: <1155377887.13508.27.camel@lappy>
References: <1155374390.13508.15.camel@lappy>
	<20060812093706.GA13554@2ka.mipt.ru>
	<1155377887.13508.27.camel@lappy>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Sat, 12 Aug 2006 12:18:07 +0200

> 65535 sockets * 128 packets * 16384 bytes/packet = 
> 1^16 * 1^7 * 1^14 = 1^(16+7+14) = 1^37 = 128G of memory per IP
> 
> And systems with a lot of IP numbers are not unthinkable.

TCP restricts the amount of global memory that may be consumed
by all TCP sockets via the tcp_mem[] sysctl.

Otherwise several forms of DoS attacks would be possible.
