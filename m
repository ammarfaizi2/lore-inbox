Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVI0Orl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVI0Orl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVI0Ork
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:47:40 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:26326 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S964951AbVI0Ork (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:47:40 -0400
Date: Tue, 27 Sep 2005 23:46:16 +0900 (JST)
Message-Id: <20050927.234616.36922370.anemo@mba.ocn.ne.jp>
To: stern@rowland.harvard.edu
Cc: jim.ramsay@gmail.com, mdharm-kernel@one-eyed-alien.net,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [Linux-usb-users] Possible bug in usb storage (2.6.11 kernel)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.44L0.0509271020180.5703-100000@iolanthe.rowland.org>
References: <20050927.223801.130240000.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.44L0.0509271020180.5703-100000@iolanthe.rowland.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 27 Sep 2005 10:21:17 -0400 (EDT), Alan Stern <stern@rowland.harvard.edu> said:

stern> Yes I did.  You can see it at
stern> https://lists.one-eyed-alien.net/pipermail/usb-storage/2005-September/001953.html

Thank you.  But 'kmalloc(US_SENSE_SIZE, GFP_KERNEL)' is not enough (at
least) for MIPS since some MIPS chips have 32 byte cacheline and
ARCH_KMALLOC_MINALIGN is 8 on linux-mips.

Using 'max(dma_get_cache_alignment(), US_SENSE_SIZE)' would be OK.

---
Atsushi Nemoto
