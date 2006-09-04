Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWIDKTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWIDKTM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWIDKTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:19:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14054 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751361AbWIDKTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:19:09 -0400
Subject: Re: [PATCH][RFC] request_firmware examples and MODULE_FIRMWARE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Victor Hugo <victor@vhugo.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20060904083908.38953.qmail@web411.biz.mail.mud.yahoo.com>
References: <20060904083908.38953.qmail@web411.biz.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 11:41:42 +0100
Message-Id: <1157366503.30801.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-04 am 01:39 -0700, ysgrifennodd Victor Hugo:
> That said, here's the patch...
> 
> tatic void sample_firmware_load(char *firmware, int size)
+{
+       u8 buf[size + 1];
+       memcpy(buf, firmware, size);

Please don't use this GNUism in the kernel code. It makes it very hard
to tell how much is being put on the (limited) stack. Better to use
kmalloc explicitly or a fixed size.

Rest looks sane.


-- 
VGER BF report: H 1.48569e-10
