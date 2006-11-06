Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbWKFHox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbWKFHox (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 02:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWKFHox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 02:44:53 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:45024 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S932785AbWKFHox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 02:44:53 -0500
Date: Mon, 06 Nov 2006 16:44:49 +0900 (JST)
Message-Id: <20061106.164449.82358719.nemoto@toshiba-tops.co.jp>
To: linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org, stable@vger.kernel.org
Subject: 2.6.18.1 broke "make O=... headers_install"
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I found that this commit in 2.6.18.1 broke headers_install target
with "O=...".

> author	David Woodhouse <dwmw2@infradead.org>
> 	Thu, 21 Sep 2006 08:01:45 +0000 (09:01 +0100)
> commit	a52e3e65718818dfe84b5509ae3f65737decb14b
> Don't advertise (or allow) headers_{install,check} where inappropriate.

This problem was already fixed since 2.6.19-rc2, so please backport
this fix to -stable tree.  Thank you.

> author	David Woodhouse <dwmw2@infradead.org>
> 	Fri, 13 Oct 2006 15:04:23 +0000 (16:04 +0100)
> commit	0e7af8d04ecb4f6ba8cd1f731f036a004ad0e174
> [PATCH] Fix headers_check for O= builds; disable automatic check on UML.

---
Atsushi Nemoto
