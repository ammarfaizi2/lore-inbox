Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWFTEh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWFTEh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 00:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWFTEh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 00:37:29 -0400
Received: from mf2.realtek.com.tw ([60.248.182.46]:21769 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S964917AbWFTEh2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 00:37:28 -0400
Message-ID: <004301c69423$365d53d0$106215ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <045101c69108$4992a130$106215ac@realtek.com.tw> <1150709551.2503.6.camel@localhost.localdomain>
Subject: Re: UDF filesystem has some bugs on truncating
Date: Tue, 20 Jun 2006 12:37:18 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/06/20 =?Bog5?B?pFWkyCAxMjozNzoxOA==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/06/20 =?Bog5?B?pFWkyCAxMjozNzoyMQ==?=,
	Serialize complete at 2006/06/20 =?Bog5?B?pFWkyCAxMjozNzoyMQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,
Do you use the same command with me?
The parameter "seek" of "dd if=/dev/zero of=aaa bs=1024k count=2 seek=3000"
will inform "dd" to use truncate system call to expand file in no time.
In normal situations, the file will grow up to 3G in about 2 seconds.
This dd command on ext3 partition can run very well on my platform, but it
will fail on UDF partition.

Regards,
Colin


----- Original Message ----- 
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "colin" <colin@realtek.com.tw>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, June 19, 2006 5:32 PM
Subject: Re: UDF filesystem has some bugs on truncating


> Ar Gwe, 2006-06-16 am 13:47 +0800, ysgrifennodd colin:
> > Hi all,
> > I found that UDF has bugs on truncating.
> > When you do this:
> >     dd if=/dev/zero of=aaa bs=1024k count=2 seek=3000
> > , Linux will hang and die.
> > The platform is Linux 2.6.16 on MIPS malta board.
>
> Ok I eventually sort of reproduced this on x86-64. It took a while
> because in my environment I see a crash 2 or 3 hours after the test is
> run, and that crash is on hardware that doesn't otherwise crash and
> seems to be repeatable.
>
> Alan
>

