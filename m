Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269400AbUIIJpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269400AbUIIJpt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 05:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269399AbUIIJpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 05:45:49 -0400
Received: from mf2.realtek.com.tw ([220.128.56.22]:35592 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S269400AbUIIJpY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 05:45:24 -0400
Message-ID: <00bb01c49651$b7525480$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
References: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw> <1094721529.2801.6.camel@laptop.fenrus.com>
Subject: Re: Re: What File System supports Application XIP
Date: Thu, 9 Sep 2004 17:45:13 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/09/09 =?Big5?B?pFWkyCAwNTo0NjoxNw==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/09/09
 =?Big5?B?pFWkyCAwNTo0NjoxOQ==?=,
	Serialize complete at 2004/09/09 =?Big5?B?pFWkyCAwNTo0NjoxOQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
How does ramfs offer application XIP ability?
I mean, when the ramfs image is mounted and the application in it is
executed,
"exec", which is called by sh, should first copy every section of the
application to RAM and then jump to the text section.
How do I avoid the stage copying text section to RAM?

Thanks and regards,
Colin

----- Original Message ----- 
From: "Arjan van de Ven" <arjanv@redhat.com>
To: "colin" <colin@realtek.com.tw>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, September 09, 2004 5:18 PM
Subject: Re: What File System supports Application XIP

> On Thu, 2004-09-09 at 10:55, colin wrote:
> > Hi there,
> > We are developing embedded Linux system. Performance is our
consideration.
> > We hope some applications can run as fast as possible,

> well ramfs by definition is XIP :)

> but I guess the filesystem comes from flash somewhere at which point
> jffs2 with compression might be a better choice; if you have enough ram
> then the apps run from the pagecache anyway and compression keeps you
> from transfering too much data from the slower flash. It's not XIP but I
> don't think you really want XIP...


