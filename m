Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270733AbUJUB4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270733AbUJUB4B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270647AbUJUBwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:52:12 -0400
Received: from mf2.realtek.com.tw ([220.128.56.22]:52742 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S270773AbUJUBuI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:50:08 -0400
Message-ID: <005201c4b710$448c9480$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: "Ian Campbell" <icampbell@arcom.com>
Cc: <linux-kernel@vger.kernel.org>
References: <002101c4b6ad$9fe6d880$8b1a13ac@realtek.com.tw> <1098282591.29412.1706.camel@icampbell-debian>
Subject: Re: [*VIP*] Re: Strange! Cannot use JFFS2 as root
Date: Thu, 21 Oct 2004 09:49:48 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/10/21 =?Bog5?B?pFekyCAwOTo1MTowNw==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/10/21
 =?Bog5?B?pFekyCAwOTo1MTowOQ==?=,
	Serialize complete at 2004/10/21 =?Bog5?B?pFekyCAwOTo1MTowOQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ian,
Thank you. It works by your way.
I had already tried "root=1f:01" and it didn't work, and then I spent whole
day to test it... :-(
It seems that "root=1f01" and "root=31:01" are both acceptable.

Thanks and regards,
Colin


----- Original Message ----- 
From: "Ian Campbell" <icampbell@arcom.com>
To: "colin" <colin@realtek.com.tw>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, October 20, 2004 10:29 PM
Subject: [*VIP*] Re: Strange! Cannot use JFFS2 as root


> > I traced the code and found that when passing "/dev/mtdblock1" to
> > name_to_dev_t() in do_mounts.c, it would return 0 at every try_name(),
which
> > will fail at open() with the path "/sys/block/%s/dev".
> >
> > What's the problem? Could anyone tell me?
>
> If I remember correctly you need to pass the root in as the major and
> minor numbers for jffs2 on 2.6. For example my 2.6 command line is
> root=31:03 rootfstype=jffs2 ro console=ttyS0,115200
> rather that root=/dev/mtdblock3.
>
> I can't remember why this is the case though.
>
> Ian.
> -- 
> Ian Campbell, Senior Design Engineer
>                                         Web: http://www.arcom.com
> Arcom, Clifton Road, Direct: +44 (0)1223 403 465
> Cambridge CB1 7EA, United Kingdom Phone:  +44 (0)1223 411 200
>

