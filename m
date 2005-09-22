Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbVIVP1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbVIVP1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbVIVP1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:27:16 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:242 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1030403AbVIVP1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:27:15 -0400
Date: Fri, 23 Sep 2005 00:25:48 +0900 (JST)
Message-Id: <20050923.002548.126141978.anemo@mba.ocn.ne.jp>
To: thockin@hockin.org
Cc: scampbell@malone.edu, linux-kernel@vger.kernel.org
Subject: Re: PCI Express or TG3 issue
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050921181151.GA809@hockin.org>
References: <15F23A40330F5742B268A041F003055705D2A3@srv-elijah1.malone.int>
	<20050921181151.GA809@hockin.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 21 Sep 2005 11:11:51 -0700, thockin@hockin.org said:

thockin> This device is claiming that it has a 64-bit base-address
thockin> which has been programmed by BIOS to be at
thockin> 0x80000001d0000000.

thockin> I suspect that the 4 bytes at offset 0x14 want to be 0.  The
thockin> address 0xd0000000 jives with the rest of your PCI listing.

thockin> I don't know where that extra 0x80000001 comes from, but it's
thockin> pretty clearly wrong.  BIOS bug?  I can't see where kernel
thockin> would have boned that up *that* badly.

I also have seen same problem on some custom MIPS-based boards which
do not have BIOS.  Broadcom BCM5751 had garbage in its 64-bit BAR on
power-up.  So it should not be a BIOS bug.  And I also could not find
any good place to fixup it at that time.

---
Atsushi Nemoto
