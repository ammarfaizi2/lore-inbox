Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTEOFZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 01:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTEOFZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 01:25:36 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:48656 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263578AbTEOFZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 01:25:35 -0400
Date: Thu, 15 May 2003 15:38:15 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Alex Davis <alex14641@yahoo.com>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
Subject: Re: link error building kernel with gcc-3.3
In-Reply-To: <20030514202941.39519.qmail@web40503.mail.yahoo.com>
Message-ID: <Mutt.LNX.4.44.0305151536280.12417-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Alex Davis wrote:

> I got the following linking 2.4.21rc1:
> 
> net/network.o(.text+0xdcb7): In function `rtnetlink_rcv':
> : undefined reference to `rtnetlink_rcv_skb'
> make: *** [vmlinux] Error 1
> 
> Removing '__inline__' from the definition of rtnetlink_rcv_skb
> in net/core/rtnetlink.c fixed the problem. 
> 
> Note: this error also occurs in 2.4.21rc2-ac2

I wonder, does this mean that the compiler failed to inline the function?

Removing __inline__ is not the correct solution.


- James
-- 
James Morris
<jmorris@intercode.com.au>

