Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbVI0TmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVI0TmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 15:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVI0TmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 15:42:16 -0400
Received: from [83.64.192.57] ([83.64.192.57]:17969 "EHLO
	mail1.futuredesign.at") by vger.kernel.org with ESMTP
	id S965040AbVI0TmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 15:42:15 -0400
Message-ID: <017101c5c39b$95699900$1b00a8c0@FRSNOTI>
From: "Bernhard C. Schrenk" <rlx@clemy.org>
To: "Lukasz Kosewski" <lkosewsk@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <355e5e5e05092618018840fc3@mail.gmail.com>
Subject: Re: [PATCH 2/3] Add disk hotswap support to libata RESEND #5
Date: Tue, 27 Sep 2005 21:42:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

I tested your previous version of this patch on an AMD64. I found one 64 bit
bug, crashing the kernel. After fixing it, it worked quite well.

Please change in the file libata-core.c the line

ap->hotplug_timer.data = (unsigned int)ap;

to

ap->hotplug_timer.data = (unsigned long)ap;

Thanks for this great patch,
Bernhard

