Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVA3NFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVA3NFV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 08:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVA3NFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 08:05:20 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:7879 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S261701AbVA3NFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 08:05:04 -0500
Date: Sun, 30 Jan 2005 22:05:37 +0900 (JST)
Message-Id: <20050130.220537.45151614.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [PATCH] Fix SERIAL_TXX9 dependencies
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050130001555.GA3648@linux-mips.org>
References: <20050129131134.75dacb41.akpm@osdl.org>
	<20050129231255.GA3185@stusta.de>
	<20050130001555.GA3648@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 30 Jan 2005 00:15:55 +0000, Ralf Baechle <ralf@linux-mips.org> said:
ralf> Ask for SERIAL_TXX9 only on those devices that actually have
ralf> one.

Well, "depends on MIPS || PCI" was intentional.  The driver can be
used for both TX39/TX49 internal SIO and TC86C001 PCI chip.  TC86C001
chip can be available for any platform with PCI bus (though I have
never seen it on platform other than MIPS ...)

So I suppose "depends on HAS_TXX9_SERIAL || PCI" might be better, but
Ralf's patch will be OK for now.

Thank you.
---
Atsushi Nemoto
