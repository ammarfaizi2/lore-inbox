Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWC2GIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWC2GIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 01:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWC2GIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 01:08:17 -0500
Received: from king.bitgnome.net ([70.84.111.244]:20142 "EHLO
	king.bitgnome.net") by vger.kernel.org with ESMTP id S1751085AbWC2GIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 01:08:16 -0500
Date: Wed, 29 Mar 2006 00:08:16 -0600
From: Mark Nipper <nipsy@bitgnome.net>
To: linux-kernel@vger.kernel.org
Subject: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/...
Message-ID: <20060329060816.GB26340@king.bitgnome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Sorry, I forgot a subject last time.  Maybe this will get
a response instead.

        I'm seeing these in my logcheck output:
---
Mar 27 16:16:45 king kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (283)
Mar 27 16:16:45 king kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (150)
---

I also saw this with 2.6.14.5.  I found references on LKML about
this happening in 2.6.9 with regards to TSO and lowering
tcp_tso_win_divisor.  I'm not lowering any values via sysctl
(that I'm aware of anyway), so I'm not sure if I should worry
about this.

        Just a heads up in case this is a real problem.

-- 
Mark Nipper                                                e-contacts:
832 Tanglewood Drive                                nipsy@bitgnome.net
Bryan, Texas 77802-4013                     http://nipsy.bitgnome.net/
(979)575-3193                      AIM/Yahoo: texasnipsy ICQ: 66971617

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GG/IT d- s++:+ a- C++$ UBL++++$ P--->+++ L+++$ !E---
W++(--) N+ o K++ w(---) O++ M V(--) PS+++(+) PE(--)
Y+ PGP t+ 5 X R tv b+++@ DI+(++) D+ G e h r++ y+(**)
------END GEEK CODE BLOCK------

---begin random quote of the moment---
As a computer, I find your faith in technology amusing.
----end random quote of the moment----
