Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTENUQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbTENUQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:16:59 -0400
Received: from web40503.mail.yahoo.com ([66.218.78.120]:13972 "HELO
	web40503.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262776AbTENUQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:16:58 -0400
Message-ID: <20030514202941.39519.qmail@web40503.mail.yahoo.com>
Date: Wed, 14 May 2003 13:29:41 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: link error building kernel with gcc-3.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following linking 2.4.21rc1:

net/network.o(.text+0xdcb7): In function `rtnetlink_rcv':
: undefined reference to `rtnetlink_rcv_skb'
make: *** [vmlinux] Error 1

Removing '__inline__' from the definition of rtnetlink_rcv_skb
in net/core/rtnetlink.c fixed the problem. 

Note: this error also occurs in 2.4.21rc2-ac2

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
