Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVHHHS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVHHHS2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 03:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVHHHS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 03:18:28 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22499 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750741AbVHHHS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 03:18:27 -0400
Date: Mon, 8 Aug 2005 09:18:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "James C. Georgas" <jgeorgas@rogers.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: Inclusion order patch
In-Reply-To: <1123296769.17282.36.camel@Tachyon.home>
Message-ID: <Pine.LNX.4.61.0508080914450.18088@yvahk01.tjqt.qr>
References: <1123295768.17282.29.camel@Tachyon.home> <1123296769.17282.36.camel@Tachyon.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This patch lets this header stand alone, since I can never remember
>which other headers to include, or in which order.

I have seen the same in a lot of other places. For some self-baked patch, I 
added <linux/security.h> to the front of includes and promptly got flooded 
with warnings.

IMO, every H (and every C) file should have all the includes that are 
necessary to get at enums, structs, etc. even if other H files do this.
I'd volunteer to do this. What's LKMLs and the big guys' opinion?

>@@ -2,6 +2,12 @@
> #define _LINUX_CDEV_H
> #ifdef __KERNEL__
>
>+#include <linux/kobject.h>
>+#include <linux/list.h>
>+#include <linux/types.h>
>+
>+struct inode;

+ struct module;

>+
> struct cdev {
>        struct kobject kobj;
>        struct module *owner;


Jan Engelhardt
-- 
