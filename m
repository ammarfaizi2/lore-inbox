Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUEVJYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUEVJYK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 05:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUEVJYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 05:24:10 -0400
Received: from outmx007.isp.belgacom.be ([195.238.3.234]:40869 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264937AbUEVJXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 05:23:37 -0400
Subject: Re: [PATCH 2.6.6-mm4] ring_info spinlock initialization
From: FabF <Fabian.Frederick@skynet.be>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405211611580.2864@montezuma.fsmlabs.com>
References: <1085167134.7954.3.camel@bluerhyme.real3>
	 <Pine.LNX.4.58.0405211611580.2864@montezuma.fsmlabs.com>
Content-Type: multipart/mixed; boundary="=-Hrl7Ygg0TkEhOyKBOrdY"
Message-Id: <1085217684.9559.11.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 22 May 2004 11:21:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hrl7Ygg0TkEhOyKBOrdY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-05-21 at 22:12, Zwane Mwaikambo wrote:
> On Fri, 21 May 2004, FabF wrote:
> 
> > Hi,
> > 	ring_info spinlock was not initialized in INIT_KIOCTX.
> 
> Shouldn't something have caught that?

Zwane,
	Did you find something about that thread ? I don't see anything
relevant in mm5 :(

Regards,
FabF

> 
> 	Zwane
> 
> 

--=-Hrl7Ygg0TkEhOyKBOrdY
Content-Disposition: attachment; filename=inittask1.diff
Content-Type: text/x-patch; name=inittask1.diff; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/include/linux/init_task.h edited/include/linux/init_task.h
--- orig/include/linux/init_task.h	2004-05-10 04:32:00.000000000 +0200
+++ edited/include/linux/init_task.h	2004-05-21 14:26:56.000000000 +0200
@@ -29,6 +29,7 @@
 	.ctx_lock	= SPIN_LOCK_UNLOCKED,		\
 	.reqs_active	= 0U,				\
 	.max_reqs	= ~0U,				\
+	.ring_info.ring_lock = SPIN_LOCK_UNLOCKED	\
 }
 
 #define INIT_MM(name) \

--=-Hrl7Ygg0TkEhOyKBOrdY--

