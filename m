Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbVH2XQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbVH2XQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVH2XQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:16:00 -0400
Received: from mirapoint2.brutele.be ([212.68.199.149]:5143 "EHLO
	mirapoint2.brutele.be") by vger.kernel.org with ESMTP
	id S1751401AbVH2XP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:15:59 -0400
Date: Tue, 30 Aug 2005 01:14:17 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.6.13 : __check_region is deprecated
Message-ID: <20050829231417.GB2736@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.10i
X-Junkmail-Status: score=10/50, host=mirapoint2.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090203.43139450.0013-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=80=93=0B=08?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

By compiling my kernel, I can see that the __check_region function (in
kernel/resource.c) is deprecated.

With a grep on the source code of the last release, I get this result.

drivers/pnp/resource.c:255:             if (__check_region(&ioport_resource, *port, length(port,end))) 
include/linux/ioport.h:117:#define check_mem_region(start,n) __check_region(&iomem_resource, (start), (n))
include/linux/ioport.h:120:extern int __check_region(struct resource *, unsigned long, unsigned long);
include/linux/ioport.h:125:     return __check_region(&ioport_resource, s, n);
kernel/resource.c:468:int __deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
kernel/resource.c:481:EXPORT_SYMBOL(__check_region);

Is there a function to replace this deprecated function ?

Why is it deprecated ?

Best Regards, 

Stephane

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
                <stephane.wirtel@gmail.com>


