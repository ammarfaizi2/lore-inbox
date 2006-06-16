Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWFPFr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWFPFr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 01:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWFPFr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 01:47:26 -0400
Received: from mf2.realtek.com.tw ([60.248.182.46]:27665 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S1750980AbWFPFrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 01:47:25 -0400
Message-ID: <045101c69108$4992a130$106215ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: UDF filesystem has some bugs on truncating
Date: Fri, 16 Jun 2006 13:47:00 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/06/16 =?Bog5?B?pFWkyCAwMTo0NzowMA==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/06/16 =?Bog5?B?pFWkyCAwMTo0NzowNQ==?=,
	Serialize complete at 2006/06/16 =?Bog5?B?pFWkyCAwMTo0NzowNQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
I found that UDF has bugs on truncating.
When you do this:
    dd if=/dev/zero of=aaa bs=1024k count=2 seek=3000
, Linux will hang and die.
The platform is Linux 2.6.16 on MIPS malta board.

Regards,
Colin

