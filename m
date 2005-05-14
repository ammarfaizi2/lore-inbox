Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVENOKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVENOKv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 10:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVENOHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 10:07:37 -0400
Received: from cmsout02.mbox.net ([165.212.64.32]:19451 "EHLO
	cmsout02.mbox.net") by vger.kernel.org with ESMTP id S262640AbVENOGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 10:06:40 -0400
X-USANET-Source: 165.212.11.131  IN   matt@finaldraftbooks.com uadvg131.cms.usa.net
X-USANET-MsgId: XID236JeNogn3817X02
X-USANET-Auth: 67.20.172.234   AUTH mrsinger@usa.net PlanetX
Reply-To: <matt@finaldraftbooks.com>
From: "Matthew Singer" <matt@finaldraftbooks.com>
To: "'linux-kernel-Mailing-list'" <linux-kernel@vger.kernel.org>,
       <linux-smp@vger.kernel.org>
Subject: SMP Large Buffers
Date: Sat, 14 May 2005 10:06:34 -0400
Organization: Final Draft Booksellers
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcVYjZlh3GFp9ubZSRC9nzoBUOhqUw==
Message-ID: <127JeNogl0267M31@uadvg131.cms.usa.net>
Z-USANET-MsgId: XID127JeNogM0267X31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working with a driver that needs dma buffers larger than 128K.  The
system is a 2 processor SMP with 2 gig total ram.

Using GRUB, we set mem= to be 1984M, leaving 64M reserved.

doing  ioremap(0x7c000000, 0x4000000)
       followed by an access to x7c000000 results in an OOPS.

is this an SMP issue regarding how memory in each node is mapped? (in that
you can't do it this way) as it works fine on a uniprocessor machine.






