Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWIBPaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWIBPaV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 11:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWIBPaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 11:30:21 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:29937 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750906AbWIBPaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 11:30:20 -0400
Date: Sun, 03 Sep 2006 00:32:10 +0900 (JST)
Message-Id: <20060903.003210.59464725.anemo@mba.ocn.ne.jp>
To: yoichi_yuasa@tripeaks.co.jp
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [-mm PATCH] mips: moved to GENERIC_TIME
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060831233108.5b5c9e66.yoichi_yuasa@tripeaks.co.jp>
References: <20060831233108.5b5c9e66.yoichi_yuasa@tripeaks.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006 23:31:08 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> This patch has moved to GENERIC_TIME about MIPS and has removed MIPS
> specific do_gettimeofday()/do_settimeofday().
> MIPS specific do_gettimeofday()/do_settimeofday() in 2.6.18-rc4-mm3
> have undefined reference problem.

This patch makes do_gettimeoffset() orphan and a resolution of
gettimeofday() will be downgraded to jiffies, unless you add more code
for clocksource infrastructure to MIPS.

If you just wanted to fix the "undefined reference problem", replacing
"tickadj" with 500 (max ntp adjustment time) would be enough.

---
Atsushi Nemoto

-- 
VGER BF report: U 0.498007
