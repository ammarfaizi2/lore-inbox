Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbTG3LL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270218AbTG3LL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:11:27 -0400
Received: from web20401.mail.yahoo.com ([66.163.169.89]:37721 "HELO
	web20413.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267517AbTG3LL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:11:26 -0400
Message-ID: <20030730111125.3876.qmail@web20413.mail.yahoo.com>
Date: Wed, 30 Jul 2003 04:11:25 -0700 (PDT)
From: devnetfs <devnetfs@yahoo.com>
Subject: question on panic()?
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am writing a module and want to truly panic the machine in case
of critical errors. I used the panic() function. But after
panic() is called and panic() does its job, I am still able
to ping to this box from outside.

Looking at the panic() function, it looks all cpus _except_
the one on which panic() got called are halted ("hlt"). and
interrupts are reenabled on _this_ CPU, hence NIC interrupts
are allowed and pkts sent out in response to ping.

Why is this done? should'nt panic() halt all the CPUs?
And is there any way to halt all cpus? (can't do that after
called panic() as its NORET!). I am working on RH 2.4.X kernel.
(AFAIK this has not changed in 2.5 too).

Thanks in Advance,
A.

PS: please Cc: me the reply. I am not subscribed to lkml.

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
